LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).

ENTITY bancoRegistradores IS
    GENERIC (
        larguraDados        : NATURAL := 32;
        larguraEndBancoRegs : NATURAL := 5 --Resulta em 2^5=32 posicoes
    );
    -- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
    PORT (
        clk : IN std_logic;
        --
        enderecoA : IN std_logic_vector((larguraEndBancoRegs - 1) DOWNTO 0);
        enderecoB : IN std_logic_vector((larguraEndBancoRegs - 1) DOWNTO 0);
        enderecoC : IN std_logic_vector((larguraEndBancoRegs - 1) DOWNTO 0);
        --
        dadoEscritaC : IN std_logic_vector((larguraDados - 1) DOWNTO 0);
        --
        escreveC : IN std_logic := '0';
        saidaA   : OUT std_logic_vector((larguraDados - 1) DOWNTO 0);
        saidaB   : OUT std_logic_vector((larguraDados - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF bancoRegistradores IS

    SUBTYPE palavra_t IS std_logic_vector((larguraDados - 1) DOWNTO 0);
    TYPE memoria_t IS ARRAY(2 ** larguraEndBancoRegs - 1 DOWNTO 0) OF palavra_t;

    -- Declaracao dos registradores:
    SHARED VARIABLE registrador : memoria_t;

BEGIN
    PROCESS (clk) IS
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (escreveC = '1') THEN
                registrador(to_integer(unsigned(enderecoC))) := dadoEscritaC;
            END IF;
        END IF;
    END PROCESS;

    -- IF endereco = 0 : retorna ZERO
    PROCESS (ALL) IS
    BEGIN
        IF (unsigned(enderecoA) = 0) THEN
            saidaA <= (OTHERS => '0');
        ELSE
            saidaA <= registrador(to_integer(unsigned(enderecoA)));
        END IF;
        IF (unsigned(enderecoB) = 0) THEN
            saidaB <= (OTHERS => '0');
        ELSE
            saidaB <= registrador(to_integer(unsigned(enderecoB)));
        END IF;
    END PROCESS;
END ARCHITECTURE;