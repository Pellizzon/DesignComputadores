LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; --Soma (esta biblioteca =ieee)

ENTITY somador IS
    GENERIC (
        larguraDados : NATURAL := 32
    );
    PORT (
        entradaA : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
        entradaB : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
        saida    : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF somador IS
BEGIN
    saida <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
END ARCHITECTURE;