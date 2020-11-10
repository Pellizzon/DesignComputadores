LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE constantesMIPS IS

    --  Exemplos:
    --  signal Instruction : Bit_Vector(15 downto 0);
    --  alias OpCode : Bit_Vector(3 downto 0) is Instruction(15 downto 12);
    --  subtype TypeWord is unsigned( 31 downto 0 );
    --  type    TypeArrayWord is array (natural range <>) of unsigned( 31 downto 0 );
    --  constant FUNCT_WIDTH : natural := 6;
    CONSTANT IMED_JMP_WIDTH     : NATURAL := 26;
    CONSTANT IMED_WIDTH         : NATURAL := 16;
    CONSTANT SHAMT_WIDTH        : NATURAL := 5;
    CONSTANT FUNCT_WIDTH        : NATURAL := 6;
    CONSTANT OPCODE_WIDTH       : NATURAL := 6;
    CONSTANT DATA_WIDTH         : NATURAL := 32;
    CONSTANT ADDR_WIDTH         : NATURAL := 32;
    CONSTANT REGBANK_ADDR_WIDTH : NATURAL := 5;
    CONSTANT ALU_OP_WIDTH       : NATURAL := 2;
    CONSTANT CTRL_ALU_WIDTH     : NATURAL := 3;
    CONSTANT CONTROLWORD_WIDTH  : NATURAL := 10;

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
    CONSTANT opCodeLW  : opCode_t := "100011";
    CONSTANT opCodeSW  : opCode_t := "101011";
    CONSTANT opCodeBEQ : opCode_t := "000100";
    --
    CONSTANT opCodeTipoJ : opCode_t := "000010";

    --
    -- Codigos da palavra de controle:
    --  alias memWRsignal: std_logic is controlWord(0);
    --  alias memRDsignal: std_logic is controlWord(1);
    --  alias beqSignal:   std_logic is controlWord(2);
    --  alias muxUlaMem:   std_logic is controlWord(3);
    --  alias ulaOPvalue:  std_logic_vector(1 downto 0) is controlWord(5 downto 4);
    --  alias muxRtImed:   std_logic is controlWord(6);
    --  alias regcWRsignal:std_logic is controlWord(7);
    --  alias muxRtRd:     std_logic is controlWord(8);
    --  alias muxPcBeqJ:   std_logic is controlWord(9);
    --
    -- ControlWorld Bit:    9   8       7           6     5,4    3     2      1       0
    --Instrução  Opcode    Mux1 Mux2 HabEscritaReg Mux3  ULAOp  Mux4  BEQ HabLeMEM HabEscME
    --Tipo R    |00.0000  | 0 |  1 |     1        |  0  |  10  |  0  | 0 |    0   |    0    |
    --LW        |10.0011  | 0 |  0 |     1        |  1  |  00  |  1  | 0 |    1   |    0    |
    --SW        |10.1011  | 0 |  0 |     0        |  1  |  00  |  0  | 0 |    0   |    1    |
    --BEQ       |00.0100  | 0 |  0 |     0        |  0  |  01  |  0  | 1 |    0   |    0    |
    --J         |00.0010  | 1 |  X |     0        |  X  |  XX  |  X  | X |    0   |    0    |

    --  Mux1: mux([PC+4, BEQ]/J);  Mux2: mux(Rt/Rd); Mux3: mux(Rt/imediato);  Mux4: mux(ULA/mem).

    --  -- ULA ---
    SUBTYPE operacaoULA_t IS STD_LOGIC_VECTOR(2 DOWNTO 0);

    CONSTANT execAndULA : operacaoULA_t := "000";
    CONSTANT execOrULA  : operacaoULA_t := "001";
    CONSTANT execAddULA : operacaoULA_t := "010";
    CONSTANT execSubULA : operacaoULA_t := "110";
    CONSTANT execSltULA : operacaoULA_t := "111";
END PACKAGE constantesMIPS;