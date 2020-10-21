LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Aula07_UC IS
    GENERIC (
        DATA_WIDTH : NATURAL := 16;
        ADDR_WIDTH : NATURAL := 12
    );
    PORT (
        -- Input ports
        CLOCK_50     : IN std_logic;
        FPGA_RESET_N : IN std_logic;
        -- Output ports
        LEDR       : OUT std_logic_vector(9 DOWNTO 0);
        HEX0, HEX1 : OUT std_logic_vector(6 DOWNTO 0)
        -- programCounter  : OUT std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
        -- saidaAcumulador : OUT std_logic_vector(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch_name OF Aula07_UC IS
    SIGNAL clk             : std_logic;
    SIGNAL programCounter  : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL saidaAcumulador : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
BEGIN
    detectorSub0 : ENTITY work.edgeDetector(bordaSubida)
        PORT MAP(
            clk     => CLOCK_50,
            entrada => (NOT FPGA_RESET_N),
            saida   => clk
        );

    CPU : ENTITY work.Processador_Aula07
        GENERIC MAP(
            DATA_WIDTH => DATA_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        PORT MAP(
            programCounter  => programCounter,
            saidaAcumulador => saidaAcumulador,
            clk             => clk
        );

    conversorHex0 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => saidaAcumulador(3 DOWNTO 0),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX0);

    conversorHex1 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => saidaAcumulador(7 DOWNTO 4),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX1);

    LEDR(0) <= NOT FPGA_RESET_N;
    LEDR(1) <= clk;
END ARCHITECTURE;