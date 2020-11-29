LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY estendeSinalGenerico IS
    GENERIC (
        larguraDadoEntrada : NATURAL := 8;
        larguraDadoSaida   : NATURAL := 8
    );
    PORT (
        -- Input ports
        selORI_ANDI     : IN STD_LOGIC;
        estendeSinal_IN : IN STD_LOGIC_VECTOR(larguraDadoEntrada - 1 DOWNTO 0);
        -- Output ports
        estendeSinal_OUT : OUT STD_LOGIC_VECTOR(larguraDadoSaida - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF estendeSinalGenerico IS

    SIGNAL estendeSinal_OUT_s : STD_LOGIC_VECTOR(larguraDadoSaida - 1 DOWNTO 0);

BEGIN
    estendeSinal_OUT_s <= (larguraDadoSaida - 1 DOWNTO larguraDadoEntrada => '1') & estendeSinal_IN
        WHEN (estendeSinal_IN(larguraDadoEntrada - 1) = '1') ELSE
        (larguraDadoSaida - 1 DOWNTO larguraDadoEntrada => '0') & estendeSinal_IN;

    estendeSinal_OUT <= (larguraDadoSaida - 1 DOWNTO larguraDadoEntrada => '0') & estendeSinal_IN WHEN selORI_ANDI = '1' ELSE
        estendeSinal_OUT_s;

    -- Poderia ter sido implementado outro estensor de sinal que preenche de zeros, os bits 31 - 16 para 
    -- o caso ORI e ANDI, e depois usar o sinal selORI_ANDI em um mux. A implementação desse jeito era mais facil
    -- e o resultado deveria ser o mesmo...
END ARCHITECTURE;