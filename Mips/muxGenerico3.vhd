LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY muxGenerico3 IS
    GENERIC (
        larguraDados : NATURAL := 8
    );
    PORT (
        entradaA : IN STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
        entradaB : IN STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
        entradaC : IN STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
        seletor  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        saida    : OUT STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF muxGenerico3 IS
BEGIN
    saida <= entradaA WHEN (seletor = "00") ELSE
        entradaB WHEN (seletor = "01") ELSE
        entradaC WHEN (seletor = "10") ELSE
        entradaA;
END ARCHITECTURE;