LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY muxGenerico2x1 IS
    -- Total de bits das entradas e saidas
    GENERIC (larguraDados : NATURAL := 8);
    PORT (
        entradaA_MUX, entradaB_MUX : IN std_logic_vector((larguraDados - 1) DOWNTO 0);
        seletor_MUX                : IN std_logic;
        saida_MUX                  : OUT std_logic_vector((larguraDados - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF muxGenerico2x1 IS
BEGIN
    saida_MUX <= entradaB_MUX WHEN (seletor_MUX = '1') ELSE
        entradaA_MUX;
END ARCHITECTURE;