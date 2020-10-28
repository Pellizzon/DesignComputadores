LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY Aula14 IS
  PORT (
    CLOCK_50 : IN STD_LOGIC;
	 KEY     : in  std_logic_vector(3 downto 0);
	 FPGA_RESET_N     : in  std_logic;

	 LEDR    : out std_logic_vector(9 downto 0)
	 
  );
END ENTITY;

ARCHITECTURE rtl OF Aula14 IS

  SIGNAL dataFromRAM : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL AddrRAM     : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL dataToRAM   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

  SIGNAL rd : STD_LOGIC;
  SIGNAL wr : STD_LOGIC;
  
  
  -- sinais para teste
  SIGNAL resetPC : STD_LOGIC;
  SIGNAL clock   : STD_LOGIC;

BEGIN

	detectorCLOCK: ENTITY work.edgeDetector 
	  PORT MAP(
		clk => CLOCK_50, 
		entrada => FPGA_RESET_N, 
		saida => clock
	);
	
	detectorRST_PC: ENTITY work.edgeDetector 
	  PORT MAP(
		clk => CLOCK_50, 
		entrada => (not KEY(1)), 
		saida => resetPC
	);

  FluxoDados : ENTITY work.FD
    PORT MAP(
	 -- para teste
		resetPC => resetPC,
	 ----------
      clk           => clock,
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
      clk      => clock,
      Endereco => AddrRAM,
      Dado_in  => dataToRAM,
      Dado_out => dataFromRAM,
      we       => wr,
      rd       => rd
    );

END ARCHITECTURE;