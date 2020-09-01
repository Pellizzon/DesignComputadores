
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity atividade1 is
  generic   (
    larguraDados  : natural :=  8
  );

  port   (
	 SW      : in  std_logic_vector(9 downto 0);
	 KEY     : in  std_logic_vector(3 downto 0);
	 LEDR    : out std_logic_vector(9 downto 0);
	 
    CLOCK_50     : in  std_logic;
	 FPGA_RESET_N     : in  std_logic
  );
end entity;


architecture arch_name of atividade1 is

component edgeDetector
     port ( clk     : in  STD_LOGIC;
              entrada : in  STD_LOGIC;
              saida   : out STD_LOGIC);
end component;

component registradorGenerico
    port (DIN : in std_logic_vector(larguraDados-1 downto 0);
       DOUT : out std_logic_vector(larguraDados-1 downto 0);
       ENABLE : in std_logic;
       CLK,RST : in std_logic
        );
end component;

component muxGenerico2x1
  port (
    entradaA_MUX, entradaB_MUX : in std_logic_vector((larguraDados-1) downto 0);
    seletor_MUX : in std_logic;
    saida_MUX : out std_logic_vector((larguraDados-1) downto 0)
  );
end component;

component ULAsoma
  port (
    entradaA, entradaB: in STD_LOGIC_VECTOR((larguraDados-1) downto 0);
    operacao: in STD_LOGIC;
    saida: out STD_LOGIC_VECTOR((larguraDados-1) downto 0)
  );
end component;

signal resetB, resetA, regclock : STD_LOGIC;
signal saidaMux, saidaULA : STD_LOGIC_VECTOR(7 downto 0);
signal saidaRegA, saidaRegB: STD_LOGIC_VECTOR(7 downto 0);

begin

detectorCLOCK: edgeDetector port map (
clk => CLOCK_50, entrada => FPGA_RESET_N, saida => regclock
);
detectorRSTA: edgeDetector port map (
clk => CLOCK_50, entrada => (not KEY(1)), saida => resetA
);
detectorRSTB: edgeDetector port map (
clk => CLOCK_50, entrada => (not KEY(0)), saida => resetB
);

muxIN_A: muxGenerico2x1 port map (
entradaA_MUX=>SW(7 downto 0), entradaB_MUX=>saidaULA, seletor_MUX=> SW(8), saida_MUX=>saidaMux
);

regA: registradorGenerico port map (
	DIN  => saidaMux,
	DOUT => saidaRegA,
   ENABLE => (not KEY(3)),
   CLK  => regclock,
	RST  => resetA
);

regB: registradorGenerico port map (
	DIN  => SW(7 downto 0),
	DOUT => saidaRegB,
   ENABLE => (not KEY(2)),
   CLK  => regclock,
	RST  => resetB
);
 
ULA: ULAsoma port map (
    entradaA => saidaRegA,
	 entradaB => saidaRegB,
    operacao => SW(9),
    saida    => LEDR(7 downto 0)
);

LEDR(8) <= SW(8);
LEDR(9) <= SW(9);


end architecture;
