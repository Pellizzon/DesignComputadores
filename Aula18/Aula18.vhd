LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY Aula18 IS
  PORT (
    CLOCK_50 : IN STD_LOGIC;

    -- Testes
--    KEY          : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--    FPGA_RESET_N : IN STD_LOGIC;
--    SW           : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
--    HEX0         : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
--    LEDR         : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	 OUTbarramentoEnderecos : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
	 OUTPC: OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0); 
	 OUTbarramentoDadosLeitura : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    --------------------------------------------
  );
END ENTITY;

ARCHITECTURE rtl OF Aula18 IS

  SIGNAL barramentoDadosLeitura : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL barramentoEnderecos    : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
  SIGNAL barramentoDadosEscrita : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

  SIGNAL rd : STD_LOGIC;
  SIGNAL wr : STD_LOGIC;
  -- sinais para teste: simulacoes
  SIGNAL PCout : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
  -- fpga:
--  SIGNAL clock          : STD_LOGIC;
  ------------------------------------------------------------------
   
BEGIN
	
	-- para teste: simulacoes
	OUTbarramentoEnderecos <= barramentoEnderecos;
	OUTbarramentoDadosLeitura <= barramentoDadosLeitura;
	OUTPC <= PCout;
	-------------------------
	

--  display_hex0 : ENTITY work.conversorHex7Seg
--    PORT MAP(
--      dadoHex   => saidaULA_teste(3 DOWNTO 0),
--      apaga     => '0',
--      negativo  => '0',
--      overFlow  => '0',
--      saida7seg => HEX0);

--  detectorCLOCK : ENTITY work.edgeDetector
--    PORT MAP(
--      clk     => CLOCK_50,
--      entrada => FPGA_RESET_N,
--      saida   => clock
--    );
--
--  detectorRST_PC : ENTITY work.edgeDetector
--    PORT MAP(
--      clk     => CLOCK_50,
--      entrada => (NOT KEY(1)),
--      saida   => resetPC
--    );

--  LEDR <= PCout(9 DOWNTO 0);

  FluxoDados : ENTITY work.FD
    PORT MAP(
      -- para teste: simulacao
		PCout => PCout,
      ----------
      clk                    => CLOCK_50,
      barramentoDadosLeitura => barramentoDadosLeitura,
      barramentoEnderecos    => barramentoEnderecos,
      barramentoDadosEscrita => barramentoDadosEscrita,
      habLeituraMEM          => rd,
      habEscritaMEM          => wr
    );

  RAM : ENTITY work.RAMMIPS
    GENERIC MAP(
      dataWidth       => DATA_WIDTH,
      addrWidth       => DATA_WIDTH,
      memoryAddrWidth => 6
      ) PORT MAP(
      clk      => CLOCK_50,
      Endereco => barramentoEnderecos,
      Dado_in  => barramentoDadosEscrita,
      Dado_out => barramentoDadosLeitura,
      we       => wr,
      rd       => rd
    );

END ARCHITECTURE;