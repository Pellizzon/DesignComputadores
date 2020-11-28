LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.constantesMIPS.ALL;

ENTITY fluxo_dados IS
    GENERIC (
        larguraROM : NATURAL := 8 -- deve ser menor ou igual a 32
    );
    PORT (
        clk              : IN STD_LOGIC;
        pontosDeControle : IN STD_LOGIC_VECTOR(CONTROLWORD_WIDTH - 1 DOWNTO 0);
        opcode           : OUT STD_LOGIC_VECTOR(OPCODE_WIDTH - 1 DOWNTO 0);
        -- sinais para depuração
        PC_prox_out, dadoEscritaC_out, enderecoEscritaRAM_out, dadoEscritoRAM_out, pc_ex : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        enderecoC_out                                                                    : OUT STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
        escreveC_out, escreveRAM_out                                                     : OUT STD_LOGIC;
        ULA_B_out, ULA_A_out                                                             : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE estrutural OF fluxo_dados IS

    -- Sinais auxiliares para a lógica do PC
    SIGNAL PC_prox, PC_4_concat_imed : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL saida_shift_jump          : STD_LOGIC_VECTOR(27 DOWNTO 0);
    SIGNAL sel_mux_prox_pc           : STD_LOGIC_VECTOR(1 DOWNTO 0);

    -- IF --

    -- Sinais de saida
    SIGNAL instrucao_IF, PC_mais_4_IF : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    -- Sinais do registrador intermediário 
    SIGNAL IFID_saida : STD_LOGIC_VECTOR(2 * DATA_WIDTH - 1 DOWNTO 0);
    -- 63 ~ 32 : PC_mais_4_IF
    -- 31 ~  0 : instrucao_IF

    -- ID --

    -- Codigos da palavra de controle:
    ALIAS bne          : STD_LOGIC IS pontosDeControle(13);
    ALIAS selORI_ANDI  : STD_LOGIC IS pontosDeControle(12);
    ALIAS lui          : STD_LOGIC IS pontosDeControle(11);
    ALIAS sel_mux_jump : STD_LOGIC IS pontosDeControle(9);

    -- Parsing da instrucao
    ALIAS RS_addr_ID : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS IFID_saida(25 DOWNTO 21);
    ALIAS RT_addr_ID : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS IFID_saida(20 DOWNTO 16);
    ALIAS RD_addr_ID : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS IFID_saida(15 DOWNTO 11);

    -- Sinais de saida
    SIGNAL dadoLidoA_ID, dadoLidoB_ID, imediato_ID : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL enderecoC_ID                            : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);

    -- Sinais do registrador intermediário 
    SIGNAL IDEX_saida : STD_LOGIC_VECTOR(4 * DATA_WIDTH + 2 * REGBANK_ADDR_WIDTH + 12 - 1 DOWNTO 0);
    --       149: sel_bne 
    -- 148 ~ 117: IFID_saida(63 DOWNTO 32) = PC+4 
    -- 116 ~  85: dadoLidoA_ID 
    --  84 ~  53: dadoLidoB_ID
    --  52 ~  21: imediato_ID
    --  20 ~  16: RT_addr_ID &
    --  15 ~  11: RD_addr_ID &
    --  10 ~   0: pontosDeControle(10 DOWNTO 0),
    ALIAS sel_bne           : STD_LOGIC IS IDEX_saida(149);
    ALIAS ID_EX_PCmais4     : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS IDEX_saida(148 DOWNTO 117);
    ALIAS ID_EX_DadoLidoA   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS IDEX_saida(116 DOWNTO 85);
    ALIAS ID_EX_DadoLidoB   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS IDEX_saida(84 DOWNTO 53);
    ALIAS ID_EX_ImediatoExt : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS IDEX_saida(52 DOWNTO 21);
    ALIAS ID_EX_FUNCT       : STD_LOGIC_VECTOR(FUNCT_WIDTH - 1 DOWNTO 0) IS IDEX_saida(26 DOWNTO 21);
    ALIAS ID_EX_RT_ADDR     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS IDEX_saida(20 DOWNTO 16);
    ALIAS ID_EX_RD_ADDR     : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS IDEX_saida(15 DOWNTO 11);
    ALIAS ID_EX_RT_RT_SEL   : STD_LOGIC IS IDEX_saida(10);

    ALIAS ID_EX_ctrlPointsWB_RegWrite     : STD_LOGIC IS IDEX_saida(0);
    ALIAS ID_EX_ctrlPointsWB_selMuxUlaMEM : STD_LOGIC IS IDEX_saida(3);
    ALIAS ID_EX_ctrlPointsMEM_ReadMem     : STD_LOGIC IS IDEX_saida(2);
    ALIAS ID_EX_ctrlPointsMEM_WriteMem    : STD_LOGIC IS IDEX_saida(1);

    -- EX --

    ALIAS ID_EX_pontosDeControle : STD_LOGIC_VECTOR(8 DOWNTO 0) IS IDEX_saida(8 DOWNTO 0);

    -- Codigos da palavra de controle:
    ALIAS ULAop             : STD_LOGIC_VECTOR(ALU_OP_WIDTH - 1 DOWNTO 0) IS ID_EX_pontosDeControle(8 DOWNTO 6);
    ALIAS sel_beq           : STD_LOGIC IS ID_EX_pontosDeControle(5);
    ALIAS sel_mux_banco_ula : STD_LOGIC IS ID_EX_pontosDeControle(4);

    -- Controle da ULA
    SIGNAL ULActr : STD_LOGIC_VECTOR(CTRL_ALU_WIDTH - 1 DOWNTO 0);

    -- Sinais de saida
    SIGNAL PC_beq_EX, saida_ula_EX : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL sel_mux_beq             : STD_LOGIC;

    -- Sinais do registrador intermediário 
    SIGNAL EXMEM_saida : STD_LOGIC_VECTOR(2 * DATA_WIDTH + REGBANK_ADDR_WIDTH + 4 - 1 DOWNTO 0);
    --  72 ~ 42: saida_ula_EX 
    --  41 ~ 10: ID_EX_DadoLidoB 
    --  8 ~   4: enderecoC_ID 
    --        3: ID_EX_ctrlPointsMEM_WriteMem 
    --        2: ID_EX_ctrlPointsMEM_ReadMem 
    --        1: ID_EX_ctrlPointsWB_selMuxUlaMEM 
    --        0: ID_EX_ctrlPointsWB_RegWrite
    ALIAS EX_MEM_saidaULA  : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS EXMEM_saida(72 DOWNTO 41);
    ALIAS EX_MEM_dadoLidoB : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS EXMEM_saida(40 DOWNTO 9);
    ALIAS EX_MEM_enderecoC : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS EXMEM_saida(8 DOWNTO 4);

    ALIAS EX_MEM_ctrlPointsWB_RegWrite : STD_LOGIC IS EXMEM_saida(0);
    ALIAS EX_MEM_ctrlPointsWB_ULA_MEM  : STD_LOGIC IS EXMEM_saida(1);
    -- MEM --

    -- Codigos da palavra de controle:
    ALIAS escreve_RAM : STD_LOGIC IS EXMEM_saida(3);
    ALIAS leitura_RAM : STD_LOGIC IS EXMEM_saida(2);
    -- Sinais de saida
    SIGNAL saida_RAM : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    -- Sinais do registrador intermediário 
    SIGNAL MEMWB_saida : STD_LOGIC_VECTOR(71 - 1 DOWNTO 0);
    -- 70 ~ 39: EX_MEM_saidaULA 
    -- 38 ~  7: saida_RAM 
    --  6 ~  2: EX_MEM_enderecoC 
    --       1: EX_MEM_ctrlPointsWB_ULA_MEM 
    --       0: EX_MEM_ctrlPointsWB_RegWrite
    ALIAS MEM_WB_saidaULA   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(70 DOWNTO 39);
    ALIAS MEM_WB_saidaRAM   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(38 DOWNTO 7);
    ALIAS MEM_WB_enderecoC  : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(6 DOWNTO 2);
    ALIAS MEM_WB_muxULA_Mem : STD_LOGIC IS MEMWB_saida(1);
    ALIAS MEM_WB_RegWrite   : STD_LOGIC IS MEMWB_saida(0);

    -- WB --
    SIGNAL dadoEscrita : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
