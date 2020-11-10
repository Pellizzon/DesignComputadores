LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Biblioteca IEEE para funções aritméticas
USE work.constantesMIPS.ALL;

ENTITY aluUC IS
  PORT (
    ctrlUC_ULA : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    funct      : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    aluOp      : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE comportamento OF aluUC IS
BEGIN

  aluOp <= execAddULA WHEN ctrlUC_ULA = "00" ELSE
    execAddULA WHEN ctrlUC_ULA = "10" AND funct = functADD ELSE
    execSubULA WHEN ctrlUC_ULA = "01" ELSE
    execSubULA WHEN ctrlUC_ULA = "10" AND funct = functSUB ELSE
    execAndULA WHEN ctrlUC_ULA = "10" AND funct = functAND ELSE
    execOrULA WHEN ctrlUC_ULA = "10" AND funct = functOR ELSE
    execSltULA WHEN ctrlUC_ULA = "10" AND funct = functSLT ELSE
    "111";

END ARCHITECTURE;