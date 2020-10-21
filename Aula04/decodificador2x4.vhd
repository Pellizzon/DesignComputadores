LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decodificador2x4 IS
	PORT (
		seletor  : IN std_logic_vector(7 DOWNTO 0);
		habilita : OUT std_logic_vector(3 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE comportamento OF decodificador2x4 IS

	SIGNAL bloco     : std_logic_vector(3 DOWNTO 0);
	SIGNAL sel_bloco : std_logic_vector(1 DOWNTO 0);

BEGIN
	sel_bloco <= seletor(7 DOWNTO 6);
	WITH sel_bloco SELECT
		bloco <= "0001" WHEN "00",
		"0010" WHEN "01",
		"0100" WHEN "10",
		"1000" WHEN "11",
		"0000" WHEN OTHERS;

	habilita(0) <= bloco(0);
	habilita(1) <= bloco(1); -- Habilitar RAM faixa 64 - 127
	habilita(2) <= bloco(2) AND ((NOT seletor(3)) AND seletor(2) AND (NOT seletor(1)) AND (NOT seletor(0)));
	-- (not (seletor(3) or (not seletor(2)) or seletor(1) and not seletor(0)))
	-- Interface Chaves: está alocada no endereço: 132
	habilita(3) <= bloco(3) AND (seletor(3) AND (NOT seletor(2)) AND (NOT seletor(1)) AND (NOT seletor(0)));
	-- Interface LEDs: está alocada no endereço: 200.

END ARCHITECTURE;