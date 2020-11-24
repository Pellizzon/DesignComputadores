LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY muxGenerico2 IS
    GENERIC (
        larguraDados : NATURAL := 8
    );
    PORT (
        entradaA : IN STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
        entradaB : IN STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
        seletor  : IN STD_LOGIC;
        saida    : OUT STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF muxGenerico2 IS
BEGIN
    saida <= entradaA WHEN (seletor = '0') ELSE
        entradaB;
END ARCHITECTURE;