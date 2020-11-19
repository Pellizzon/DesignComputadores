LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY etapa_memoria IS
    PORT (
        clk : IN STD_LOGIC;
        sel_mux_ula_mem, leitura_RAM, escreve_RAM : IN STD_LOGIC;
        saida_ula, dadoLidoB : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        dadoEscrita : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE estrutural OF etapa_memoria IS

    -- Sinais auxiliares para a RAM
    SIGNAL dado_lido_mem : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    -- RAM: escreve valor lido no registrador B no endereço de memória de acordo com a saída da ULA
    RAM : ENTITY work.single_port_RAM
        GENERIC MAP(
            dataWidth => DATA_WIDTH,
            addrWidth => ADDR_WIDTH
        )
        PORT MAP(
            endereco => saida_ula,
            we => escreve_RAM,
            re => leitura_RAM,
            clk => clk,
            dado_write => dadoLidoB,
            dado_read => dado_lido_mem
        );

    -- MUXs
    mux_Ula_Memoria : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => saida_ula,
            entradaB => dado_lido_mem,
            seletor => sel_mux_ula_mem,
            saida => dadoEscrita
        );

END ARCHITECTURE;