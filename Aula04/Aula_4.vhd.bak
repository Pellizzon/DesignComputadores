library IEEE;
use IEEE.std_logic_1164.all;

entity Aula_4 is
   generic (
          dataWidth: natural := 8;
          addrWidth: natural := 8;
       -- Utilizar o que for maior entre: dataWidth e addrWidth e somar com a quantidade de sinais de controle:
       dataROMWidth: natural := 8 + 7
   );
  port (
    -- Entradas (placa)
    CLOCK_50 : in STD_LOGIC;
--    KEY: in STD_LOGIC_VECTOR(3 DOWNTO 0);
    SW: in STD_LOGIC_VECTOR(7 DOWNTO 0);

    -- Saidas (placa)
    LEDR  : out STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0')
--    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 downto 0)
  );
end entity;


architecture RTL of Aula_4 is

signal ULA_Acumulador, ULAentradaA, ULAentradaB, barramentoLeituraDados, barramentoEscritaDados : std_logic_vector(dataWidth-1 DOWNTO 0);
signal PC_ROM, Incr_MUX_ProxPC, Incr_PC, barramentoEnderecos : std_logic_vector (addrWidth-1 DOWNTO 0);
signal Instrucao : std_logic_vector(dataROMWidth-1 DOWNTO 0);
signal habilitaBlocos : std_logic_vector(3 DOWNTO 0);
signal clk : std_logic;

alias enderecoRAM: std_logic_vector(addrWidth-1 DOWNTO 0) is Instrucao(addrWidth-1 downto 0);
alias imediatoDado: std_logic_vector (dataWidth-1 DOWNTO 0) is Instrucao(dataWidth-1 downto 0);
alias imediatoEndereco: std_logic_vector (addrWidth-1 DOWNTO 0) is Instrucao(addrWidth-1 downto 0);

alias habLeituraBarramento: std_logic is Instrucao(dataROMWidth-1);
alias habEscritaBarramento: std_logic is Instrucao(dataROMWidth-2);
alias habAcumulador: std_logic is Instrucao(dataROMWidth-3);
alias sel_Imediato_RAM: std_logic is Instrucao(dataROMWidth-4);
alias operacaoULA: std_logic_vector is Instrucao(dataROMWidth-5 downto dataROMWidth-6);
alias sel_MUX_Jump: std_logic is Instrucao(dataROMWidth-7);

begin

ULA: entity work.ULA port map (entradaA => ULAentradaA, entradaB => ULAentradaB, saida => ULA_Acumulador, seletor => operacaoULA);

--seteSegA: entity work.conversorHex7Seg
--            port map (dadoHex => , apaga => , negativo => , overFlow => , saida7seg => );

RAM: entity work.memoriaRAM
            port map (clk => clk, addr => barramentoEnderecos, we => habEscritaBarramento,
        re => habLeituraBarramento, habilita => habilitaBlocos(1),dado_in => barramentoEscritaDados, dado_out => barramentoLeituraDados);

MUX_RAM_Imediato: entity work.muxGenerico2x1
            port map (entradaA_MUX => barramentoLeituraDados, entradaB_MUX => imediatoDado, seletor_MUX => sel_Imediato_RAM, saida_MUX => ULAentradaA);

MUX_proxPC: entity work.muxGenerico2x1
            port map (entradaA_MUX => Incr_MUX_ProxPC, entradaB_MUX => imediatoEndereco, seletor_MUX => sel_MUX_Jump, saida_MUX => Incr_PC);

incremento: entity work.somaConstante
            port map (entrada => PC_ROM, saida => Incr_MUX_ProxPC);

ROM: entity work.memoriaROM generic map (dataWidth => dataROMWidth)
            port map (Endereco => PC_ROM, Dado => Instrucao);

PC: entity work.registradorGenerico
            port map (CLK => clk, DIN => Incr_PC, DOUT => PC_ROM, ENABLE => '1', RST => '0');

Acumulador: entity work.registradorGenerico
            port map (CLK => clk, DIN => ULA_Acumulador, DOUT => ULAentradaB, ENABLE => habAcumulador, RST => '0');

decodificador: entity work.decodificador2x4
        port map (seletor => barramentoEnderecos(addrWidth-1 downto addrWidth-2), habilita => habilitaBlocos);

saidaLEDs: entity work.interfaceLEDs
        port map (clk => clk, entrada => barramentoEscritaDados(dataWidth-1 downto 0), saida => LEDR(dataWidth-1 downto 0), habilita => habilitaBlocos(3));

entradaChaves: entity work.interfaceCHAVES
        port map (entrada => SW(dataWidth-1 downto 0), saida => barramentoLeituraDados(dataWidth-1 downto 0), habilita => habilitaBlocos(2));

barramentoEscritaDados <= ULAentradaB;
barramentoEnderecos <= imediatoEndereco;
clk <= CLOCK_50;

end architecture;
