LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.constantesMIPS.ALL;

ENTITY FD IS
   PORT (
      clk           : IN STD_LOGIC;
      dataFromRAM   : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      AddrRAM       : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      dataToRAM     : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
      habLeituraMEM : OUT STD_LOGIC;
      habEscritaMEM : OUT STD_LOGIC
   );
END ENTITY;

ARCHITECTURE rtl OF FD IS

   SIGNAL ProxPC  : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL saidaPC : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);

   SIGNAL bancoA_ULA, bancoB_ULA : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL saidaULA : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   SIGNAL flagZero : STD_LOGIC;

   SIGNAL instrucao : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   -- para instrucoes tipo R
   ALIAS opCode : STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0) IS instrucao(31 DOWNTO 26);
   ALIAS rs     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(25 DOWNTO 21);
   ALIAS rt     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(20 DOWNTO 16);
   ALIAS rd     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(15 DOWNTO 11);
   ALIAS shamt  : STD_LOGIC_VECTOR(SHAMT_WIDTH - 1 DOWNTO 0) IS instrucao(10 DOWNTO 6);
   ALIAS funct  : STD_LOGIC_VECTOR(FUNCT_WIDTH - 1 DOWNTO 0) IS instrucao(5 DOWNTO 0);

   -- para instrucoes tipo I (OpCode e registradores ja definidos para do tipo R)
   -- ALIAS opCode : std_logic_vector(OPCODE_WIDTH - 1 DOWNTO 0) IS instrucao(31 DOWNTO 26);
   -- ALIAS rs     : std_logic_vector(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(25 DOWNTO 21);
   -- ALIAS rt     : std_logic_vector(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(20 DOWNTO 16);
   ALIAS Imediato : STD_LOGIC_VECTOR(IMED_WIDTH - 1 DOWNTO 0) IS instrucao(IMED_WIDTH - 1 DOWNTO 0);

   SIGNAL palavraControle : STD_LOGIC_VECTOR(9 DOWNTO 0);

   ALIAS BEQ                : STD_LOGIC IS palavraControle(9);
   ALIAS selDataToWriteReg3 : STD_LOGIC IS palavraControle(8);
   ALIAS selEntradaB_ULA    : STD_LOGIC IS palavraControle(7);
   ALIAS selEndRegC         : STD_LOGIC IS palavraControle(6);
   ALIAS writeRegC          : STD_LOGIC IS palavraControle(5);
   ALIAS aluOp              : STD_LOGIC_VECTOR(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
   ALIAS memRd              : STD_LOGIC IS palavraControle(1);
   ALIAS memWr              : STD_LOGIC IS palavraControle(0);

   SIGNAL EndRegC         : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
   SIGNAL dataToWriteReg3 : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   SIGNAL ULA_IN_B        : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL extImediato : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL beqShift   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   SIGNAL BranchPC   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
   SIGNAL saidaMuxPC : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

   SIGNAL selMUX_PC : STD_LOGIC;
BEGIN

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

   EscritaReg3 : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => DATA_WIDTH
         ) PORT MAP(
         entradaA_MUX => saidaULA,
         entradaB_MUX => dataFromRAM,
         seletor_MUX  => selDataToWriteReg3,
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

   selMUX_PC <= BEQ AND flagZero;

   MUX_PC : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => ADDR_WIDTH
         ) PORT MAP(
         entradaA_MUX => BranchPC,
         entradaB_MUX => ProxPC,
         seletor_MUX  => selMUX_PC,
         saida_MUX    => saidaMuxPC
      );

   MUX_EndRegC : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => REGBANK_ADDR_WIDTH
         ) PORT MAP(
         entradaA_MUX => rd,
         entradaB_MUX => rt,
         seletor_MUX  => selEndRegC,
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

   EntradaB_ULA : ENTITY work.muxGenerico2x1
      GENERIC MAP(
         larguraDados => DATA_WIDTH
         ) PORT MAP(
         entradaA_MUX => bancoB_ULA,
         entradaB_MUX => extImediato,
         seletor_MUX  => selEntradaB_ULA,
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

   UC : ENTITY work.UC
      PORT MAP(
         opCode          => opCode,
         funct           => funct,
         palavraControle => palavraControle
      );

   AddrRAM       <= saidaULA;
   dataToRAM     <= bancoB_ULA;
   habLeituraMEM <= memRd;
   habEscritaMEM <= memWr;
END ARCHITECTURE;