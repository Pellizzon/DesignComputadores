library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;          -- Biblioteca IEEE para funções aritméticas

entity ULA is
    generic
    (
        larguraDados : natural := 8
    );
    port
    (
        entradaA, entradaB: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
		  seletor: in STD_LOGIC_VECTOR(1 downto 0);
        saida:  out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
    );
end entity;

architecture comportamento of ULA is
	 signal soma : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
 	 signal subtracao : STD_LOGIC_VECTOR((larguraDados-1) downto 0);
    begin
		  soma <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
		  subtracao <= STD_LOGIC_VECTOR(unsigned(entradaB) - unsigned(entradaA)); --Acumulador - RAM (ou Imediato)
        saida <= soma when (seletor(1) = '0' and seletor(0) = '0') else
					  subtracao when (seletor(1) = '0' and seletor(0) = '1') else
					  entradaA when (seletor(1) = '1' and seletor(0) = '0') else
					  entradaA;
	  
end architecture;
