LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas

ENTITY UC IS
  PORT (
    opCode          : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    funct           : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    palavraControle : OUT STD_LOGIC_VECTOR(5 DOWNTO 0) := 6x"00"
  );
END ENTITY;

ARCHITECTURE comportamento OF UC IS

  ALIAS writeRegC : std_logic IS palavraControle(5);
  ALIAS aluOp     : std_logic_vector(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
  ALIAS memRd     : std_logic IS palavraControle(1);
  ALIAS memWr     : std_logic IS palavraControle(0);

BEGIN

  writeRegC <= '1' WHEN opCode = 6x"00" ELSE
  '0';

  aluOP <= "000" WHEN opCode = 6x"00" AND funct = 6x"20" ELSE -- add
  "001" WHEN opCode = 6x"00" AND funct = 6x"22" ELSE          -- sub
  "010" WHEN opCode = 6x"00" AND funct = 6x"24" ELSE          -- and
  "011" WHEN opCode = 6x"00" AND funct = 6x"25" ELSE          -- or
  "100" WHEN opCode = 6x"00" AND funct = 6x"2A" ELSE          -- slt
  "111";
  
  memRd <= '0' WHEN opCode = 6x"00" ELSE 
  '1';
  memWr <= '0' WHEN opCode = 6x"00" ELSE 
  '1';
  
END ARCHITECTURE;