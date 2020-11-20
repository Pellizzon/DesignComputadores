LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY clock_generator IS
	GENERIC (
		CLK_PERIOD : TIME := 10ns
	);

	PORT (
		clk : OUT STD_LOGIC
	);

END clock_generator;
ARCHITECTURE test OF clock_generator IS

BEGIN

	clk_generation : PROCESS
	BEGIN
		CLK <= '1';
		WAIT FOR CLK_PERIOD / 2;
		CLK <= '0';
		WAIT FOR CLK_PERIOD / 2;
	END PROCESS clk_generation;
END ARCHITECTURE test;