LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ROM IS
  GENERIC (
    dataWidth       : NATURAL := 32;
    addrWidth       : NATURAL := 32;
    memoryAddrWidth : NATURAL := 6
  ); -- 64 posicoes de 32 bits cada
  PORT (
    endereco : IN STD_LOGIC_VECTOR (addrWidth - 1 DOWNTO 0);
    dado     : OUT STD_LOGIC_VECTOR (dataWidth - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE assincrona OF ROM IS
  TYPE blocoMemoria IS ARRAY(0 TO 2 ** memoryAddrWidth - 1) OF STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);

  FUNCTION initMemory
    RETURN blocoMemoria IS VARIABLE tmp : blocoMemoria := (OTHERS => (OTHERS => '0'));
  BEGIN

    -- Valores iniciais no banco de registradores
    -- $zero (#0) := 0x00
    -- $t0 (#8)  := 0x00
    -- $t1 (#9)  := 0x0A
    -- $t2 (#10) := 0x0B
    -- $t3 (#11) := 0x0C
    -- $t4 (#12) := 0x0D
    -- $t5 (#13) := 0x16

    -- Carga para instruções do grupo A:
    tmp(0) := x"AC09_0008"; --sw $t1 8($zero)     (m(8) := 0x0000000A)  101011 00000 01001 x0008
    tmp(1) := x"8C08_0008"; --lw $t0 8($zero)     ($t0 := 0x0000000A)   100011 00000 01000 x0008
    tmp(2) := x"012A_4022"; --sub $t0 $t1 $t2     ($t0 := 0xFFFFFFFF)   000000 01001 01010 01000 00000 100010
    tmp(3) := x"012A_4024"; --and $t0 $t1 $t2     ($t0 := 0x0000000A)   000000 01001 01010 01000 00000 100100
    tmp(4) := x"012A_4025"; --or $t0 $t1 $t2      ($t0 := 0x0000000B)   000000 01001 01010 01000 00000 100101
    tmp(5) := x"012A_402A"; --slt $t0 $t1 $t2     ($t0 := 0x00000001)   000000 01001 01010 01000 00000 101010
    tmp(6) := x"010A_4020"; --add $t0 $t0 $t2     ($t0 := 0x0000000C)   000000 01000 01010 01000 00000 100000
    -- segunda execução ($t0 := 0x00000017)
    tmp(7) := x"110B_FFFE"; --beq $t0 $t3 0xFFFE  (pc := #6)            000100 01011 01011 xFFFE
    -- segunda execução (pc := #8)
    tmp(8) := x"0800_0001"; --j 0x000001          (pc := #1)            000010 00 x000001

    RETURN tmp;
  END initMemory;

  SIGNAL memROM : blocoMemoria := initMemory;
  --	attribute ram_init_file : string;
  --	attribute ram_init_file of memROM:
  --	signal is "carga-grupo-A.mif";

  -- Utiliza uma quantidade menor de endereços locais:
  SIGNAL enderecoLocal : STD_LOGIC_VECTOR(memoryAddrWidth - 1 DOWNTO 0);

BEGIN
  enderecoLocal <= endereco(memoryAddrWidth + 1 DOWNTO 2);
  dado          <= memROM (to_integer(unsigned(enderecoLocal)));
END ARCHITECTURE;

ARCHITECTURE assincrona_pipeline OF ROM IS
  TYPE blocoMemoria IS ARRAY(0 TO 2 ** memoryAddrWidth - 1) OF STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);

  FUNCTION initMemory
    RETURN blocoMemoria IS VARIABLE tmp : blocoMemoria := (OTHERS => (OTHERS => '0'));
  BEGIN

    -- Valores iniciais no banco de registradores
    -- $zero (#0) := 0x00
    -- $t0 (#8)  := 0x00
    -- $t1 (#9)  := 0x0A
    -- $t2 (#10) := 0x0B
    -- $t3 (#11) := 0x0C
    -- $t4 (#12) := 0x0D
    -- $t5 (#13) := 0x16

    --    -- Carga para instruções do grupo A pipeline:
    -- tmp(0) := x"AC09_0008"; --sw $t1 8($zero)     (m(8) := 0x0000000A)  101011 00000 01001 x0008
    -- tmp(1) := x"8C08_0008"; --lw $t0 8($zero)     ($t0 := 0x0000000A)   100011 00000 01000 x0008
    -- tmp(2) := x"012A_4022"; --sub $t0 $t1 $t2     ($t0 := 0xFFFFFFFF)   000000 01001 01010 01000 00000 100010
    -- tmp(3) := x"012A_4024"; --and $t0 $t1 $t2     ($t0 := 0x0000000A)   000000 01001 01010 01000 00000 100100
    -- tmp(4) := x"012A_4025"; --or $t0 $t1 $t2      ($t0 := 0x0000000B)   000000 01001 01010 01000 00000 100101
    -- tmp(5) := x"012A_402A"; --slt $t0 $t1 $t2     ($t0 := 0x00000001)   000000 01001 01010 01000 00000 101010
    -- tmp(6) := x"010A_4020"; --add $t0 $t0 $t2     HAZARD     ($t0 := 0x0000000A)   000000 01000 01010 01000 00000 100000
    -- tmp(7) := x"110B_FFFE"; --beq $t0 $t3 0xFFFE  HAZARD     (pc := #8)
    -- tmp(8) := x"0800_000C"; --j 0x00000C          HAZARD     (pc := #12)

    -- tmp(12) := x"AC09_0008"; --sw $t1 8($zero)     (m(8) := 0x0000000A)  101011 00000 01001 x0008
    -- tmp(13) := x"8C08_0008"; --lw $t0 8($zero)     ($t0 := 0x0000000A)   100011 00000 01000 x0008
    -- tmp(14) := x"012A_4022"; --sub $t0 $t1 $t2     ($t0 := 0xFFFFFFFF)   000000 01001 01010 01000 00000 100010
    -- tmp(15) := x"012A_4024"; --and $t0 $t1 $t2     ($t0 := 0x0000000A)   000000 01001 01010 01000 00000 100100
    -- tmp(16) := x"012A_4025"; --or $t0 $t1 $t2      ($t0 := 0x0000000B)   000000 01001 01010 01000 00000 100101
    -- tmp(17) := x"012A_402A"; --slt $t0 $t1 $t2     ($t0 := 0x00000001)   000000 01001 01010 01000 00000 101010
    -- -- NOP x3
    -- tmp(21) := x"010A_4020"; --add $t0 $t0 $t2     ($t0 := 0x0000000C)   000000 01000 01010 01000 00000 100000
    -- -- segunda execução ($t0 := 0x00000017)
    -- -- NOP x3
    -- tmp(25) := x"110B_FFFB"; --beq $t0 $t3 0xFFFB  (pc := #21)            000100 01011 01011 xFFFB
    -- -- segunda execução (pc := #28)
    -- -- NOP x2
    -- tmp(28) := x"0800_0000"; --j 0x000000          (pc := #0)            000010 00 x000001

    --    -- Carga para instruções do grupo A e B pipeline:
    tmp(0) := x"AC090008"; --sw $t1 8($zero)     (m(8) := 0x0000000A)
    tmp(1) := x"8C080008"; --lw $t0 8($zero)     ($t0 := 0x0000000A)
    tmp(2) := x"012A4022"; --sub $t0 $t1 $t2     ($t0 := 0xFFFFFFFF)
    tmp(3) := x"012A4024"; --and $t0 $t1 $t2     ($t0 := 0x0000000A)
    tmp(4) := x"012A4025"; --or $t0 $t1 $t2      ($t0 := 0x0000000B)
    tmp(5) := x"3C08FFFF"; --lui $x $t0 0xFFFF   ($t0 := 0xFFFF0000)
    tmp(6) := x"2128000A"; --addi $t1 $t0 0x000A ($t0 := 0x00000014)
    tmp(7) := x"31080013"; --andi $t0 $t0 0x0013 HAZARD  ($t0 := 0x00000002) (leu t0=A do pc=3)
    tmp(8) := x"35880007"; --ori $t4 $t0 0x0007  ($t0 := 0x0000000F)
    tmp(9) := x"2928FFFF"; --slti $t1 $t0 0xFFFF ($t0 := 0x00000000)

    tmp(10) := x"012A402A"; --slt $t0 $t1 $t2     ($t0 := 0x00000001)
    tmp(11) := x"010A4020"; --add $t0 $t0 $t2     HAZARD  ($t0 := 0x0000000D) (B + 2 leu t0 = 2 pc=7)
    tmp(12) := x"110BFFFE"; --beq $t0 $t3 0xFFFE  HAZARD  (pc := #15)
    tmp(13) := x"08000010"; --j 0x000010          (pc := #16)

    tmp(16) := x"AC090008"; --sw $t1 8($zero)     (m(8) := 0x0000000A)
    tmp(17) := x"8C080008"; --lw $t0 8($zero)     ($t0 := 0x0000000A)
    tmp(18) := x"012A4022"; --sub $t0 $t1 $t2     ($t0 := 0xFFFFFFFF)
    tmp(19) := x"012A4024"; --and $t0 $t1 $t2     ($t0 := 0x0000000A)

    tmp(20) := x"012A4025"; --or $t0 $t1 $t2      ($t0 := 0x0000000B)
    tmp(21) := x"3C08FFFF"; --lui $x $t0 0xFFFF   ($t0 := 0xFFFF0000)
    tmp(22) := x"2128000A"; --addi $t1 $t0 0x000A ($t0 := 0x00000014)
    tmp(26) := x"31080013"; --andi $t0 $t0 0x0013 ($t0 := 0x00000010)
    tmp(27) := x"35880007"; --ori $t4 $t0 0x0007  ($t0 := 0x0000000F)
    tmp(28) := x"2928FFFF"; --slti $t1 $t0 0xFFFF ($t0 := 0x00000000)

    tmp(32) := x"010A4020"; --add $t0 $t0 $t2     ($t0 := 0x0000000B)
    --segunda execução:      ($t0 := 0x00000016)
    tmp(36) := x"150DFFFB"; --bne $t0 $t5 0xFFFB  (pc := #32)
    --segunda execução:      (pc := #37)
    tmp(40) := x"012A402A"; --slt $t0 $t1 $t2     ($t0 := 0x00000001)

    tmp(44) := x"010A4020"; --add $t0 $t0 $t2     ($t0 := 0x0000000C)
    --segunda execução:      ($t0 := 0x00000017)
    tmp(48) := x"110BFFFB"; --beq $t0 $t3 0xFFFB  (pc := #44)
    --segunda execução:      (pc := #49)
    tmp(51) := x"0C000039"; --jal 0x000039        (pc := #57) terminar wb para conseguir fazer jr
    tmp(52) := x"00000000"; --nop
    tmp(53) := x"08000000"; --j 0x000000          (pc := #0)
    tmp(54) := x"00000000"; --nop

    tmp(60) := x"03E00008"; --jr $ra              (pc := #53)
    RETURN tmp;
  END initMemory;

  SIGNAL memROM : blocoMemoria := initMemory;
  --	attribute ram_init_file : string;
  --	attribute ram_init_file of memROM:
  --	signal is "carga-grupo-A.mif";

  -- Utiliza uma quantidade menor de endereços locais:
  SIGNAL enderecoLocal : STD_LOGIC_VECTOR(memoryAddrWidth - 1 DOWNTO 0);

BEGIN
  enderecoLocal <= endereco(memoryAddrWidth + 1 DOWNTO 2);
  dado          <= memROM (to_integer(unsigned(enderecoLocal)));
END ARCHITECTURE;