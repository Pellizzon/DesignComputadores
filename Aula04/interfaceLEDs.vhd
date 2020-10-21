library ieee;
use ieee.std_logic_1164.all;

entity interfaceLEDs is
  generic (
         dataWidth: natural := 8
   );
  port (
    entrada  : in std_logic_vector(dataWidth-1 downto 0);
	 habilita : in std_logic;
	 clk      : in std_logic;
	 saida    : out std_logic_vector(dataWidth-1 downto 0)
  );
end entity;

architecture comportamento of interfaceLEDs is
begin
    process(clk)
    begin
		if (rising_edge(clk)) then
			 if (habilita = '1') then
					saida <= entrada;
			 end if;
		end if;
	 end process;
end architecture;
