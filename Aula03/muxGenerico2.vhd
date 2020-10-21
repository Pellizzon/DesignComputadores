
library ieee;
use ieee.std_logic_1164.all;

entity muxGenerico2 is
    generic (
        -- Total de bits das entradas e saidas
        larguraDados    : natural  :=   8
    );
    port (
        entradaA_MUX    : in  std_logic_vector(larguraDados-1 downto 0);
        entradaB_MUX    : in  std_logic_vector(larguraDados-1 downto 0);
        seletor_MUX   : in  std_logic;

        saida_MUX   : out std_logic_vector(larguraDados-1 downto 0)
    );
end entity;

architecture comportamento of muxGenerico2 is
begin
  -- Para sintetizar lógica combinacional usando um processo,
  --  todas as entradas do modulo devem aparecer na lista de sensibilidade.
    process(entradaA_MUX, entradaB_MUX, seletor_MUX) is
    begin
     -- If é uma instrução sequencial que não pode ser usada
     --  na seção de instruções concorrentes da arquitetura.
        if(seletor_MUX='0') then
            saida_MUX <= entradaA_MUX;
        else
            saida_MUX <= entradaB_MUX;
        end if;
    end process;
end architecture;