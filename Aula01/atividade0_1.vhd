library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Atividade0_1 is
	generic(
		 larguraDados  : natural :=  4
		 );
	port(
		SW      : in  std_logic_vector(9 downto 0);
		LEDR    : out std_logic_vector(9 downto 0)
		);	
end entity;

architecture rtl of Atividade0_1 is

component equacao is
  port( 
		x, y: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      dataOUT:  out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
  );
end component;
		
begin

EQU: equacao port map(
	x=>SW(3 downto 0),
	y=>SW(9 downto 6),
	dataOUT=>LEDR(3 downto 0)
	);
  
end rtl;
