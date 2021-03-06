LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FD IS
   GENERIC (
      instructionWidth : NATURAL := 32;
      ROMAddrWidth     : NATURAL := 32;
      dataWidth        : NATURAL := 32
   );
   PORT (
      clk : IN STD_LOGIC
   );
END ENTITY;

ARCHITECTURE rtl OF FD IS

   SIGNAL ProxPC : std_logic_vector(ROMAddrWidth - 1 DOWNTO 0);
   SIGNAL saidaPC : std_logic_vector(ROMAddrWidth - 1 DOWNTO 0);

   SIGNAL bancoA_ULA, bancoB_ULA : std_logic_vector(dataWidth - 1 DOWNTO 0);

   SIGNAL saidaULA : std_logic_vector(dataWidth - 1 DOWNTO 0);
   SIGNAL flagZero : std_logic;

   SIGNAL instrucao : std_logic_vector(instructionWidth - 1 DOWNTO 0);
   -- para instrucoes tipo R
   ALIAS opCode : std_logic_vector(5 DOWNTO 0) IS instrucao(31 DOWNTO 26);
   ALIAS rs     : std_logic_vector(4 DOWNTO 0) IS instrucao(25 DOWNTO 21);
   ALIAS rt     : std_logic_vector(4 DOWNTO 0) IS instrucao(20 DOWNTO 16);
   ALIAS rd     : std_logic_vector(4 DOWNTO 0) IS instrucao(15 DOWNTO 11);
   ALIAS shamt  : std_logic_vector(4 DOWNTO 0) IS instrucao(10 DOWNTO 6);
   ALIAS funct  : std_logic_vector(5 DOWNTO 0) IS instrucao(5 DOWNTO 0);

   SIGNAL palavraControle : std_logic_vector(5 DOWNTO 0);

   ALIAS writeRegC : std_logic IS palavraControle(5);
   ALIAS aluOp     : std_logic_vector(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
   ALIAS memRd     : std_logic IS palavraControle(1);
   ALIAS memWr     : std_logic IS palavraControle(0);

BEGIN

   IncPC : ENTITY work.somaConstante
      GENERIC MAP(
         larguraDados => instructionWidth,
         constante    => 4
         ) PORT MAP(
         entrada => saidaPC,
         saida   => ProxPC
      );

   PC : ENTITY work.registradorGenerico
      GENERIC MAP(
         larguraDados => instructionWidth
         ) PORT MAP(
         DIN    => ProxPC,
         DOUT   => saidaPC,
         ENABLE => '1',
         CLK    => clk,
         RST    => '0'
      );

   ROM : ENTITY work.ROMMIPS
      GENERIC MAP(
         dataWidth       => instructionWidth,
         addrWidth       => ROMAddrWidth,
         memoryAddrWidth => 6
         ) PORT MAP(
         Endereco => saidaPC,
         Dado     => instrucao
      );

   BancoRegistradores : ENTITY work.bancoRegistradores
      GENERIC MAP(
         larguraDados        => dataWidth,
         larguraEndBancoRegs => 5 --Resulta em 2^5=32 posicoes
         ) PORT MAP(
         clk => clk,
         --
         enderecoA => rs,
         enderecoB => rt,
         enderecoC => rd,
         --
         dadoEscritaC => saidaULA,
         --
         escreveC => writeRegC,
         saidaA   => bancoA_ULA,
         saidaB   => bancoB_ULA
      );

   ULA : ENTITY work.ULA
      GENERIC MAP(
         dataWidth => dataWidth
         ) PORT MAP(
         entradaA => bancoA_ULA,
         entradaB => bancoB_ULA,
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

END ARCHITECTURE;