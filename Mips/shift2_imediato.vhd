LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY shift2_imediato IS
    GENERIC (
        larguraDado : NATURAL := 16
    );
    PORT (
        shift_IN  : IN STD_LOGIC_VECTOR(larguraDado - 1 DOWNTO 0);
        shift_OUT : OUT STD_LOGIC_VECTOR(larguraDado - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF shift2_imediato IS
BEGIN
    shift_OUT <= shift_IN(larguraDado - 3 DOWNTO 0) & "00";
END ARCHITECTURE;