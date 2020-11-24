LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY etapa_memoria IS
    PORT (
        clk                      : IN STD_LOGIC;
        leitura_RAM, escreve_RAM : IN STD_LOGIC;
        saida_ula, dadoLidoB     : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        dadoEscrita              : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE estrutural OF etapa_memoria IS
BEGIN

    -- RAM: escreve valor lido no registrador B no endereço de memória de acordo com a saída da ULA
    RAM : ENTITY work.single_port_RAM
        GENERIC MAP(
            dataWidth => DATA_WIDTH,
            addrWidth => ADDR_WIDTH
        )
        PORT MAP(
            endereco   => saida_ula,
            we         => escreve_RAM,
            re         => leitura_RAM,
            clk        => clk,
            dado_write => dadoLidoB,
            dado_read  => dadoEscrita
        );
END ARCHITECTURE;