LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY UC IS
    PORT (
        opcode           : IN STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);
        pontosDeControle : OUT STD_LOGIC_VECTOR(CONTROLWORD_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE bhv OF UC IS

    ALIAS lui               : STD_LOGIC IS pontosDeControle(11);
    ALIAS sel_mux_rd_rt     : STD_LOGIC IS pontosDeControle(10);
    ALIAS sel_mux_jump      : STD_LOGIC IS pontosDeControle(9);
    ALIAS ULAop             : STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0) IS pontosDeControle(8 DOWNTO 6);
    ALIAS sel_beq           : STD_LOGIC IS pontosDeControle(5);
    ALIAS sel_mux_banco_ula : STD_LOGIC IS pontosDeControle(4);
    ALIAS sel_mux_ula_mem   : STD_LOGIC IS pontosDeControle(3);
    ALIAS leitura_RAM       : STD_LOGIC IS pontosDeControle(2);
    ALIAS escreve_RAM       : STD_LOGIC IS pontosDeControle(1);
    ALIAS escreve_RC        : STD_LOGIC IS pontosDeControle(0);

BEGIN

    lui <= '1' WHEN opCode = opCodeLUI ELSE
        '0';

    sel_mux_rd_rt <= '1' WHEN opCode = opCodeTipoR ELSE
        '0';

    sel_mux_jump <= '1' WHEN opCode = opCodeTipoJ ELSE
        '0';

    ULAop <= readFunctULA WHEN opcode = opCodeTipoR ELSE
        aluOpDC WHEN opcode = opCodeTipoJ ELSE
        aluOpSub WHEN opcode = opCodeBEQ ELSE
        aluOpAdd WHEN opcode = opCodeLW OR opcode = opCodeSW ELSE
        aluOpLui WHEN opCode = opCodeLUI ELSE
        aluOpAdd WHEN opCode = opCodeADDI ELSE
        "000";

    sel_beq <= '1' WHEN opCode = opCodeBEQ ELSE
        '0';

    sel_mux_banco_ula <= '1' WHEN opCode = opCodeSW ELSE
        '1' WHEN opCode = opCodeLW ELSE
        '1' WHEN opCode = opCodeLUI ELSE
        '1' WHEN opCode = opCodeADDI ELSE
        '0';

    sel_mux_ula_mem <= '1' WHEN opCode = opCodeLW ELSE
        '0';

    leitura_RAM <= '1' WHEN opCode = opCodeLW ELSE
        '0';

    escreve_RAM <= '1' WHEN opCode = opCodeSW ELSE
        '0';

    escreve_RC <= '1' WHEN opCode = opCodeTipoR ELSE
        '1' WHEN opCode = opCodeLW ELSE
        '1' WHEN opCode = opCodeLUI ELSE
        '1' WHEN opCode = opCodeADDI ELSE
        '0';

END bhv;