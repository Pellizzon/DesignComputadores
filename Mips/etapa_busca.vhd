LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY etapa_busca IS
    GENERIC (
        larguraROM : NATURAL := 8 -- deve ser menor ou igual a 32
    );
    PORT (
        clk                  : IN STD_LOGIC;
        PC_prox              : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        instrucao, PC_mais_4 : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
		  PC_at                : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE estrutural OF etapa_busca IS

    -- Sinais auxiliares para a lógica do PC
    SIGNAL PC_s : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

BEGIN

    PC : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => DATA_WIDTH
        )
        PORT MAP(
            data_out => PC_s,
            data_in  => PC_prox,
            clk      => clk,
            enable   => '1',
            reset    => '1' -- reset negado
        );

    Somador : ENTITY work.soma4
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entrada => PC_s,
            saida   => PC_mais_4
        );

    ROM : ENTITY work.ROM(assincrona_pipeline)
        GENERIC MAP(
            dataWidth => DATA_WIDTH,
            addrWidth => larguraROM
        )
        PORT MAP(
            endereco => PC_s(larguraROM - 1 DOWNTO 0),
            dado     => instrucao
        );
		  
	  PC_at <= PC_s;

END ARCHITECTURE;