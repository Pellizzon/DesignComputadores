LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY mips IS
    PORT (
        CLOCK_50 : IN STD_LOGIC;

        prox_pc, escrita_C, endEscrita_RAM, dadoEscrita_RAM : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        endereco_C                                          : OUT STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
        wrC, wrRAM                                          : OUT STD_LOGIC

        -- KEY                                : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        -- HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        -- LEDR                               : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)

    );
END ENTITY;

ARCHITECTURE estrutural OF mips IS

    SIGNAL clk : STD_LOGIC;

    -- Declaração de sinais auxiliares
    SIGNAL pontosDeControle : STD_LOGIC_VECTOR(CONTROLWORD_WIDTH - 1 DOWNTO 0);
    SIGNAL opcode           : STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);
    SIGNAL ALUop            : STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0);
    SIGNAL ALUctr           : STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0);

    -- sinais para depuração
    SIGNAL PC_prox_out, dadoEscritaC_out, enderecoEscritaRAM_out, dadoEscritoRAM_out : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL enderecoC_out                                                             : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL escreveC_out, escreveRAM_out                                              : STD_LOGIC;

BEGIN
    prox_pc         <= PC_prox_out;
    escrita_C       <= dadoEscritaC_out;
    endEscrita_RAM  <= enderecoEscritaRAM_out;
    dadoEscrita_RAM <= dadoEscritoRAM_out;
    endereco_C      <= enderecoC_out;
    wrC             <= escreveC_out;
    wrRAM           <= escreveRAM_out;
    clk             <= CLOCK_50;

    -- CLOCK generator auxiliar para simulação
    --    CG : entity work.clock_generator port map (clk	=> clk

    FD : ENTITY work.fluxo_dados
        PORT MAP(
            clk              => clk,
            pontosDeControle => pontosDeControle,
            opcode           => opcode,
            -- sinais para depuração
            PC_prox_out            => PC_prox_out,
            enderecoEscritaRAM_out => enderecoEscritaRAM_out,
            dadoEscritoRAM_out     => dadoEscritoRAM_out,
            escreveRAM_out         => escreveRAM_out,
            enderecoC_out          => enderecoC_out,
            dadoEscritaC_out       => dadoEscritaC_out,
            escreveC_out           => escreveC_out
        );
    -- LEDR(9)          <= clk;
    -- LEDR(8 DOWNTO 5) <= (OTHERS => '0');

    -- EDGE : work.edgeDetector(bordaSubida)
    -- PORT MAP(
    --     clk     => CLOCK_50,
    --     entrada => (NOT KEY(0)),
    --     saida   => clk);

    -- DISP5 : ENTITY work.conversorHex7Seg
    --     PORT MAP(
    --         dadoHex   => PC_prox_out(7 DOWNTO 4),
    --         apaga     => '0',
    --         negativo  => '0',
    --         overFlow  => '0',
    --         saida7seg => HEX5);

    -- DISP4 : ENTITY work.conversorHex7Seg
    --     PORT MAP(
    --         dadoHex   => PC_prox_out(3 DOWNTO 0),
    --         apaga     => '0',
    --         negativo  => '0',
    --         overFlow  => '0',
    --         saida7seg => HEX4);

    -- LEDR(4)          <= escreveC_out;
    -- LEDR(3 DOWNTO 1) <= (OTHERS => '0');

    -- DISP3 : ENTITY work.conversorHex7Seg
    --     PORT MAP(
    --         dadoHex   => enderecoC_out(3 DOWNTO 0),
    --         apaga     => '0',
    --         negativo  => '0',
    --         overFlow  => '0',
    --         saida7seg => HEX3);

    -- DISP2 : ENTITY work.conversorHex7Seg
    --     PORT MAP(
    --         dadoHex   => dadoEscritaC_out(3 DOWNTO 0),
    --         apaga     => '0',
    --         negativo  => '0',
    --         overFlow  => '0',
    --         saida7seg => HEX2);

    -- LEDR(0) <= escreveRAM_out;

    -- DISP1 : ENTITY work.conversorHex7Seg
    --     PORT MAP(
    --         dadoHex   => enderecoEscritaRAM_out(3 DOWNTO 0),
    --         apaga     => '0',
    --         negativo  => '0',
    --         overFlow  => '0',
    --         saida7seg => HEX1);

    -- DISP0 : ENTITY work.conversorHex7Seg
    --     PORT MAP(
    --         dadoHex   => dadoEscritoRAM_out(3 DOWNTO 0),
    --         apaga     => '0',
    --         negativo  => '0',
    --         overFlow  => '0',
    --         saida7seg => HEX0);

    UC : ENTITY work.UC
        PORT MAP(
            opcode           => opcode,
            pontosDeControle => pontosDeControle);

END ARCHITECTURE;