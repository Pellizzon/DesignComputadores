LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY fluxo_dados IS
    GENERIC (
        larguraROM : NATURAL := 8 -- deve ser menor ou igual a 32
    );
    PORT (
        clk : IN STD_LOGIC;
        pontosDeControle : IN STD_LOGIC_VECTOR(CONTROLWORD_WIDTH - 1 DOWNTO 0);
        opcode : OUT STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);
        -- sinais para depuração
        PC_prox_out, dadoEscritaC_out, enderecoEscritaRAM_out, dadoEscritoRAM_out : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        enderecoC_out : OUT STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
        escreveC_out, escreveRAM_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE estrutural OF fluxo_dados IS

    -- Sinais auxiliares para a lógica do PC
    SIGNAL PC_prox, PC_4_concat_imed : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL saida_shift_jump : STD_LOGIC_VECTOR(27 DOWNTO 0);
    SIGNAL sel_mux_prox_pc : STD_LOGIC_VECTOR(1 DOWNTO 0);

    --                       IF                       --

    -- Sinais de saida
    SIGNAL instrucao_IF, PC_mais_4_IF : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    -- Sinais do registrador intermediário 
    SIGNAL IFID_saida : STD_LOGIC_VECTOR(2 * DATA_WIDTH - 1 DOWNTO 0);


    --                       ID                       --

    -- Codigos da palavra de controle:
    ALIAS sel_mux_jump : STD_LOGIC IS pontosDeControle(9);
    ALIAS sel_mux_rd_rt : STD_LOGIC IS pontosDeControle(10);

    -- Parsing da instrucao
    ALIAS RS_addr_ID : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao_IF(25 DOWNTO 21);
    ALIAS RT_addr_ID : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao_IF(20 DOWNTO 16);
    ALIAS RD_addr_ID : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS instrucao_IF(15 DOWNTO 11);
    ALIAS funct_ID : STD_LOGIC_VECTOR(FUNCT_WIDTH - 1 DOWNTO 0) IS instrucao_IF(5 DOWNTO 0);

    -- Sinais de saida
    SIGNAL dadoLidoA_ID, dadoLidoB_ID, imediato_ID : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL enderecoC_ID: STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);

    -- Sinais do registrador intermediário 
    SIGNAL IDEX_saida : STD_LOGIC_VECTOR(4 * DATA_WIDTH + REGBANK_ADDR_WIDTH + FUNCT_WIDTH + 10 DOWNTO 0);

    
    --                       EX                       --
    
    ALIAS pontosDeControle_EX : STD_LOGIC_VECTOR(8 DOWNTO 0) IS pontosDeControle(8 downto 0);

    -- Codigos da palavra de controle:
    ALIAS ULAop : STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0) IS pontosDeControle_EX(8 DOWNTO 6);
    ALIAS sel_beq : STD_LOGIC IS pontosDeControle_EX(5);
    ALIAS sel_mux_banco_ula : STD_LOGIC IS pontosDeControle_EX(4);

    -- Controle da ULA
    SIGNAL ULActr : STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0);

    -- Sinais de saida
    SIGNAL PC_beq_EX, saida_ula_EX : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL sel_mux_beq : STD_LOGIC;

    -- Sinais do registrador intermediário 
    SIGNAL EXMEM_saida : STD_LOGIC_VECTOR(2 * DATA_WIDTH + REGBANK_ADDR_WIDTH + 3 DOWNTO 0);


    --                       MEM                       --

    ALIAS pontosDeControle_MEM : STD_LOGIC_VECTOR(3 DOWNTO 0) IS pontosDeControle(3 downto 0);

    -- Codigos da palavra de controle:
    ALIAS escreve_RAM : STD_LOGIC IS pontosDeControle_MEM(1);
    ALIAS leitura_RAM : STD_LOGIC IS pontosDeControle_MEM(2);
    ALIAS sel_mux_ula_mem : STD_LOGIC IS pontosDeControle_MEM(3);

    -- Sinais de saida
    SIGNAL dadoEscritaC_MEM : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    -- Sinais do registrador intermediário 
    SIGNAL MEMWB_saida : STD_LOGIC_VECTOR(DATA_WIDTH + REGBANK_ADDR_WIDTH DOWNTO 0);


    --                       WB                       --

    -- Codigos da palavra de controle:
    ALIAS escreve_RC : STD_LOGIC IS pontosDeControle(0);

