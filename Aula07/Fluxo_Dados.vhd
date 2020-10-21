LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Fluxo_Dados IS
    GENERIC (
        DATA_WIDTH     : NATURAL := 8;
        ROM_DATA_WIDTH : NATURAL := 16;
        ADDR_WIDTH     : NATURAL := 8
    );
    PORT (
        -- Input ports
        clk             : IN std_logic;
        palavraControle : IN std_logic_vector(7 DOWNTO 0);
        -- Output ports
        opCode          : OUT std_logic_vector(3 DOWNTO 0);
        saidaAcumulador : OUT std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
        programCounter  : OUT std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch_name OF Fluxo_Dados IS
    SIGNAL PC_ROM                     : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL SomaUm_MuxProxPC           : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL MuxProxPC_PC               : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL muxULAImed_Acumulador      : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL Instrucao                  : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL Acumulador_ULA_A           : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL saidaULA_muxULAImed_1      : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL DadoLidoRAM_ULA_B          : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL saidaExtSinal_muxULAImed_0 : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);

    ALIAS opCodeLocal              : std_logic_vector(3 DOWNTO 0) IS Instrucao(15 DOWNTO 12);
    ALIAS enderecoRAM              : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) IS Instrucao(ADDR_WIDTH - 1 DOWNTO 0);
    ALIAS enderecoJUMP             : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) IS Instrucao(ADDR_WIDTH - 1 DOWNTO 0);
    ALIAS imediato_entradaExtSinal : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0) IS Instrucao(ADDR_WIDTH - 1 DOWNTO 0);

    ALIAS selMuxProxPC         : std_logic IS palavraControle(7);
    ALIAS selMuxULAImed        : std_logic IS palavraControle(6);
    ALIAS HabEscritaAcumulador : std_logic IS palavraControle(5);
    ALIAS selOperacaoULA       : std_logic_vector(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
    ALIAS habLeituraMEM        : std_logic IS palavraControle(1);
    ALIAS habEscritaMEM        : std_logic IS palavraControle(0);

    CONSTANT INCREMENTO : NATURAL := 1;
BEGIN
    PC : ENTITY work.registradorGenerico
        GENERIC MAP(
            larguraDados => ADDR_WIDTH
        )
        PORT MAP(
            DIN    => MuxProxPC_PC,
            DOUT   => PC_ROM,
            ENABLE => '1',
            CLK    => clk,
            RST    => '0'
        );

    MuxProxPC : ENTITY work.muxGenerico2x1
        GENERIC MAP(
            larguraDados => ADDR_WIDTH
        )
        PORT MAP(
            entradaA_MUX => SomaUm_MuxProxPC,
            entradaB_MUX => enderecoJUMP,
            seletor_MUX  => selMuxProxPC,
            saida_MUX    => MuxProxPC_PC
        );

    muxULA_Imediato : ENTITY work.muxGenerico2x1
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA_MUX => saidaExtSinal_muxULAImed_0,
            entradaB_MUX => saidaULA_muxULAImed_1,
            seletor_MUX  => selMuxULAImed,
            saida_MUX    => muxULAImed_Acumulador
        );

    somaUm : ENTITY work.somaConstante
        GENERIC MAP(
            larguraDados => ADDR_WIDTH,
            constante    => INCREMENTO
        )
        PORT MAP(
            entrada => PC_ROM,
            saida   => SomaUm_MuxProxPC
        );

    ROM : ENTITY work.memoriaROM
        GENERIC MAP(
            dataWidth => ROM_DATA_WIDTH,
            addrWidth => ADDR_WIDTH
        )
        PORT MAP(
            Endereco => PC_ROM,
            Dado     => Instrucao
        );

    RAM : ENTITY work.memoriaRAM
        GENERIC MAP(
            dataWidth => DATA_WIDTH,
            addrWidth => ADDR_WIDTH)
        PORT MAP(
            addr     => enderecoRAM,
            we       => habEscritaMEM,
            dado_in  => Acumulador_ULA_A,
            dado_out => DadoLidoRAM_ULA_B,
            clk      => clk
        );

    Acumulador : ENTITY work.registradorGenerico
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            DIN    => muxULAImed_Acumulador,
            DOUT   => Acumulador_ULA_A,
            ENABLE => HabEscritaAcumulador,
            CLK    => clk,
            RST    => '0'
        );

    ULA : ENTITY work.ULA
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => Acumulador_ULA_A,
            entradaB => DadoLidoRAM_ULA_B,
            saida    => saidaULA_muxULAImed_1,
            seletor  => selOperacaoULA,
            flagZero => OPEN
        );

    estendeSinal : ENTITY work.estendeSinalGenerico
        GENERIC MAP(
            larguraDadoEntrada => 12,
            larguraDadoSaida   => DATA_WIDTH
        )
        PORT MAP(
            estendeSinal_IN  => imediato_entradaExtSinal,
            estendeSinal_OUT => saidaExtSinal_muxULAImed_0
        );

    opCode          <= opCodeLocal;
    saidaAcumulador <= Acumulador_ULA_A;
    programCounter  <= PC_ROM;
END ARCHITECTURE;