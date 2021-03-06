library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity equacao is
  generic(
    larguraDados  : natural :=  4
  );
  port(
    -- Input ports
    x  :  in  std_logic_vector(larguraDados-1 downto 0);
	 y  :  in  std_logic_vector(larguraDados-1 downto 0);
    -- Output ports
    dataOUT :  out  std_logic_vector(larguraDados-1 downto 0)
  );
end entity;

architecture implementacao of equacao is

component somadorGenerico is
  port( 
		entradaA, entradaB: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      saida:  out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
  );
end component;

component subtratorGenerico is 
  port(
		entradaA, entradaB: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
      saida:  out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
  );
end component;

signal x_2, y_2, y_3, x2_y3, resultado: std_logic_vector(larguraDados-1 downto 0);
signal SEVEN: STD_LOGIC_VECTOR(larguraDados-1 downto 0) := "0111";
		
begin

XVezes1: somadorGenerico port map(
	entradaA=>x, 
	entradaB=>x, 
	saida=>x_2
	);

YMaisY: somadorGenerico port map(
	entradaA=>y, 
	entradaB=>y, 
	saida=>y_2
	);

YMais2Y: somadorGenerico port map(
	entradaA=>y_2, 
	entradaB=>y, 
	saida=>y_3
	);

Subtracao: subtratorGenerico port map(
	entradaA=>x_2, 
	entradaB=>y_3, 
	saida=>x2_y3
	);
	
Total: somadorGenerico port map(
	entradaA=>x2_y3, 
	entradaB=>"0111", 
	saida=>resultado
	);

dataOUT <= resultado;
  
end implementacao;
