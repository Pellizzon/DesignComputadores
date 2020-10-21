LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Processador_Aula07 IS
    GENERIC (
        DATA_WIDTH : NATURAL := 16;
        ADDR_WIDTH : NATURAL := 12
    );
    PORT (
        -- Input ports
        clk : IN std_logic;
        -- Output ports
        saidaAcumulador : OUT std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
        programCounter  : OUT std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch_name OF Processador_Aula07 IS
    SIGNAL progCount       : std_logic_vector(ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL saiAcumulador   : std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL palavraControle : std_logic_vector(7 DOWNTO 0);
    SIGNAL opCode          : std_logic_vector(3 DOWNTO 0);
BEGIN
    -- Para instanciar, a atribuição de sinais (e generics) segue a ordem: (nomeSinalArquivoDefinicaoComponente => nomeSinalNesteArquivo)
    FD : ENTITY work.Fluxo_Dados
        GENERIC MAP(
            DATA_WIDTH => DATA_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        PORT MAP(
            palavraControle => palavraControle,
            opCode          => opCode,
            saidaAcumulador => saidaAcumulador,
            programCounter  => programCounter,
            clk             => clk
        );
    UC : ENTITY work.Unidade_Controle
        GENERIC MAP(
            DATA_WIDTH => DATA_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        PORT MAP(
            palavraControle => palavraControle,
            opCode          => opCode,
            clk             => clk
        );
END ARCHITECTURE;