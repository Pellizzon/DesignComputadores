LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY Aula14 IS
  PORT (
    CLOCK_50 : IN STD_LOGIC
  );
END ENTITY;

ARCHITECTURE rtl OF Aula14 IS

  SIGNAL dataFromRAM : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL AddrRAM     : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL dataToRAM   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

  SIGNAL rd : STD_LOGIC;
  SIGNAL wr : STD_LOGIC;

BEGIN

  FluxoDados : ENTITY work.FD
    PORT MAP(
      clk           => CLOCK_50,
      dataFromRAM   => dataFromRAM,
      AddrRAM       => AddrRAM,
      dataToRAM     => dataToRAM,
      habLeituraMEM => rd,
      habEscritaMEM => wr
    );

  RAM : ENTITY work.RAMMIPS
    GENERIC MAP(
      dataWidth       => DATA_WIDTH,
      addrWidth       => DATA_WIDTH,
      memoryAddrWidth => 6
      ) PORT MAP(
      clk      => CLOCK_50,
      Endereco => AddrRAM,
      Dado_in  => dataToRAM,
      Dado_out => dataFromRAM,
      we       => wr,
      rd       => rd
    );

END ARCHITECTURE;