library ieee;
use ieee.std_logic_1164.all;

entity MEF is

	generic
	(
		ROM_ADDR_WIDTH : natural := 8;
		PT_CONTROL_WIDTH : natural := 14;
		STATE_WIDTH : natural := 4;
		ROM_DATA_WIDTH : natural := 18
	);

	port 
	(
		CLK: in std_Logic;
		--Entradas : in std_logic_vector (3 downto 0);
		Pontos_de_Controle : out std_logic_vector (PT_CONTROL_WIDTH-1 downto 0)
	);

end entity;

architecture rtl of MEF is

	signal ROM_Dado : std_logic_vector ((ROM_DATA_WIDTH-1) downto 0);
	signal ROM_Endereco : std_logic_vector ((ROM_ADDR_WIDTH-1) downto 0);
	signal Estado_Atual : std_logic_vector ((STATE_WIDTH-1) downto 0);
	signal Prox_Estado : std_logic_vector ((STATE_WIDTH-1) downto 0);

begin
	ROM_Endereco <= "0000" & Estado_Atual;
	Prox_Estado <= ROM_Dado (3 downto 0);
	Pontos_de_Controle <= ROM_Dado (17 downto 4);
	
	memoria1  : entity work.memoria generic map (dataWidth => ROM_DATA_WIDTH, addrWidth => ROM_ADDR_WIDTH)
		port map(Endereco => ROM_Endereco, Dado => ROM_Dado);

		
		
	regA  : entity work.registradorGenerico generic map (larguraDados => STATE_WIDTH)
		port map(DIN => Prox_Estado, DOUT => Estado_Atual, ENABLE => '1', CLK => clk, RST => '0');
end architecture;
