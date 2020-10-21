LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas

ENTITY ULA IS
    GENERIC (
        larguraDados : NATURAL := 8
    );
    PORT (
        entradaA, entradaB : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
        seletor            : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        saida              : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
        flagZero           : OUT std_logic
    );
END ENTITY;

ARCHITECTURE comportamento OF ULA IS
    CONSTANT zero : std_logic_vector(larguraDados - 1 DOWNTO 0) := (OTHERS => '0');

    SIGNAL soma      : STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
    SIGNAL subtracao : STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
    SIGNAL op_and    : STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
    SIGNAL op_or     : STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
    SIGNAL op_xor    : STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
    SIGNAL op_not    : STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
BEGIN
    soma      <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
    subtracao <= STD_LOGIC_VECTOR(unsigned(entradaA) - unsigned(entradaB));
    op_and    <= entradaA AND entradaB;
    op_or     <= entradaA OR entradaB;
    op_xor    <= entradaA XOR entradaB;
    op_not    <= NOT entradaA;

    saida <= soma WHEN (seletor = "000") ELSE
        subtracao WHEN (seletor = "001") ELSE
        entradaA WHEN (seletor = "010") ELSE
        entradaB WHEN (seletor = "011") ELSE
        op_xor WHEN (seletor = "100") ELSE
        op_not WHEN (seletor = "101") ELSE
        op_and WHEN (seletor = "110") ELSE
        op_or WHEN (seletor = "111") ELSE
        entradaA; -- outra opcao: saida = entradaA

    flagZero <= '1' WHEN unsigned(saida) = unsigned(zero) ELSE
        '0';
END ARCHITECTURE;