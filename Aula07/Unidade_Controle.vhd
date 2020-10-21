LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Unidade_Controle IS
    GENERIC (
        DATA_WIDTH : NATURAL := 8;
        ADDR_WIDTH : NATURAL := 8
    );
    PORT (
        -- Input ports
        clk    : IN std_logic;
        opCode : IN std_logic_vector(3 DOWNTO 0);
        -- Output ports
        palavraControle : OUT std_logic_vector(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch_name OF Unidade_Controle IS
    ALIAS selMuxProxPC         : std_logic IS palavraControle(7);
    ALIAS selMuxULAImed        : std_logic IS palavraControle(6);
    ALIAS HabEscritaAcumulador : std_logic IS palavraControle(5);
    ALIAS selOperacaoULA       : std_logic_vector(2 DOWNTO 0) IS palavraControle(4 DOWNTO 2);
    ALIAS habLeituraMEM        : std_logic IS palavraControle(1);
    ALIAS habEscritaMEM        : std_logic IS palavraControle(0);

    SIGNAL instrucao          : std_logic_vector(6 DOWNTO 0);
    CONSTANT opCodeJump       : std_logic_vector(3 DOWNTO 0) := "0000";
    CONSTANT opCodeLoad       : std_logic_vector(3 DOWNTO 0) := "0001";
    CONSTANT opCodeStore      : std_logic_vector(3 DOWNTO 0) := "0010";
    CONSTANT opCodeSumAccMem  : std_logic_vector(3 DOWNTO 0) := "0011";
    CONSTANT opCodeSumAccImed : std_logic_vector(3 DOWNTO 0) := "0100";
    CONSTANT opCodeSubAccMem  : std_logic_vector(3 DOWNTO 0) := "0101";
    CONSTANT opCodeSubAccImed : std_logic_vector(3 DOWNTO 0) := "0110";

    ALIAS jump       : std_logic IS instrucao(0);
    ALIAS load       : std_logic IS instrucao(1);
    ALIAS store      : std_logic IS instrucao(2);
    ALIAS sumAccMem  : std_logic IS instrucao(3);
    ALIAS subAccMem  : std_logic IS instrucao(4);
    ALIAS sumAccImed : std_logic IS instrucao(5);
    ALIAS subAccImed : std_logic IS instrucao(6);

BEGIN
    WITH opCode SELECT
        instrucao <= "0000001" WHEN opCodeJump,
        "0000010" WHEN opCodeLoad,
        "0000100" WHEN opCodeStore,
        "0001000" WHEN opCodeSumAccMem,
        "0010000" WHEN opCodeSubAccMem,
        "0100000" WHEN opCodeSumAccImed,
        "1000000" WHEN opCodeSubAccImed,
        "0000000" WHEN OTHERS;

    WITH opCode SELECT
        selOperacaoULA <= "000" WHEN opCodeJump,
        "011" WHEN opCodeLoad,
        "010" WHEN opCodeStore,
        "000" WHEN (opCodeSumAccMem OR opCodeSumAccImed),
       -- "001" WHEN (opCodeSubAccMem OR opCodeSubAccImed),
        "000" WHEN OTHERS;

    selMuxProxPC         <= jump;
    selMuxULAImed        <= load OR sumAccMem OR subAccMem;
    HabEscritaAcumulador <= load OR store OR sumAccMem OR sumAccImed OR subAccMem OR subAccImed;
    habLeituraMEM        <= load OR store OR sumAccMem OR sumAccImed OR subAccMem OR subAccImed;
    habEscritaMEM        <= store;

END ARCHITECTURE;

--           muxJump  muxUlaImed  HabEscritaAcumulador  Operacao  HabLeituraMEM  HabEscritaMem      OpCode
-- jump :       1         0                0              000           0              0             0000
-- load :       0         1                1              011           1              0             0001
-- store:       0         0                1              010           0              1             0010
-- sumAccMem:   0         1                1              000           1              0             0011
-- subAccMem:   0         1                1              001           1              0             0101                                                                                           