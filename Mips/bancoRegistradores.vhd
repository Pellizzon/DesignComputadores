LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).
ENTITY bancoRegistradores IS
	GENERIC (
		larguraDados        : NATURAL := 32;
		larguraEndBancoRegs : NATURAL := 5
	);
	-- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
	PORT (
		clk : IN STD_LOGIC;
		--
		enderecoA : IN STD_LOGIC_VECTOR((larguraEndBancoRegs - 1) DOWNTO 0);
		enderecoB : IN STD_LOGIC_VECTOR((larguraEndBancoRegs - 1) DOWNTO 0);
		enderecoC : IN STD_LOGIC_VECTOR((larguraEndBancoRegs - 1) DOWNTO 0);
		--
		dadoEscritaC : IN STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
		--
		escreveC : IN STD_LOGIC;
		--
		saidaA : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
		saidaB : OUT STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE rtl OF bancoRegistradores IS
	SUBTYPE register_t IS STD_LOGIC_VECTOR((larguraDados - 1) DOWNTO 0);
	TYPE reg_bank_t IS ARRAY(0 TO 2 ** larguraEndBancoRegs - 1) OF register_t;

	FUNCTION initMemory
		RETURN reg_bank_t IS VARIABLE tmp : reg_bank_t := (OTHERS => (OTHERS => '0'));
	BEGIN
		-- Inicializa os endereços:
		tmp(0)  := x"00000000";
		tmp(8)  := x"00000000";
		tmp(9)  := x"0000000A";
		tmp(10) := x"0000000B";
		tmp(11) := x"0000000C";
		tmp(12) := x"0000000D";
		tmp(13) := x"00000016";
		RETURN tmp;
	END initMemory;

	SIGNAL bancoReg : reg_bank_t                                  := initMemory;
	CONSTANT zero   : STD_LOGIC_VECTOR(larguraDados - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (escreveC = '1') THEN
				bancoReg(to_integer(unsigned(enderecoC))) <= dadoEscritaC;
			END IF;
		END IF;
	END PROCESS;
	saidaA <= zero WHEN to_integer(unsigned(enderecoA)) = to_integer(unsigned(zero)) ELSE
		bancoReg(to_integer(unsigned(enderecoA)));
	saidaB <= zero WHEN to_integer(unsigned(enderecoB)) = to_integer(unsigned(zero)) ELSE
		bancoReg(to_integer(unsigned(enderecoB)));
END rtl;