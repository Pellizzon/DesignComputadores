LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY ULA IS
	GENERIC (
		larguraDados : NATURAL := 32
	);

	PORT (
		entradaA, entradaB : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
		ctr                : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		saida              : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
		flagZero           : OUT STD_LOGIC
	);

END ENTITY;

ARCHITECTURE behv OF ULA IS
	CONSTANT zero : STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0) := (OTHERS => '0');

	SIGNAL saida_s                             : STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
	SIGNAL soma, subtracao, op_or, op_and, slt : STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0);
	SIGNAL overflow_s                          : STD_LOGIC;

BEGIN
	soma      <= STD_LOGIC_VECTOR(signed(entradaA) + signed(entradaB));
	subtracao <= STD_LOGIC_VECTOR(signed(entradaA) + (NOT (signed(entradaB))) + 1);
	op_or     <= entradaA OR entradaB;
	op_and    <= entradaA AND entradaB;
	slt       <= (0 => subtracao(larguraDados - 1) XOR overflow_s, OTHERS => '0');

	saida_s <= soma WHEN (ctr = ulaCtrlAdd) ELSE
		subtracao WHEN (ctr = ulaCtrlSub) ELSE
		op_and WHEN (ctr = ulaCtrlAnd) ELSE
		op_or WHEN (ctr = ulaCtrlOr) ELSE
		slt WHEN (ctr = ulaCtrlSlt) ELSE
		entradaA; -- outra opcao: saida = entradaA

	flagZero <= '1' WHEN unsigned(subtracao) = unsigned(zero) ELSE
		'0';
	overflow_s <= (NOT(entradaA(larguraDados - 1)) AND NOT(entradaB(larguraDados - 1)) AND saida_s(larguraDados - 1))
		OR (entradaA(larguraDados - 1) AND entradaB(larguraDados - 1) AND NOT(saida_s(larguraDados - 1)));

	saida <= saida_s;

END ARCHITECTURE;