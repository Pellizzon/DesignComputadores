LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE constantesMIPS IS

    CONSTANT FUNCT_WIDTH        : NATURAL := 6;
    CONSTANT OPCODE_WIDTH       : NATURAL := 6;
    CONSTANT CONTROLWORD_WIDTH  : NATURAL := 11 + 3;
    CONSTANT DATA_WIDTH         : NATURAL := 32;
    CONSTANT ADDR_WIDTH         : NATURAL := 32;
    CONSTANT REGBANK_ADDR_WIDTH : NATURAL := 5;
    CONSTANT ALU_OP_WIDTH       : NATURAL := 3;
    CONSTANT CTRL_ALU_WIDTH     : NATURAL := 4;

    -- codigos das instrucoes do DLX:
    SUBTYPE opCode_t IS STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);
    SUBTYPE funct_t IS STD_LOGIC_VECTOR(FUNCT_WIDTH - 1 DOWNTO 0);
    SUBTYPE ctrlWorld_t IS STD_LOGIC_VECTOR(CONTROLWORD_WIDTH - 1 DOWNTO 0);
    SUBTYPE aluOp_t IS STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0);
    SUBTYPE ctrlALU_t IS STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0);

    SUBTYPE dado_t IS STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SUBTYPE addr_t IS STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    --
    CONSTANT functADD : funct_t := "100000";
    CONSTANT functSUB : funct_t := "100010";
    CONSTANT functAND : funct_t := "100100";
    CONSTANT functOR  : funct_t := "100101";
    CONSTANT functSLT : funct_t := "101010";

    CONSTANT opCodeTipoR : opCode_t := "000000";
    --
    CONSTANT opCodeLW   : opCode_t := "100011";
    CONSTANT opCodeSW   : opCode_t := "101011";
    CONSTANT opCodeBEQ  : opCode_t := "000100";
    CONSTANT opCodeLUI  : opCode_t := "001111";
    CONSTANT opCodeADDI : opCode_t := "001000";
    CONSTANT opCodeANDI : opCode_t := "001100";
    CONSTANT opCodeORI  : opCode_t := "001101";
    CONSTANT opCodeSLTI : opCode_t := "001010";
    CONSTANT opCodeBNE  : opCode_t := "000101";
    --
    CONSTANT opCodeTipoJ : opCode_t := "000010";

    -- ALU ---
    CONSTANT readFunctULA : aluOp_t := "000";
    CONSTANT aluOpAdd     : aluOp_t := "001";
    CONSTANT aluOpSub     : aluOp_t := "010";
    CONSTANT aluOpAnd     : aluOp_t := "011";
    CONSTANT aluOpOr      : aluOp_t := "100";
    CONSTANT aluOpSlt     : aluOp_t := "101";
    CONSTANT aluOpLui     : aluOp_t := "110";
    CONSTANT aluOpDC      : aluOp_t := "XXX";
    -- ALUctr:
    -- 3: inverteA
    -- 2: inverteB
    -- 1-0: sel_mux_ula_op      0 AND 1 OR 2 ADD 3 SLT

    CONSTANT ulaCtrlAdd : ctrlALU_t := "0010";
    CONSTANT ulaCtrlSub : ctrlALU_t := "0110";
    CONSTANT ulaCtrlAnd : ctrlALU_t := "0000";
    CONSTANT ulaCtrlOr  : ctrlALU_t := "0001";
    CONSTANT ulaCtrlSlt : ctrlALU_t := "0111";
    CONSTANT ulaCtrlLui : ctrlALU_t := "1000";

    -- Pontos de controle:
    -- 7: escreve_RC
    -- 6: escreve_RAM
    -- 5: leitura_RAM
    -- 4: sel_mux_ula_mem:      0 ULA 1 MEM         (escrita no REG)
    -- 3: sel_mux_rd_rt:        0 RT_addr 1 RD_addr (endereço de escrita)
    -- 2: sel_mux_banco_ula:    0 REG_B 1 imediato  (ULA opera com REG ou imediato)
    -- 1: sel_mux_beq:          0 PC+4  1 PC+4+imediato
    -- 0: sel_mux_jump:         0 saida mux_beq 1 PC+4 & imediato

    -- ControlWorld Bit:        0             1             2               3                  4                 5          8-6          9              10
    --Instrução  Opcode      escreve_RC  escreve_RAM   leitura_RAM   sel_mux_ula_mem   sel_mux_banco_ula    sel_mux_beq    ALUop    sel_mux_jump   sel_mux_rd_rt 
    --Tipo R    |00.0000  |     1      |      0      |      X      |        0        |         0         |       0       | read  |       0       |       1       |
    --J         |00.0010  |     0      |      0      |      X      |        X        |         X         |       0       | X     |       1       |       X       |
    --BEQ       |00.0100  |     0      |      0      |      X      |        X        |         0         |       1       | sub   |       0       |       X       |
    --LW        |10.0011  |     1      |      0      |      1      |        1        |         1         |       0       | add   |       0       |       0       |
    --SW        |10.1011  |     0      |      1      |      X      |        X        |         1         |       0       | add   |       0       |       X       |

    --  Mux1: mux([PC+4, BEQ]/J);  Mux2: mux(Rt/Rd); Mux3: mux(Rt/imediato);  Mux4: mux(ULA/mem).

    -- CONSTANT ctrlTipoR   : ctrlWorld_t := "10" & readFunctULA & "000X01";
    -- CONSTANT ctrlTipoJ   : ctrlWorld_t := "X1" & aluOpDC & "0XXX00";
    -- CONSTANT ctrlTipoBEQ : ctrlWorld_t := "X0" & aluOpSub & "10XX00";
    -- CONSTANT ctrlTipoLW  : ctrlWorld_t := "00" & aluOpAdd & "011101";
    -- CONSTANT ctrlTipoSW  : ctrlWorld_t := "X0" & aluOpAdd & "01XX10";

END PACKAGE constantesMIPS;