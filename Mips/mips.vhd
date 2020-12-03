LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

-- MIPS Projeto Design de Computadores INSPER 2020.2
-- Matheus Pellizzon
-- Pedro Paulo M. Telho
-- Pedro Teófilo Ramos

ENTITY mips IS
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        -- sinais para depuração waveforms
--        pc_out, escrita_C, endEscrita_RAM, dadoEscrita_RAM : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
--        endereco_C                                         : OUT STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
--        wrC, wrRAM                                         : OUT STD_LOGIC
        
		  SW                                 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        KEY                                : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        LEDR                               : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE estrutural OF mips IS

    SIGNAL clk : STD_LOGIC;

    -- Declaração de sinais auxiliares
    SIGNAL pontosDeControle : STD_LOGIC_VECTOR(CONTROLWORD_WIDTH - 1 DOWNTO 0);
    SIGNAL opcode           : STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);
    SIGNAL ALUop            : STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0);
    SIGNAL ALUctr           : STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0);
    SIGNAL jr               : STD_LOGIC;

    -- sinais para depuração
    SIGNAL PC_out_s, dadoEscritaC_out, enderecoEscritaRAM_out, dadoEscritoRAM_out : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL enderecoC_out                                                             : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL escreveC_out, escreveRAM_out                                              : STD_LOGIC;
    SIGNAL to_display                                                                : STD_LOGIC_VECTOR(23 DOWNTO 0);
BEGIN
    -- sinais para depuração waveforms
--    pc_out          <= PC_out_s;
--    escrita_C       <= dadoEscritaC_out;
--    endEscrita_RAM  <= enderecoEscritaRAM_out;
--    dadoEscrita_RAM <= dadoEscritoRAM_out;
--    endereco_C      <= enderecoC_out;
--    wrC             <= escreveC_out;
--    wrRAM           <= escreveRAM_out;
--    clk             <= CLOCK_50;

    FD : ENTITY work.fluxo_dados
        PORT MAP(
            clk              => clk,
            pontosDeControle => pontosDeControle,
            opcode           => opcode,
            jr               => jr,
            -- sinais para depuração
            PC_out                 => PC_out_s,
            enderecoEscritaRAM_out => enderecoEscritaRAM_out,
            dadoEscritoRAM_out     => dadoEscritoRAM_out,
            escreveRAM_out         => escreveRAM_out,
            enderecoC_out          => enderecoC_out,
            dadoEscritaC_out       => dadoEscritaC_out,
            escreveC_out           => escreveC_out
        );

    UC : ENTITY work.UC
        PORT MAP(
            jr               => jr,
            opcode           => opcode,
            pontosDeControle => pontosDeControle);

    -- SW  2 1 0
    --     0 0 0 = pc
    --     0 0 1 = dado da etapa write back (saida do mux ULA_MEM)
    --     0 1 0 = endereco escrita RAM (saida ULA)
    --     0 1 1 = dado lido do banco B, após passar pelo reg EX/MEM
    --     1 0 0 = endereco de escrita do banco de registradores (saida do reg MEM/WB)

    to_display <= PC_out_s(23 DOWNTO 0) WHEN SW = 3x"0" ELSE
        dadoEscritaC_out(23 DOWNTO 0) WHEN SW = 3x"1" ELSE
        enderecoEscritaRAM_out(23 DOWNTO 0) WHEN SW = 3x"2" ELSE
        dadoEscritoRAM_out(23 DOWNTO 0) WHEN SW = 3x"3" ELSE
        19x"00000" & enderecoC_out WHEN SW = 3x"4" ELSE
        (OTHERS => '0');

    EDGE : work.edgeDetector(bordaSubida)
    PORT MAP(
        clk     => CLOCK_50,
        entrada => (NOT KEY(0)),
        saida   => clk);

    DISP5 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => to_display(23 DOWNTO 20),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX5);

    DISP4 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => to_display(19 DOWNTO 16),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX4);
    DISP3 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => to_display(15 DOWNTO 12),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX3);

    DISP2 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => to_display(11 DOWNTO 8),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX2);

    LEDR(1) <= escreveC_out;
    LEDR(0) <= escreveRAM_out;

    DISP1 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => to_display(7 DOWNTO 4),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX1);

    DISP0 : ENTITY work.conversorHex7Seg
        PORT MAP(
            dadoHex   => to_display(3 DOWNTO 0),
            apaga     => '0',
            negativo  => '0',
            overFlow  => '0',
            saida7seg => HEX0);
END ARCHITECTURE;