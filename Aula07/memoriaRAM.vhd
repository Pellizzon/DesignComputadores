LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memoriaRAM IS
    GENERIC (
        dataWidth : NATURAL := 8;
        addrWidth : NATURAL := 8
    );
    PORT (
        addr     : IN std_logic_vector(addrWidth - 1 DOWNTO 0);
        we       : IN std_logic := '1';
        clk      : IN std_logic;
        dado_in  : IN std_logic_vector(dataWidth - 1 DOWNTO 0);
        dado_out : OUT std_logic_vector(dataWidth - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF memoriaRAM IS
    -- Build a 2-D array type for the RAM
    SUBTYPE word_t IS std_logic_vector(dataWidth - 1 DOWNTO 0);
    TYPE memory_t IS ARRAY((2 ** addrWidth - 1) DOWNTO 0) OF word_t;

    FUNCTION initMemory
        RETURN memory_t IS VARIABLE tmp : memory_t := (OTHERS => (OTHERS => '0'));
    BEGIN
        -- Inicializa os endereços:
        tmp(0) := x"0001";
        --        tmp(1) := x"42";
        --        tmp(2) := x"43";
        --        tmp(3) := x"44";
        --        tmp(4) := x"45";
        --        tmp(5) := x"46";
        --        tmp(6) := x"47";
        --        tmp(7) := x"55";
        RETURN tmp;
    END initMemory;

    -- Declare the RAM signal.
    SIGNAL ram : memory_t := initMemory;
BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (we = '1') THEN
                ram(to_integer(unsigned(addr))) <= dado_in;
            END IF;
        END IF;
    END PROCESS;

    -- A leitura é sempre assincrona:
    dado_out <= ram(to_integer(unsigned(addr)));
END ARCHITECTURE;