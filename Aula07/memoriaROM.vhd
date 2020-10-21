LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memoriaROM IS
    GENERIC (
        dataWidth : NATURAL := 8;
        addrWidth : NATURAL := 3
    );
    PORT (
        Endereco : IN std_logic_vector (addrWidth - 1 DOWNTO 0);
        Dado     : OUT std_logic_vector (dataWidth - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE assincrona OF memoriaROM IS
    TYPE blocoMemoria IS ARRAY(0 TO 2 ** addrWidth - 1) OF std_logic_vector(dataWidth - 1 DOWNTO 0);

    CONSTANT Jump      : std_logic_vector(3 DOWNTO 0) := "0000";
    CONSTANT Load      : std_logic_vector(3 DOWNTO 0) := "0001";
    CONSTANT Store     : std_logic_vector(3 DOWNTO 0) := "0010";
    CONSTANT AddAccMem : std_logic_vector(3 DOWNTO 0) := "0011";
    CONSTANT SubAccMem : std_logic_vector(3 DOWNTO 0) := "0100";

    FUNCTION initMemory
        RETURN blocoMemoria IS VARIABLE tmp : blocoMemoria := (OTHERS => (OTHERS => '0'));
    BEGIN
        -- Inicializa os endereços:
        -- Carrega RAM[0] (que é igual a 1) no ACC.
        tmp(0) := Load & x"000";
        -- Soma RAM[0] ao ACC 3 vezes, portanto ACC = 4.
        tmp(1) := AddAccMem & x"000";
        tmp(2) := AddAccMem & x"000";
        tmp(3) := AddAccMem & x"000";
        -- Subtrai RAM[0] do ACC, portanto ACC = 3.
        tmp(4) := SubAccMem & x"000";
        -- Guarda o ACC em RAM[1].
        tmp(5) := Store & x"001";
        -- Soma RAM[0] ao ACC 3 vezes, portanto ACC = 7.
        tmp(6) := AddAccMem & x"000";
        tmp(7) := AddAccMem & x"000";
        tmp(8) := AddAccMem & x"000";
        tmp(9) := AddAccMem & x"000";
        -- Soma RAM[1] ao ACC, portanto ACC = 10.
        tmp(10) := AddAccMem & x"001";
        RETURN tmp;
    END initMemory;

    SIGNAL memROM : blocoMemoria := initMemory;
BEGIN
    Dado <= memROM (to_integer(unsigned(Endereco)));
END ARCHITECTURE;