LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY single_port_RAM IS
    GENERIC (
        dataWidth : NATURAL := 32;
        addrWidth : NATURAL := 32;
        memoryAddrWidth : NATURAL := 6); -- 64 posicoes de 32 bits cada
    PORT (
        we, re : IN STD_LOGIC := '1';
        clk : IN STD_LOGIC;
        endereco : IN STD_LOGIC_VECTOR (addrWidth - 1 DOWNTO 0);
        dado_write : IN STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);
        dado_read : OUT STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF single_port_RAM IS
    TYPE blocoMemoria IS ARRAY(0 TO 2 ** memoryAddrWidth - 1) OF STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);

    SIGNAL ram : blocoMemoria := (OTHERS => (OTHERS => '0'));

    -- Utiliza uma quantidade menor de endereços locais:
    SIGNAL enderecoLocal : STD_LOGIC_VECTOR(memoryAddrWidth - 1 DOWNTO 0);
BEGIN
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (we = '1') THEN
                ram(to_integer(unsigned(enderecoLocal))) <= dado_write;
            END IF;
        END IF;
    END PROCESS;
    enderecoLocal <= endereco(memoryAddrWidth + 1 DOWNTO 2);
    dado_read <= ram (to_integer(unsigned(enderecoLocal)));
END ARCHITECTURE;