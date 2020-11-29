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
        jr               : OUT STD_LOGIC;
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
    ALIAS sel_jr       : STD_LOGIC IS pontosDeControle(15);
    ALIAS jal          : STD_LOGIC IS pontosDeControle(14);
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
    SIGNAL IDEX_saida : STD_LOGIC_VECTOR(4 * DATA_WIDTH + 2 * REGBANK_ADDR_WIDTH + 13 - 1 DOWNTO 0);
    --       150: jal
    --       149: sel_bne 
    -- 148 ~ 117: IFID_saida(63 DOWNTO 32) = PC+4 
    -- 116 ~  85: dadoLidoA_ID 
    --  84 ~  53: dadoLidoB_ID
    --  52 ~  21: imediato_ID
    --  20 ~  16: RT_addr_ID &
    --  15 ~  11: RD_addr_ID &
    --  10 ~   0: pontosDeControle(10 DOWNTO 0),
    ALIAS sel_jal           : STD_LOGIC IS IDEX_saida(150);
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

    SIGNAL saida_mux_PC_prox : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

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

    SIGNAL saida_mux_rd_rt : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0);
    SIGNAL PCmais8         : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);

    -- Sinais do registrador intermediário 
    SIGNAL EXMEM_saida : STD_LOGIC_VECTOR(3 * DATA_WIDTH + REGBANK_ADDR_WIDTH + 5 - 1 DOWNTO 0);
    --105  ~ 74: PCmais8
    --       73: sel_jal
    --  72 ~ 42: saida_ula_EX 
    --  41 ~ 10: ID_EX_DadoLidoB 
    --  8 ~   4: enderecoC_ID 
    --        3: ID_EX_ctrlPointsMEM_WriteMem 
    --        2: ID_EX_ctrlPointsMEM_ReadMem 
    --        1: ID_EX_ctrlPointsWB_selMuxUlaMEM 
    --        0: ID_EX_ctrlPointsWB_RegWrite
    ALIAS EX_MEM_PCmais8   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS EXMEM_saida(105 DOWNTO 74);
    ALIAS EX_MEM_sel_jal   : STD_LOGIC IS EXMEM_saida(73);
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
    SIGNAL MEMWB_saida : STD_LOGIC_VECTOR(104 - 1 DOWNTO 0);
    --103 ~ 72: EX_MEM_PCmais8
    --      71: EX_MEM_sel_jal
    -- 70 ~ 39: EX_MEM_saidaULA 
    -- 38 ~  7: saida_RAM 
    --  6 ~  2: EX_MEM_enderecoC 
    --       1: EX_MEM_ctrlPointsWB_ULA_MEM 
    --       0: EX_MEM_ctrlPointsWB_RegWrite
    ALIAS MEM_WB_PCmais8    : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(103 DOWNTO 72);
    ALIAS MEM_WB_sel_jal    : STD_LOGIC IS MEMWB_saida(71);
    ALIAS MEM_WB_saidaULA   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(70 DOWNTO 39);
    ALIAS MEM_WB_saidaRAM   : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(38 DOWNTO 7);
    ALIAS MEM_WB_enderecoC  : STD_LOGIC_VECTOR(REGBANK_ADDR_WIDTH - 1 DOWNTO 0) IS MEMWB_saida(6 DOWNTO 2);
    ALIAS MEM_WB_muxULA_Mem : STD_LOGIC IS MEMWB_saida(1);
    ALIAS MEM_WB_RegWrite   : STD_LOGIC IS MEMWB_saida(0);

    -- WB --
    SIGNAL dadoEscrita_ulamem : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
    SIGNAL dadoEscrita        : STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
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

    opcode <= IFID_saida(31 DOWNTO 26);

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
            saida    => saida_mux_PC_prox
        );

    mux_proxpc_jr : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => saida_mux_PC_prox,
            entradaB => ID_EX_DadoLidoA,
            seletor  => sel_jr,
            saida    => PC_prox
        );

    shift_jump : ENTITY work.shift2
        GENERIC MAP(
            larguraDado => 26
        )
        PORT MAP(
            shift_IN  => IFID_saida (25 DOWNTO 0),
            shift_OUT => saida_shift_jump -- imed & "00"
        );

    PC_4_concat_imed <= IFID_saida(63 DOWNTO 60) & saida_shift_jump; -- PC+4[31:28] & imed & "00"

    IFE : ENTITY work.etapa_busca
        GENERIC MAP(
            larguraROM => larguraROM
        )
        PORT MAP
        (
            clk => clk,
            -- entrada
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
            instrucao   => IFID_saida(31 DOWNTO 0), -- vem do registrador IF_ID
            lui         => lui,                     -- vem da propria UC
            selORI_ANDI => selORI_ANDI,             -- vem da propria UC
            -- saidas
            saidaA       => dadoLidoA_ID, -- vai para o proximo registrador, ID_EX
            saidaB       => dadoLidoB_ID, -- vai para o proximo registrador, ID_EX
            imed_ext_lui => imediato_ID,  -- vai para o proximo registrador, ID_EX
            -- sinais etapa de escrita
            enderecoC    => MEM_WB_enderecoC, -- vem da etapa write back
            dadoEscritaC => dadoEscrita,      -- vem da etapa write back
            escreveC     => MEM_WB_RegWrite   -- ponto de controle que "passa para frente", vem da etapa write back
        );

    ID_EX : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 4 * DATA_WIDTH + 2 * REGBANK_ADDR_WIDTH + 13
            ) PORT MAP(
            clk     => clk,
            enable  => '1',
            reset   => '1',
            data_in => jal &
            bne &
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
            entradaA => ID_EX_RT_ADDR,   -- endereco RT, vem do registrador ID_EX
            entradaB => ID_EX_RD_ADDR,   -- endereco RD, vem do registrador ID_EX
            seletor  => ID_EX_RT_RT_SEL, -- ponto de controle, vem da etapa anterior
            saida    => saida_mux_rd_rt
        );

    mux_RdRt_jal : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => REGBANK_ADDR_WIDTH
        )
        PORT MAP(
            entradaA => saida_mux_rd_rt, -- saida do mux rd rt
            entradaB => b"11111",        -- registrador 31, para jal
            seletor  => sel_jal,         -- ponto de controle, vem da etapa anterior
            saida    => enderecoC_ID     -- endereco onde sera escrito no banco de registrador. 
        );                           -- (endereco passado pra "frente" ate write back)

    UCULA : ENTITY work.UC_ULA
        PORT MAP
        (
            -- entradas
            funct => ID_EX_FUNCT, -- funct, vem da etapa anterior
            ALUop => ULAop,       -- determinado pelo ponto de controle da etapa anterior
            -- saidas
            ALUctr => ULActr, -- define o que vai ser executado na ULA
            jr     => jr      -- sinal que informa sobre jr (volta pra UC para fazer jr). Uma das saidas do FD
        );

    EX : ENTITY work.etapa_execucao
        PORT MAP
        (
            -- entradas
            PC_mais_4 => ID_EX_PCmais4,     -- vem da etapa anterior
            imediato  => ID_EX_ImediatoExt, -- vem da etapa anterior
            dadoLidoA => ID_EX_DadoLidoA,   -- vem da etapa anterior
            dadoLidoB => ID_EX_DadoLidoB,   -- vem da etapa anterior
            -- controle
            ULActr            => ULActr,            -- vem da UC da ULA
            sel_beq           => sel_beq,           -- ponto de controle "carregado" de etapas anteriores
            sel_bne           => sel_bne,           -- ponto de controle "carregado" de etapas anteriores
            sel_mux_banco_ula => sel_mux_banco_ula, -- ponto de controle "carregado" de etapas anteriores
            -- saidas
            PC_beq      => PC_beq_EX,    -- pc do beq/bne, usado no mux_prox_pc
            saida_ula   => saida_ula_EX, -- saida da ula (valor ou endereco da RAM), passa para proxima etapa
            sel_mux_beq => sel_mux_beq   -- parte do seletor do mux_prox_pc
        );

    -- PC+8 usado para instrução JAL
    Somador : ENTITY work.soma4
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entrada => ID_EX_PCmais4, -- vem da etapa anterior
            saida   => PCmais8        -- passa para proximas etapas, escrever PC+8 no reg 31 (instrucao JAL)
        );

    EX_MEM : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 3 * DATA_WIDTH + REGBANK_ADDR_WIDTH + 5
            ) PORT MAP(
            clk     => clk,
            enable  => '1',
            reset   => '1',
            data_in => PCmais8 &
            sel_jal &
            saida_ula_EX &
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
            clk => clk,
            -- entradas
            saida_ula => EX_MEM_saidaULA,  -- dado da etapa anterior
            dadoLidoB => EX_MEM_dadoLidoB, -- dado "carregado" de etapas anteriores
            -- controle
            leitura_RAM => leitura_RAM, -- ponto de controle, vem de etapas anteriores
            escreve_RAM => escreve_RAM, -- ponto de controle, vem de etapas anteriores
            -- saidas
            dadoEscrita => saida_RAM -- o que foi lido da RAM
        );

    MEM_WB : ENTITY work.registrador
        GENERIC MAP(
            NUM_BITS => 104
            ) PORT MAP(
            clk     => clk,
            enable  => '1',
            reset   => '1',
            data_in => EX_MEM_PCmais8 &
            EX_MEM_sel_jal &
            EX_MEM_saidaULA &
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
            entradaA => MEM_WB_saidaULA,   -- vem da etapa anterior, "carregado" desde a etapa de execucao
            entradaB => MEM_WB_saidaRAM,   -- vem da etapa anterior, leitura da RAM
            seletor  => MEM_WB_muxULA_Mem, -- ponto de controle, "carregado"
            saida    => dadoEscrita_ulamem -- dado a ser escrito no banco de registradores
        );

    mux_UlaMem_JAL : ENTITY work.muxGenerico2
        GENERIC MAP(
            larguraDados => DATA_WIDTH
        )
        PORT MAP(
            entradaA => dadoEscrita_ulamem, -- dado do mux Ula mem (valor da ula ou RAM)
            entradaB => MEM_WB_PCmais8,     -- PC+8 para fazer jal
            seletor  => MEM_WB_sel_jal,     -- ponto de controle, "carregado"
            saida    => dadoEscrita         -- o que sera escrito no banco de registradores
        );

END ARCHITECTURE;