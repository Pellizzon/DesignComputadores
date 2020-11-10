LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY UC IS
  PORT (
    opCode          : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    palavraControle : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE comportamento OF UC IS

  ALIAS selMUX_PC      : STD_LOGIC IS palavraControle(9);
  ALIAS BEQ            : STD_LOGIC IS palavraControle(8);
  ALIAS selULA_MEM     : STD_LOGIC IS palavraControle(7);
  ALIAS selMux_Rt_Imed : STD_LOGIC IS palavraControle(6);
  ALIAS selRt_Rd       : STD_LOGIC IS palavraControle(5);
  ALIAS writeRegC      : STD_LOGIC IS palavraControle(4);
  ALIAS ctrlUC_ULA     : STD_LOGIC_VECTOR(1 DOWNTO 0) IS palavraControle(3 DOWNTO 2);
  ALIAS memRd          : STD_LOGIC IS palavraControle(1);
  ALIAS memWr          : STD_LOGIC IS palavraControle(0);

BEGIN

  selMUX_PC <= '1' WHEN opCode = opCodeTipoJ ELSE
    '0';

  BEQ <= '1' WHEN opCode = opCodeBEQ ELSE
    --  '0' WHEN opCode = opCodeTipoR ELSE
    --  '0' WHEN opCode = opCodeSW ELSE
    --  '0' WHEN opCode = opCodeLW ELSE
    --  '0' WHEN opCode = opCodeTipoJ ELSE
    '0';

  selULA_MEM <= '1' WHEN opCode = opCodeLW ELSE
    --  '0' WHEN opCode = opCodeTipoR ELSE
    --	'0' WHEN opCode = opCodeBEQ ELSE
    --  '0' WHEN opCode = opCodeSW ELSE
    '0';

  selMux_Rt_Imed <= '1' WHEN opCode = opCodeSW ELSE
    '1' WHEN opCode = opCodeLW ELSE
    --	 '0' WHEN opCode = opCodeTipoR ELSE
    --  '0' WHEN opCode = opCodeBEQ ELSE
    '0';

  selRt_Rd <= '1' WHEN opCode = opCodeTipoR ELSE
    -- '1' WHEN opCode = opCodeSW ELSE
    -- '1' WHEN opCode = opCodeLW ELSE
    -- '1' WHEN opCode = opCodeBEQ ELSE
    '0';

  writeRegC <= '1' WHEN opCode = opCodeTipoR ELSE
    '1' WHEN opCode = opCodeLW ELSE
    -- '0' WHEN opCode = opCodeSW ELSE
    -- '0' WHEN opCode = opCodeBEQ ELSE
    '0';

  ctrlUC_ULA <= "00" WHEN opCode = opCodeSW ELSE
    "00" WHEN opCode = opCodeLW ELSE
    "01" WHEN opcode = opCodeBEQ ELSE
    "10" WHEN opcode = opCodeTipoR ELSE
    "11";

  --  execAddULA WHEN opCode = opCodeTipoR AND funct = functADD ELSE -- add
  --    execSubULA WHEN opCode = opCodeTipoR AND funct = functSUB ELSE          -- sub
  --    execAndULA WHEN opCode = opCodeTipoR AND funct = functAND ELSE          -- and
  --    execOrULA WHEN opCode = opCodeTipoR AND funct = functOR ELSE            -- or
  --    execSltULA WHEN opCode = opCodeTipoR AND funct = functSLT ELSE          -- slt
  --    execAddULA WHEN opCode = opCodeSW ELSE                                  -- SW
  --    execAddULA WHEN opCode = opCodeLW ELSE                                  -- LW
  --    execSubULA WHEN opCode = opCodeBEQ ELSE                                 -- BEQ
  --    "000";

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