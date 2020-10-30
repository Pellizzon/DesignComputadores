LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas

USE work.constantesMIPS.ALL;

ENTITY ULA IS
  GENERIC (
    dataWidth : NATURAL := 32
  );
  PORT (
    entradaA, entradaB : IN STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
    seletor            : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    saida              : OUT STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
    flagZero           : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE comportamento OF ULA IS
  CONSTANT zero : STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0) := (OTHERS => '0');

  SIGNAL soma      : STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
  SIGNAL subtracao : STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
  SIGNAL op_and    : STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
  SIGNAL op_or     : STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0);
  SIGNAL op_slt    : STD_LOGIC_VECTOR((dataWidth - 1) DOWNTO 0) := x"00000000";
BEGIN
  soma      <= STD_LOGIC_VECTOR(SIGNED(entradaA) + SIGNED(entradaB));
  subtracao <= STD_LOGIC_VECTOR(SIGNED(entradaA) - SIGNED(entradaB));
  op_and    <= entradaA AND entradaB;
  op_or     <= entradaA OR entradaB;
  op_slt(0) <= subtracao(31); -- se A-B < 0, subtracao sera negativa, logo msb=1, provando que A<B

  saida <= soma WHEN (seletor = execAddULA) ELSE
    subtracao WHEN (seletor = execSubULA) ELSE
    op_and WHEN (seletor = execAndULA) ELSE
    op_or WHEN (seletor = execOrULA) ELSE
    op_slt WHEN (seletor = execSltULA) ELSE
    entradaA; -- outra opcao: saida = entradaA

  flagZero <= '1' WHEN unsigned(saida) = unsigned(zero) ELSE
    '0';

END ARCHITECTURE;