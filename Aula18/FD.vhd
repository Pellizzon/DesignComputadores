LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.constantesMIPS.ALL;

ENTITY FD IS
   PORT (
      -- para teste: simulacao
      PCout : OUT STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
      -----------------------
      clk                    : IN STD_LOGIC;
      barramentoDadosLeitura : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      barramentoEnderecos    : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      barramentoDadosEscrita : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      habLeituraMEM          : OUT STD_LOGIC;
      habEscritaMEM          : OUT STD_LOGIC
   );
END ENTITY;

ARCHITECTURE rtl OF FD IS

   SIGNAL ProxPC  : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL saidaPC : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);

   SIGNAL bancoA_ULA, bancoB_ULA : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL saidaULA : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   SIGNAL flagZero : STD_LOGIC;

   SIGNAL instrucao : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   -- Para instrucoes tipo R
   -- opCode [31 ~ 26]
   -- Rs     [25 ~ 21]
   -- Rt     [20 ~ 16]
   -- Rd     [15 ~ 11]
   -- shamt  [10 ~  6]
   -- funct  [ 5 ~  0]
   ALIAS opCode : STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0) IS instrucao(31 DOWNTO 26);
   ALIAS rs     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(25 DOWNTO 21);
   ALIAS rt     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(20 DOWNTO 16);
   ALIAS rd     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(15 DOWNTO 11);
   ALIAS shamt  : STD_LOGIC_VECTOR(SHAMT_WIDTH - 1 DOWNTO 0) IS instrucao(10 DOWNTO 6);
   ALIAS funct  : STD_LOGIC_VECTOR(FUNCT_WIDTH - 1 DOWNTO 0) IS instrucao(5 DOWNTO 0);

   -- Para instrucoes tipo I (OpCode e registradores ja definidos para do tipo R)
   -- opCode [31 ~ 26]
   -- Rs     [25 ~ 21]
   -- Rt     [20 ~ 16]
   -- Imed   [15 ~  0]
   ALIAS Imediato : STD_LOGIC_VECTOR(IMED_WIDTH - 1 DOWNTO 0) IS instrucao(IMED_WIDTH - 1 DOWNTO 0);

   -- Para instruções tipo J
   -- opCode [31 ~ 26]
   -- ImedJmp[25 ~  0]
   ALIAS ImedJmp : STD_LOGIC_VECTOR(IMED_JMP_WIDTH - 1 DOWNTO 0) IS instrucao(IMED_JMP_WIDTH - 1 DOWNTO 0);

   SIGNAL palavraControle : STD_LOGIC_VECTOR(9 DOWNTO 0);

   ALIAS selMUX_PC      : STD_LOGIC IS palavraControle(9);
   ALIAS BEQ            : STD_LOGIC IS palavraControle(8);
   ALIAS selULA_MEM     : STD_LOGIC IS palavraControle(7);
   ALIAS selMux_Rt_Imed : STD_LOGIC IS palavraControle(6);
   ALIAS selRt_Rd       : STD_LOGIC IS palavraControle(5);
   ALIAS writeRegC      : STD_LOGIC IS palavraControle(4);
   ALIAS ctrlUC_ULA     : STD_LOGIC_VECTOR(1 DOWNTO 0) IS palavraControle(3 DOWNTO 2);
   ALIAS memRd          : STD_LOGIC IS palavraControle(1);
   ALIAS memWr          : STD_LOGIC IS palavraControle(0);

   SIGNAL aluOp : STD_LOGIC_VECTOR(2 DOWNTO 0);

   SIGNAL EndRegC         : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL dataToWriteReg3 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   SIGNAL ULA_IN_B        : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL extImediato : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL beqShift       : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL BranchPC       : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL saidaMuxPC_BEQ : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL selMUX_PC_BEQ  : STD_LOGIC;

   SIGNAL AddrJmp    : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL saidaMuxPC : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
