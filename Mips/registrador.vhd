
-- Quartus Prime VHDL Template
-- One-bit wide, N-bit long shift register with asynchronous reset

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador IS

	GENERIC (
		NUM_BITS : NATURAL := 3
	);

	PORT (
		clk : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		data_in : IN STD_LOGIC_VECTOR(NUM_BITS - 1 DOWNTO 0);
		data_out : OUT STD_LOGIC_VECTOR(NUM_BITS - 1 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE rtl OF Registrador IS
	SIGNAL data_s : STD_LOGIC_VECTOR(NUM_BITS - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS (clk, reset)
	BEGIN
		-- Reset whenever the reset signal goes low, regardless of the clock
		-- or the clock enable
		IF (reset = '0') THEN
			data_s <= (OTHERS => '0');
			-- If not resetting, and the clock signal is enabled on this register, 
			-- update the register output on the clock's rising edge
		ELSIF (rising_edge(clk)) THEN
			IF (enable = '1') THEN
				data_s <= data_in;
			END IF;
		END IF;
	END PROCESS;

	data_out <= data_s;

END rtl;