BEGIN

    -- Sinais para depuração
    PC_prox_out            <= PC_prox;
    enderecoC_out          <= MEM_WB_enderecoC;
    dadoEscritaC_out       <= dadoEscrita;
    escreveC_out           <= MEM_WB_RegWrite;
    enderecoEscritaRAM_out <= saida_ula_EX;
    dadoEscritoRAM_out     <= EX_MEM_dadoLidoB;
    escreveRAM_out         <= escreve_RAM;
    pc_ex                  <= ID_EX_PCmais4;

    ULA_A_out <= ID_EX_DadoLidoA;
    ULA_B_out <= ID_EX_DadoLidoB;

    ---------------------------------------------------------------

    opcode <= IFID_saida (31 DOWNTO 26);

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
            seletor  => sel_mux_prox_pc,
            saida    => PC_prox
        );

    -- Estágios

    PC_4_concat_imed <= IFID_saida(63 DOWNTO 60) & saida_shift_jump;

    shift_jump : ENTITY work.shift2
        GENERIC MAP(
            larguraDado => 26
        )
        PORT MAP(
            shift_IN  => IFID_saida (25 DOWNTO 0),
            shift_OUT => saida_shift_jump
        );

    IFE : ENTITY work.etapa_busca
        GENERIC MAP(
            larguraROM => larguraROM
        )
        PORT MAP
        (
            clk     => clk,
            PC_prox => PC_prox,
            -- saidas
            instrucao => instrucao_IF,
            PC_mais_4 => PC_mais_4_IF
        );

    IF_ID : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 2 * DATA_WIDTH
            ) PORT MAP(
            clk      => clk,
            enable   => '1',
            reset    => '1',
            data_in  => PC_mais_4_IF & instrucao_IF,
            data_out => IFID_saida
        );

    ID : ENTITY work.etapa_decodificacao
        PORT MAP
        (
            clk         => clk,
            instrucao   => IFID_saida(31 DOWNTO 0),
            lui         => lui,
            selORI_ANDI => selORI_ANDI,
            -- saidas
            saidaA       => dadoLidoA_ID,
            saidaB       => dadoLidoB_ID,
            imed_ext_lui => imediato_ID,
            -- sinais etapa de escrita
            enderecoC    => MEM_WB_enderecoC, -- tem q vir da etapa write back
            dadoEscritaC => dadoEscrita,      -- vem da etapa write back
            escreveC     => MEM_WB_RegWrite
        );

    ID_EX : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 4 * DATA_WIDTH + 2 * REGBANK_ADDR_WIDTH + 12
            ) PORT MAP(
            clk     => clk,
            enable  => '1',
            reset   => '1',
            data_in => bne &
            IFID_saida(63 DOWNTO 32) &
            dadoLidoA_ID &
            dadoLidoB_ID &
            imediato_ID &
            RT_addr_ID &
            RD_addr_ID &
            pontosDeControle(10 DOWNTO 0),
            data_out => IDEX_saida
        );

    mux_Rd_Rt : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => REGBANK_ADDR_WIDTH
        )
        PORT MAP(
            entradaA => ID_EX_RT_ADDR,
            entradaB => ID_EX_RD_ADDR,
            seletor  => ID_EX_RT_RT_SEL,
            saida    => enderecoC_ID
        );

    UCULA : ENTITY work.UC_ULA
        PORT MAP
        (
            funct  => ID_EX_FUNCT,
            ALUop  => ULAop,
            ALUctr => ULActr
        );

    EX : ENTITY work.etapa_execucao
        PORT MAP
        (
            PC_mais_4 => ID_EX_PCmais4,
            imediato  => ID_EX_ImediatoExt,
            dadoLidoA => ID_EX_DadoLidoA,
            dadoLidoB => ID_EX_DadoLidoB,
            -- controle
            ULActr            => ULActr,
            sel_beq           => sel_beq,
            sel_bne           => sel_bne,
            sel_mux_banco_ula => sel_mux_banco_ula,
            -- saidas
            PC_beq      => PC_beq_EX,
            saida_ula   => saida_ula_EX,
            sel_mux_beq => sel_mux_beq
        );

    EX_MEM : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 2 * DATA_WIDTH + REGBANK_ADDR_WIDTH + 4
            ) PORT MAP(
            clk     => clk,
            enable  => '1',
            reset   => '1',
            data_in => saida_ula_EX &
            ID_EX_DadoLidoB &
            enderecoC_ID &
            ID_EX_ctrlPointsMEM_WriteMem &
            ID_EX_ctrlPointsMEM_ReadMem &
            ID_EX_ctrlPointsWB_selMuxUlaMEM &
            ID_EX_ctrlPointsWB_RegWrite,
            data_out => EXMEM_saida
        );

    MEM : ENTITY work.etapa_memoria
        PORT MAP
        (
            clk       => clk,
            saida_ula => EX_MEM_saidaULA,
            dadoLidoB => EX_MEM_dadoLidoB,
            -- controle
            leitura_RAM => leitura_RAM,
            escreve_RAM => escreve_RAM,
            -- saidas
            dadoEscrita => saida_RAM
        );

    MEM_WB : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 71
            ) PORT MAP(
            clk     => clk,
            enable  => '1',
            reset   => '1',
            data_in => EX_MEM_saidaULA &
            saida_RAM &
            EX_MEM_enderecoC &
            EX_MEM_ctrlPointsWB_ULA_MEM &
            EX_MEM_ctrlPointsWB_RegWrite,
            data_out => MEMWB_saida
        );

    mux_Ula_Memoria : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => MEM_WB_saidaULA,
            entradaB => MEM_WB_saidaRAM,
            seletor  => MEM_WB_muxULA_Mem,
            saida    => dadoEscrita
        );

END ARCHITECTURE;