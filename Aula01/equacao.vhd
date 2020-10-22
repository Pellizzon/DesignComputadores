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

signal x_2, x_3, y_2, x3_y2, resultado: std_logic_vector(larguraDados-1 downto 0);
		
begin

XVezes2: somadorGenerico port map(
	entradaA=>x, 
	entradaB=>x, 
	saida=>x_2
	);
	
XVezes3: somadorGenerico port map(
	entradaA=>x_2, 
	entradaB=>x, 
	saida=>x_3
	);

YVezes2: somadorGenerico port map(
	entradaA=>y, 
	entradaB=>y, 
	saida=>y_2
	);

Subtracao: subtratorGenerico port map(
	entradaA=>x_3, 
	entradaB=>y_2, 
	saida=>x3_y2
	);
	
Total: somadorGenerico port map(
	entradaA=>x3_y2, 
	entradaB=>"0101", 
	saida=>resultado
	);

dataOUT <= resultado;
  
end implementacao;