BEGIN

    -- Sinais para depuração
    PC_prox_out <= PC_prox;
    enderecoC_out <= enderecoC_ID;
    dadoEscritaC_out <= dadoEscritaC_MEM;
    escreveC_out <= escreve_RC;
    enderecoEscritaRAM_out <= saida_ula_EX;
    dadoEscritoRAM_out <= dadoLidoB_ID;
    escreveRAM_out <= escreve_RAM;

    ---------------------------------------------------------------

	opcode <= instrucao_IF(31 DOWNTO 26);

    -- Lógica do PC

    -- assumimos que todos os casos de BEQ são seguidos por um NOP
    sel_mux_prox_pc <= sel_mux_beq & sel_mux_jump;

    mux_prox_pc : ENTITY work.muxGenerico3
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => PC_mais_4_IF,
            entradaB => PC_4_concat_imed,
            entradaC => PC_beq_EX,
            seletor => sel_mux_prox_pc,
            saida => PC_prox
        );

    -- Estágios

    PC_4_concat_imed <= PC_mais_4_IF(31 DOWNTO 28) & saida_shift_jump;

    shift_jump : ENTITY work.shift2
        GENERIC MAP(
            larguraDado => 26
        )
        PORT MAP(
            shift_IN => instrucao_IF(25 DOWNTO 0),
            shift_OUT => saida_shift_jump
        );

    IFE : ENTITY work.etapa_busca
        GENERIC MAP(
            larguraROM => larguraROM
        )
        PORT MAP
        (
            clk => clk,
            PC_prox => PC_prox,
            -- saidas
            instrucao => instrucao_IF,
            PC_mais_4 => PC_mais_4_IF
        );

    ID : ENTITY work.etapa_decodificacao
        PORT MAP
        (
            clk => clk,
            instrucao => instrucao_IF,
            -- saidas
            saidaA => dadoLidoA_ID,
            saidaB => dadoLidoB_ID,
            imediato_ext => imediato_ID,
            -- sinais etapa de escrita
            enderecoC => enderecoC_ID,
            dadoEscritaC => dadoEscritaC_MEM,
            escreveC => escreve_RC
        );

    mux_Rd_Rt : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => REGBANK_ADDR_WIDTH
        )
        PORT MAP(
            entradaA => RT_addr_ID,
            entradaB => RD_addr_ID,
            seletor => sel_mux_rd_rt,
            saida => enderecoC_ID
        );

    UCULA : ENTITY work.UC_ULA
        PORT MAP
        (
            funct => funct_ID,
            ALUop => ULAop,
            ALUctr => ULActr
        );

    EX : ENTITY work.etapa_execucao
        PORT MAP
        (
            PC_mais_4 => PC_mais_4_IF,
            imediato => imediato_ID,
            dadoLidoA => dadoLidoA_ID,
            dadoLidoB => dadoLidoB_ID,
            -- controle
            ULActr => ULActr,
            sel_beq => sel_beq,
            sel_mux_banco_ula => sel_mux_banco_ula,
            -- saidas
            PC_beq => PC_beq_EX,
            saida_ula => saida_ula_EX,
            sel_mux_beq => sel_mux_beq
        );

    MEM : ENTITY work.etapa_memoria
        PORT MAP
        (
            clk => clk,
            saida_ula => saida_ula_EX,
            dadoLidoB => dadoLidoB_ID,
            -- controle
            sel_mux_ula_mem => sel_mux_ula_mem,
            leitura_RAM => leitura_RAM,
            escreve_RAM => escreve_RAM,
            -- saidas
            dadoEscrita => dadoEscritaC_MEM
        );

END ARCHITECTURE;