LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY UC_ULA IS
    PORT (
        funct  : IN STD_LOGIC_VECTOR(FUNCT_WIDTH - 1 DOWNTO 0);
        ALUop  : IN STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0);
        ALUctr : OUT STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE bhv OF UC_ULA IS
    SIGNAL ALUop_s : STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0);
BEGIN
    ALUop_s <= ALUop WHEN (ALUop /= readFunctULA) ELSE
        aluOpAdd WHEN (funct = functADD) ELSE
        aluOpSub WHEN (funct = functSUB) ELSE
        aluOpAnd WHEN (funct = functAND) ELSE
        aluOpOr WHEN (funct = functOR) ELSE
        aluOpSlt WHEN (funct = functSLT) ELSE
        (OTHERS => '0');

    ALUctr <= ulaCtrlAdd WHEN (ALUop_s = aluOpAdd) ELSE
        ulaCtrlSub WHEN (ALUop_s = aluOpSub) ELSE
        ulaCtrlAnd WHEN (ALUop_s = aluOpAnd) ELSE
        ulaCtrlOr WHEN (ALUop_s = aluOpOr) ELSE
        ulaCtrlSlt WHEN (ALUop_s = aluOpSlt) ELSE
        (OTHERS => '0');
END bhv;