LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY etapa_decodificacao IS
    PORT (
        clk                          : IN STD_LOGIC;
        lui                          : IN STD_LOGIC;
        selORI_ANDI                  : IN STD_LOGIC;
        instrucao                    : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        enderecoC                    : IN STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
        dadoEscritaC                 : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        escreveC                     : IN STD_LOGIC;
        saidaA, saidaB, imed_ext_lui : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE estrutural OF etapa_decodificacao IS

    -- Parsing da instrucao
    ALIAS RS_addr  : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(25 DOWNTO 21);
    ALIAS RT_addr  : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao(20 DOWNTO 16);
    ALIAS imediato : STD_LOGIC_VECTOR(15 DOWNTO 0) IS instrucao(15 DOWNTO 0);

    SIGNAL imediato_ext : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    BR : ENTITY work.bancoRegistradores
        GENERIC MAP(
            larguraDados        => DATA_WIDTH,
            larguraEndBancoRegs => 5
        )
        PORT MAP(
            enderecoA    => RS_addr,
            enderecoB    => RT_addr,
            enderecoC    => enderecoC,
            clk          => clk,
            dadoEscritaC => dadoEscritaC,
            escreveC     => escreveC,
            saidaA       => saidaA,
            saidaB       => saidaB
        );

    extensor : ENTITY work.estendeSinalGenerico
        GENERIC MAP(
            larguraDadoEntrada => 16,
            larguraDadoSaida   => DATA_WIDTH
        )
        PORT MAP(
            selORI_ANDI      => selORI_ANDI,
            estendeSinal_IN  => imediato,
            estendeSinal_OUT => imediato_ext
        );

    mux_lui : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => imediato_ext,
            entradaB => imediato & x"0000",
            seletor  => lui,
            saida    => imed_ext_lui
        );

END ARCHITECTURE;