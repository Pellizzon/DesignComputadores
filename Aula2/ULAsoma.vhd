library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity ULAsoma is
  generic ( larguraDados : natural := 8);
  port (
    entradaA, entradaB: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
    operacao: in STD_LOGIC;
    saida: out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
  );
end entity;

architecture comportamento of ULAsoma is
  signal soma, subtracao: STD_LOGIC_VECTOR((larguraDados-1) downto 0);
  begin
    soma <= STD_LOGIC_VECTOR(unsigned(entradaA) + unsigned(entradaB));
    subtracao <= STD_LOGIC_VECTOR(unsigned(entradaA) - unsigned(entradaB));
    saida <= soma when (operacao = '1') else subtracao;
end architecture;