BEGIN

   -- para testes: simulacao
   PCout <= saidaPC;
   --

   AddrJmp <= ProxPc(31 DOWNTO 28) & ImedJmp & b"00";

   MuxJmp_PC_BEQ : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => ADDR_WIDTH
         ) PORT MAP(
         entradaA_MUX => saidaMuxPC_BEQ,
         entradaB_MUX => AddrJmp,
         seletor_MUX  => selMUX_PC,
         saida_MUX    => saidaMuxPC
      );

   IncPC : ENTITY work.somaConstante
      GENERIC MAP(
         larguraDados => ADDR_WIDTH,
         constante    => 4
         ) PORT MAP(
         entrada => saidaPC,
         saida   => ProxPC
      );

   PC : ENTITY work.registradorGenerico
      GENERIC MAP(
         larguraDados => ADDR_WIDTH
         ) PORT MAP(
         DIN    => saidaMuxPC,
         DOUT   => saidaPC,
         ENABLE => '1',
         CLK    => clk,
         RST    => '0'
      );

   ROM : ENTITY work.ROMMIPS
      GENERIC MAP(
         dataWidth       => DATA_WIDTH,
         addrWidth       => ADDR_WIDTH,
         memoryAddrWidth => 6
         ) PORT MAP(
         Endereco => saidaPC,
         Dado     => instrucao
      );

   Mux_ULA_MEM : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => DATA_WIDTH
         ) PORT MAP(
         entradaA_MUX => saidaULA,
         entradaB_MUX => barramentoDadosLeitura,
         seletor_MUX  => selULA_MEM,
         saida_MUX    => dataToWriteReg3
      );

   ExtensorSinal : ENTITY work.extendeSinalGenerico
      GENERIC MAP(
         larguraDadoEntrada => IMED_WIDTH,
         larguraDadoSaida   => DATA_WIDTH
         ) PORT MAP(
         estendeSinal_IN  => Imediato,
         estendeSinal_OUT => extImediato
      );

   beqShift <= extImediato(29 DOWNTO 0) & b"00";

   SomadorPCImed : ENTITY work.somadorGenerico
      GENERIC MAP(
         larguraDados => ADDR_WIDTH
         ) PORT MAP(
         entradaA => beqShift,
         entradaB => ProxPC,
         saida    => BranchPC
      );

   selMUX_PC_BEQ <= BEQ AND flagZero;

   MUX_PC_BEQ : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => ADDR_WIDTH
         ) PORT MAP(
         entradaA_MUX => ProxPC,
         entradaB_MUX => BranchPC,
         seletor_MUX  => selMUX_PC_BEQ,
         saida_MUX    => saidaMuxPC_BEQ
      );

   MUX_Rt_Rd : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => REGBANK_ADDR_WIDTH
         ) PORT MAP(
         entradaA_MUX => rt,
         entradaB_MUX => rd,
         seletor_MUX  => selRt_Rd,
         saida_MUX    => EndRegC
      );

   BancoRegistradores : ENTITY work.bancoRegistradores
      GENERIC MAP(
         larguraDados        => DATA_WIDTH,
         larguraEndBancoRegs => REGBANK_ADDR_WIDTH
         ) PORT MAP(
         clk => clk,
         --
         enderecoA => rs,
         enderecoB => rt,
         enderecoC => EndRegC,
         --
         dadoEscritaC => dataToWriteReg3,
         --
         escreveC => writeRegC,
         saidaA   => bancoA_ULA,
         saidaB   => bancoB_ULA
      );

   Mux_Rt_Imed : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => DATA_WIDTH
         ) PORT MAP(
         entradaA_MUX => bancoB_ULA,
         entradaB_MUX => extImediato,
         seletor_MUX  => selMux_Rt_Imed,
         saida_MUX    => ULA_IN_B
      );

   ULA : ENTITY work.ULA
      GENERIC MAP(
         dataWidth => DATA_WIDTH
         ) PORT MAP(
         entradaA => bancoA_ULA,
         entradaB => ULA_IN_B,
         seletor  => aluOp,
         saida    => saidaULA,
         flagZero => flagZero
      );

   ALU_UC : ENTITY work.aluUC
      PORT MAP(
         ctrlUC_ULA => ctrlUC_ULA,
         funct      => funct,
         aluOp      => aluOp
      );

   FD_UC : ENTITY work.UC
      PORT MAP(
         opCode          => opCode,
         palavraControle => palavraControle
      );

   barramentoEnderecos    <= saidaULA;
   barramentoDadosEscrita <= bancoB_ULA;
   habLeituraMEM          <= memRd;
   habEscritaMEM          <= memWr;
END ARCHITECTURE;