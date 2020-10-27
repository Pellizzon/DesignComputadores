LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY UC IS
  PORT (
    opCode          : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    funct           : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    palavraControle : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000"
  );
END ENTITY;

ARCHITECTURE comportamento OF UC IS

  ALIAS BEQ                : STD_LOGIC IS palavraControle(9);
  ALIAS selDataToWriteReg3 : STD_LOGIC IS palavraControle(8);
  ALIAS selEntradaB_ULA    : STD_LOGIC IS palavraControle(7);
  ALIAS selEndRegC         : STD_LOGIC IS palavraControle(6);
  ALIAS writeRegC          : STD_LOGIC IS palavraControle(5);
  ALIAS aluOp              : STD_LOGIC_VECTOR(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
  ALIAS memRd              : STD_LOGIC IS palavraControle(1);
  ALIAS memWr              : STD_LOGIC IS palavraControle(0);

BEGIN

  BEQ <= '1' WHEN opCode = opCodeBEQ ELSE
    -- '0' WHEN opCode = opCodeTipoR ELSE
    -- '0' WHEN opCode = opCodeSW ELSE
    -- '0' WHEN opCode = opCodeLW ELSE
    '0';

  selDataToWriteReg3 <= '0' WHEN opCode = opCodeTipoR ELSE
    -- '1' WHEN opCode = opCodeSW ELSE
    -- '1' WHEN opCode = opCodeLW ELSE
    -- '1' WHEN opCode = opCodeBEQ ELSE
    '1';

  selEntradaB_ULA <= '0' WHEN opCode = opCodeTipoR ELSE
    -- '1' WHEN opCode = opCodeSW ELSE
    -- '1' WHEN opCode = opCodeLW ELSE
    -- '1' WHEN opCode = opCodeBEQ ELSE
    '1';

  selEndRegC <= '0' WHEN opCode = opCodeTipoR ELSE
    -- '1' WHEN opCode = opCodeSW ELSE
    -- '1' WHEN opCode = opCodeLW ELSE
    -- '1' WHEN opCode = opCodeBEQ ELSE
    '1';

  writeRegC <= '1' WHEN opCode = opCodeTipoR ELSE
    '1' WHEN opCode = opCodeLW ELSE
    -- '0' WHEN opCode = opCodeSW ELSE
    -- '0' WHEN opCode = opCodeBEQ ELSE
    '0';

  aluOP <= execAddULA WHEN opCode = opCodeTipoR AND funct = functADD ELSE -- add
    execSubULA WHEN opCode = opCodeTipoR AND funct = functSUB ELSE          -- sub
    execAndULA WHEN opCode = opCodeTipoR AND funct = functAND ELSE          -- and
    execOrULA WHEN opCode = opCodeTipoR AND funct = functOR ELSE            -- or
    execSltULA WHEN opCode = opCodeTipoR AND funct = functSLT ELSE          -- slt
    execAddULA WHEN opCode = opCodeSW ELSE                                  -- SW
    execAddULA WHEN opCode = opCodeLW ELSE                                  -- LW
    execSubULA WHEN opCode = opCodeBEQ ELSE                                 -- BEQ
    "000";

  memRd <= '1' WHEN opCode = opCodeLW ELSE
    -- '0' WHEN opCode = opCodeTipoR ELSE
    -- '0' WHEN opCode = opCodeRW ELSE
    -- '0' WHEN opCode = opCodeBEQ ELSE
    '0';
  memWr <= '1' WHEN opCode = opCodeSW ELSE
    -- '0' WHEN opCode = opCodeTipoR ELSE
    -- '0' WHEN opCode = opCodeSW ELSE
    -- '0' WHEN opCode = opCodeBEQ ELSE
    '0';

END ARCHITECTURE;