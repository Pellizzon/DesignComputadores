-- Quartus Prime VHDL Template
-- Unsigned Adder/Subtractor

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unsigned_adder_subtractor is

	generic
	(
		DATA_WIDTH : natural := 8
	);

	port 
	(
		a		: in unsigned ((DATA_WIDTH-1) downto 0);
		b		: in unsigned ((DATA_WIDTH-1) downto 0);
		add_sub : in std_logic;
		result	: out unsigned ((DATA_WIDTH-1) downto 0)
--		z : out std_logic
	);

end entity;

architecture rtl of unsigned_adder_subtractor is
begin

	process(a,b,add_sub)
	begin
		-- add if "add_sub" is 1, else subtract
		if (add_sub = '1') then
			result <= a + b;
		else
			result <= a - b;
		end if;
	end process;

--	z <= '1' when result = 0 else '0';
end rtl;
