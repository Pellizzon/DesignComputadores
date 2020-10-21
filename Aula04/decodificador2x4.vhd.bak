library ieee;
use ieee.std_logic_1164.all;

entity decodificador2x4 is
  port (
    seletor  : in std_logic_vector(1 downto 0);
    habilita : out std_logic_vector(3 downto 0)
  );
end entity;

architecture comportamento of decodificador2x4 is
  begin
	 with seletor select
	 habilita <= "0001" when "00",
				    "0010" when "01",
					 "0100" when "10",
					 "1000" when "11",
					 "0000" when others;
end architecture;