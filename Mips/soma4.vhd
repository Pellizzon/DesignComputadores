LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; --Soma (esta biblioteca =ieee)

ENTITY soma4 IS
    GENERIC (
        larguraDados : NATURAL := 32;
        incremento   : NATURAL := 4
    );
    PORT (
        entrada : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
        saida   : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF soma4 IS
BEGIN
    saida <= STD_LOGIC_VECTOR(unsigned(entrada) + incremento);
END ARCHITECTURE;