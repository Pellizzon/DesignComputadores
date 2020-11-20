LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY etapa_execucao IS
    PORT (
        ULActr                         : IN STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0);
        sel_beq, sel_mux_banco_ula     : IN STD_LOGIC;
        PC_mais_4                      : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        imediato, dadoLidoA, dadoLidoB : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        PC_beq, saida_ula              : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        sel_mux_beq                    : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE estrutural OF etapa_execucao IS

    -- Sinais auxiliares para a ULA
    SIGNAL Z_out : STD_LOGIC;

    -- Sinais auxiliares para a lógica do PC
    SIGNAL PC_mais_4_mais_imediato, entrada_somador_beq : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    -- Sinais auxiliares dos MUXs
    SIGNAL saida_mux_banco_ula : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    sel_mux_beq <= sel_beq AND Z_out;

    -- Lógica da ULA
    ULA : ENTITY work.ULA
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => dadoLidoA,
            entradaB => saida_mux_banco_ula,
            ctr      => ULActr,
            saida    => saida_ula,
            flagZero => Z_out
        );

    mux_Banco_Ula : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => dadoLidoB,
            entradaB => imediato,
            seletor  => sel_mux_banco_ula,
            saida    => saida_mux_banco_ula
        );

    -- Lógica do BEQ
    shift : ENTITY work.shift2_imediato
        GENERIC MAP(
            larguraDado => DATA_WIDTH
        )
        PORT MAP(
            shift_IN  => imediato,
            shift_OUT => entrada_somador_beq
        );

    Somador_imediato : ENTITY work.somador
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => entrada_somador_beq,
            entradaB => PC_mais_4,
            saida    => PC_beq
        );

END ARCHITECTURE;