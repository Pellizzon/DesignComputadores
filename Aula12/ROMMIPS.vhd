LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ROMMIPS IS
  GENERIC (
    dataWidth       : NATURAL := 32;
    addrWidth       : NATURAL := 32;
    memoryAddrWidth : NATURAL := 6); -- 64 posicoes de 32 bits cada
  PORT (
    Endereco : IN STD_LOGIC_VECTOR (addrWidth - 1 DOWNTO 0);
    Dado     : OUT STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0));
END ENTITY;

ARCHITECTURE assincrona OF ROMMIPS IS
  TYPE blocoMemoria IS ARRAY(0 TO 2 ** memoryAddrWidth - 1) OF std_logic_vector(dataWidth - 1 DOWNTO 0);

  SIGNAL memROM           : blocoMemoria;
  ATTRIBUTE ram_init_file : STRING;
  ATTRIBUTE ram_init_file OF memROM :
  SIGNAL IS "ROMcontent.mif";

  -- Utiliza uma quantidade menor de endereços locais:
  SIGNAL EnderecoLocal : std_logic_vector(memoryAddrWidth - 1 DOWNTO 0);

BEGIN
  EnderecoLocal <= Endereco(memoryAddrWidth + 1 DOWNTO 2);
  Dado          <= memROM (to_integer(unsigned(EnderecoLocal)));
END ARCHITECTURE;