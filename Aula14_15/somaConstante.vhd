LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; --Soma (esta biblioteca =ieee)

ENTITY somaConstante IS
    GENERIC (
        larguraDados : NATURAL := 32;
        constante    : NATURAL := 4
    );
    PORT (
        entrada : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
        saida   : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF somaConstante IS
BEGIN
    saida <= std_logic_vector(unsigned(entrada) + constante);
END ARCHITECTURE;