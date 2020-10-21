-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"

-- DATE "09/09/2020 09:37:28"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Aula_4 IS
    PORT (
	CLOCK_50 : IN std_logic;
	SW : IN std_logic_vector(7 DOWNTO 0);
	LEDR : OUT std_logic_vector(7 DOWNTO 0)
	);
END Aula_4;

-- Design Ports Information
-- LEDR[0]	=>  Location: PIN_AA2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[1]	=>  Location: PIN_AA1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[2]	=>  Location: PIN_W2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[3]	=>  Location: PIN_Y3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[4]	=>  Location: PIN_N2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[5]	=>  Location: PIN_N1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[6]	=>  Location: PIN_U2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[7]	=>  Location: PIN_U1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- CLOCK_50	=>  Location: PIN_M9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_U13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[1]	=>  Location: PIN_V13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[2]	=>  Location: PIN_T13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[3]	=>  Location: PIN_T12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[4]	=>  Location: PIN_AA15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[5]	=>  Location: PIN_AB15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[6]	=>  Location: PIN_AA14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[7]	=>  Location: PIN_AA13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF Aula_4 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLOCK_50 : std_logic;
SIGNAL ww_SW : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_LEDR : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \CLOCK_50~input_o\ : std_logic;
SIGNAL \CLOCK_50~inputCLKENA0_outclk\ : std_logic;
SIGNAL \SW[0]~input_o\ : std_logic;
SIGNAL \incremento|Add0~1_sumout\ : std_logic;
SIGNAL \incremento|Add0~2\ : std_logic;
SIGNAL \incremento|Add0~5_sumout\ : std_logic;
SIGNAL \incremento|Add0~6\ : std_logic;
SIGNAL \incremento|Add0~29_sumout\ : std_logic;
SIGNAL \MUX_proxPC|saida_MUX[2]~0_combout\ : std_logic;
SIGNAL \incremento|Add0~30\ : std_logic;
SIGNAL \incremento|Add0~25_sumout\ : std_logic;
SIGNAL \incremento|Add0~26\ : std_logic;
SIGNAL \incremento|Add0~21_sumout\ : std_logic;
SIGNAL \incremento|Add0~22\ : std_logic;
SIGNAL \incremento|Add0~17_sumout\ : std_logic;
SIGNAL \incremento|Add0~18\ : std_logic;
SIGNAL \incremento|Add0~13_sumout\ : std_logic;
SIGNAL \incremento|Add0~14\ : std_logic;
SIGNAL \incremento|Add0~9_sumout\ : std_logic;
SIGNAL \ROM|memROM~0_combout\ : std_logic;
SIGNAL \PC|DOUT[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ROM|memROM~2_combout\ : std_logic;
SIGNAL \saidaLEDs|saida[0]~feeder_combout\ : std_logic;
SIGNAL \ROM|memROM~1_combout\ : std_logic;
SIGNAL \SW[1]~input_o\ : std_logic;
SIGNAL \saidaLEDs|saida[1]~feeder_combout\ : std_logic;
SIGNAL \SW[2]~input_o\ : std_logic;
SIGNAL \Acumulador|DOUT[2]~feeder_combout\ : std_logic;
SIGNAL \SW[3]~input_o\ : std_logic;
SIGNAL \saidaLEDs|saida[3]~feeder_combout\ : std_logic;
SIGNAL \SW[4]~input_o\ : std_logic;
SIGNAL \Acumulador|DOUT[4]~feeder_combout\ : std_logic;
SIGNAL \SW[5]~input_o\ : std_logic;
SIGNAL \Acumulador|DOUT[5]~feeder_combout\ : std_logic;
SIGNAL \SW[6]~input_o\ : std_logic;
SIGNAL \Acumulador|DOUT[6]~feeder_combout\ : std_logic;
SIGNAL \SW[7]~input_o\ : std_logic;
SIGNAL \Acumulador|DOUT[7]~feeder_combout\ : std_logic;
SIGNAL \saidaLEDs|saida\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \Acumulador|DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \PC|DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \incremento|ALT_INV_Add0~29_sumout\ : std_logic;
SIGNAL \PC|ALT_INV_DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \Acumulador|ALT_INV_DOUT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \PC|ALT_INV_DOUT[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_SW[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[2]~input_o\ : std_logic;
SIGNAL \ROM|ALT_INV_memROM~0_combout\ : std_logic;

BEGIN

ww_CLOCK_50 <= CLOCK_50;
ww_SW <= SW;
LEDR <= ww_LEDR;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\incremento|ALT_INV_Add0~29_sumout\ <= NOT \incremento|Add0~29_sumout\;
\PC|ALT_INV_DOUT\(0) <= NOT \PC|DOUT\(0);
\PC|ALT_INV_DOUT\(1) <= NOT \PC|DOUT\(1);
\PC|ALT_INV_DOUT\(7) <= NOT \PC|DOUT\(7);
\Acumulador|ALT_INV_DOUT\(0) <= NOT \Acumulador|DOUT\(0);
\PC|ALT_INV_DOUT[0]~DUPLICATE_q\ <= NOT \PC|DOUT[0]~DUPLICATE_q\;
\ALT_INV_SW[7]~input_o\ <= NOT \SW[7]~input_o\;
\ALT_INV_SW[6]~input_o\ <= NOT \SW[6]~input_o\;
\ALT_INV_SW[5]~input_o\ <= NOT \SW[5]~input_o\;
\ALT_INV_SW[4]~input_o\ <= NOT \SW[4]~input_o\;
\ALT_INV_SW[2]~input_o\ <= NOT \SW[2]~input_o\;
\Acumulador|ALT_INV_DOUT\(3) <= NOT \Acumulador|DOUT\(3);
\Acumulador|ALT_INV_DOUT\(1) <= NOT \Acumulador|DOUT\(1);
\ROM|ALT_INV_memROM~0_combout\ <= NOT \ROM|memROM~0_combout\;
\PC|ALT_INV_DOUT\(2) <= NOT \PC|DOUT\(2);
\PC|ALT_INV_DOUT\(3) <= NOT \PC|DOUT\(3);
\PC|ALT_INV_DOUT\(4) <= NOT \PC|DOUT\(4);
\PC|ALT_INV_DOUT\(5) <= NOT \PC|DOUT\(5);
\PC|ALT_INV_DOUT\(6) <= NOT \PC|DOUT\(6);

-- Location: IOOBUF_X0_Y18_N79
\LEDR[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(0),
	devoe => ww_devoe,
	o => ww_LEDR(0));

-- Location: IOOBUF_X0_Y18_N96
\LEDR[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(1),
	devoe => ww_devoe,
	o => ww_LEDR(1));

-- Location: IOOBUF_X0_Y18_N62
\LEDR[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(2),
	devoe => ww_devoe,
	o => ww_LEDR(2));

-- Location: IOOBUF_X0_Y18_N45
\LEDR[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(3),
	devoe => ww_devoe,
	o => ww_LEDR(3));

-- Location: IOOBUF_X0_Y19_N39
\LEDR[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(4),
	devoe => ww_devoe,
	o => ww_LEDR(4));

-- Location: IOOBUF_X0_Y19_N56
\LEDR[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(5),
	devoe => ww_devoe,
	o => ww_LEDR(5));

-- Location: IOOBUF_X0_Y19_N5
\LEDR[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(6),
	devoe => ww_devoe,
	o => ww_LEDR(6));

-- Location: IOOBUF_X0_Y19_N22
\LEDR[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \saidaLEDs|saida\(7),
	devoe => ww_devoe,
	o => ww_LEDR(7));

-- Location: IOIBUF_X22_Y0_N1
\CLOCK_50~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK_50,
	o => \CLOCK_50~input_o\);

-- Location: CLKCTRL_G6
\CLOCK_50~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK_50~input_o\,
	outclk => \CLOCK_50~inputCLKENA0_outclk\);

-- Location: IOIBUF_X33_Y0_N41
\SW[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(0),
	o => \SW[0]~input_o\);

-- Location: LABCELL_X7_Y14_N30
\incremento|Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~1_sumout\ = SUM(( \PC|DOUT\(0) ) + ( VCC ) + ( !VCC ))
-- \incremento|Add0~2\ = CARRY(( \PC|DOUT\(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(0),
	cin => GND,
	sumout => \incremento|Add0~1_sumout\,
	cout => \incremento|Add0~2\);

-- Location: FF_X7_Y14_N32
\PC|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(0));

-- Location: LABCELL_X7_Y14_N33
\incremento|Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~5_sumout\ = SUM(( \PC|DOUT\(1) ) + ( GND ) + ( \incremento|Add0~2\ ))
-- \incremento|Add0~6\ = CARRY(( \PC|DOUT\(1) ) + ( GND ) + ( \incremento|Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(1),
	cin => \incremento|Add0~2\,
	sumout => \incremento|Add0~5_sumout\,
	cout => \incremento|Add0~6\);

-- Location: FF_X7_Y14_N34
\PC|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~5_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(1));

-- Location: LABCELL_X7_Y14_N36
\incremento|Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~29_sumout\ = SUM(( \PC|DOUT\(2) ) + ( GND ) + ( \incremento|Add0~6\ ))
-- \incremento|Add0~30\ = CARRY(( \PC|DOUT\(2) ) + ( GND ) + ( \incremento|Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \PC|ALT_INV_DOUT\(2),
	cin => \incremento|Add0~6\,
	sumout => \incremento|Add0~29_sumout\,
	cout => \incremento|Add0~30\);

-- Location: LABCELL_X7_Y14_N6
\MUX_proxPC|saida_MUX[2]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \MUX_proxPC|saida_MUX[2]~0_combout\ = ( \PC|DOUT\(1) & ( (\incremento|Add0~29_sumout\ & ((!\PC|DOUT\(0)) # (!\ROM|memROM~0_combout\))) ) ) # ( !\PC|DOUT\(1) & ( \incremento|Add0~29_sumout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000111111000000000011111100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \PC|ALT_INV_DOUT\(0),
	datac => \ROM|ALT_INV_memROM~0_combout\,
	datad => \incremento|ALT_INV_Add0~29_sumout\,
	dataf => \PC|ALT_INV_DOUT\(1),
	combout => \MUX_proxPC|saida_MUX[2]~0_combout\);

-- Location: FF_X7_Y14_N8
\PC|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \MUX_proxPC|saida_MUX[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(2));

-- Location: LABCELL_X7_Y14_N39
\incremento|Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~25_sumout\ = SUM(( \PC|DOUT\(3) ) + ( GND ) + ( \incremento|Add0~30\ ))
-- \incremento|Add0~26\ = CARRY(( \PC|DOUT\(3) ) + ( GND ) + ( \incremento|Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(3),
	cin => \incremento|Add0~30\,
	sumout => \incremento|Add0~25_sumout\,
	cout => \incremento|Add0~26\);

-- Location: FF_X7_Y14_N41
\PC|DOUT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~25_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(3));

-- Location: LABCELL_X7_Y14_N42
\incremento|Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~21_sumout\ = SUM(( \PC|DOUT\(4) ) + ( GND ) + ( \incremento|Add0~26\ ))
-- \incremento|Add0~22\ = CARRY(( \PC|DOUT\(4) ) + ( GND ) + ( \incremento|Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(4),
	cin => \incremento|Add0~26\,
	sumout => \incremento|Add0~21_sumout\,
	cout => \incremento|Add0~22\);

-- Location: FF_X7_Y14_N44
\PC|DOUT[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~21_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(4));

-- Location: LABCELL_X7_Y14_N45
\incremento|Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~17_sumout\ = SUM(( \PC|DOUT\(5) ) + ( GND ) + ( \incremento|Add0~22\ ))
-- \incremento|Add0~18\ = CARRY(( \PC|DOUT\(5) ) + ( GND ) + ( \incremento|Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(5),
	cin => \incremento|Add0~22\,
	sumout => \incremento|Add0~17_sumout\,
	cout => \incremento|Add0~18\);

-- Location: FF_X7_Y14_N47
\PC|DOUT[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~17_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(5));

-- Location: LABCELL_X7_Y14_N48
\incremento|Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~13_sumout\ = SUM(( \PC|DOUT\(6) ) + ( GND ) + ( \incremento|Add0~18\ ))
-- \incremento|Add0~14\ = CARRY(( \PC|DOUT\(6) ) + ( GND ) + ( \incremento|Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(6),
	cin => \incremento|Add0~18\,
	sumout => \incremento|Add0~13_sumout\,
	cout => \incremento|Add0~14\);

-- Location: FF_X7_Y14_N50
\PC|DOUT[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~13_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(6));

-- Location: LABCELL_X7_Y14_N51
\incremento|Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \incremento|Add0~9_sumout\ = SUM(( \PC|DOUT\(7) ) + ( GND ) + ( \incremento|Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \PC|ALT_INV_DOUT\(7),
	cin => \incremento|Add0~14\,
	sumout => \incremento|Add0~9_sumout\);

-- Location: FF_X7_Y14_N53
\PC|DOUT[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~9_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT\(7));

-- Location: LABCELL_X7_Y14_N0
\ROM|memROM~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM|memROM~0_combout\ = ( !\PC|DOUT\(5) & ( !\PC|DOUT\(3) & ( (!\PC|DOUT\(7) & (!\PC|DOUT\(2) & (!\PC|DOUT\(6) & !\PC|DOUT\(4)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(7),
	datab => \PC|ALT_INV_DOUT\(2),
	datac => \PC|ALT_INV_DOUT\(6),
	datad => \PC|ALT_INV_DOUT\(4),
	datae => \PC|ALT_INV_DOUT\(5),
	dataf => \PC|ALT_INV_DOUT\(3),
	combout => \ROM|memROM~0_combout\);

-- Location: FF_X7_Y14_N31
\PC|DOUT[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \incremento|Add0~1_sumout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \PC|DOUT[0]~DUPLICATE_q\);

-- Location: LABCELL_X7_Y14_N9
\ROM|memROM~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM|memROM~2_combout\ = ( !\PC|DOUT[0]~DUPLICATE_q\ & ( (!\PC|DOUT\(1) & \ROM|memROM~0_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010101010000000001010101000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \PC|ALT_INV_DOUT\(1),
	datad => \ROM|ALT_INV_memROM~0_combout\,
	dataf => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	combout => \ROM|memROM~2_combout\);

-- Location: FF_X7_Y14_N5
\Acumulador|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \SW[0]~input_o\,
	sload => VCC,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(0));

-- Location: LABCELL_X1_Y18_N33
\saidaLEDs|saida[0]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \saidaLEDs|saida[0]~feeder_combout\ = ( \Acumulador|DOUT\(0) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \Acumulador|ALT_INV_DOUT\(0),
	combout => \saidaLEDs|saida[0]~feeder_combout\);

-- Location: LABCELL_X7_Y14_N12
\ROM|memROM~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \ROM|memROM~1_combout\ = ( \ROM|memROM~0_combout\ & ( \PC|DOUT[0]~DUPLICATE_q\ & ( !\PC|DOUT\(1) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \PC|ALT_INV_DOUT\(1),
	datae => \ROM|ALT_INV_memROM~0_combout\,
	dataf => \PC|ALT_INV_DOUT[0]~DUPLICATE_q\,
	combout => \ROM|memROM~1_combout\);

-- Location: FF_X1_Y18_N35
\saidaLEDs|saida[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \saidaLEDs|saida[0]~feeder_combout\,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(0));

-- Location: IOIBUF_X33_Y0_N58
\SW[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(1),
	o => \SW[1]~input_o\);

-- Location: FF_X7_Y14_N16
\Acumulador|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \SW[1]~input_o\,
	sload => VCC,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(1));

-- Location: LABCELL_X1_Y18_N36
\saidaLEDs|saida[1]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \saidaLEDs|saida[1]~feeder_combout\ = ( \Acumulador|DOUT\(1) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \Acumulador|ALT_INV_DOUT\(1),
	combout => \saidaLEDs|saida[1]~feeder_combout\);

-- Location: FF_X1_Y18_N38
\saidaLEDs|saida[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \saidaLEDs|saida[1]~feeder_combout\,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(1));

-- Location: IOIBUF_X34_Y0_N1
\SW[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(2),
	o => \SW[2]~input_o\);

-- Location: LABCELL_X7_Y14_N18
\Acumulador|DOUT[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \Acumulador|DOUT[2]~feeder_combout\ = ( \SW[2]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_SW[2]~input_o\,
	combout => \Acumulador|DOUT[2]~feeder_combout\);

-- Location: FF_X7_Y14_N19
\Acumulador|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \Acumulador|DOUT[2]~feeder_combout\,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(2));

-- Location: FF_X1_Y18_N43
\saidaLEDs|saida[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \Acumulador|DOUT\(2),
	sload => VCC,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(2));

-- Location: IOIBUF_X34_Y0_N18
\SW[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(3),
	o => \SW[3]~input_o\);

-- Location: FF_X7_Y14_N22
\Acumulador|DOUT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \SW[3]~input_o\,
	sload => VCC,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(3));

-- Location: LABCELL_X1_Y18_N51
\saidaLEDs|saida[3]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \saidaLEDs|saida[3]~feeder_combout\ = ( \Acumulador|DOUT\(3) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \Acumulador|ALT_INV_DOUT\(3),
	combout => \saidaLEDs|saida[3]~feeder_combout\);

-- Location: FF_X1_Y18_N52
\saidaLEDs|saida[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \saidaLEDs|saida[3]~feeder_combout\,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(3));

-- Location: IOIBUF_X36_Y0_N35
\SW[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(4),
	o => \SW[4]~input_o\);

-- Location: LABCELL_X7_Y14_N24
\Acumulador|DOUT[4]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \Acumulador|DOUT[4]~feeder_combout\ = ( \SW[4]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_SW[4]~input_o\,
	combout => \Acumulador|DOUT[4]~feeder_combout\);

-- Location: FF_X7_Y14_N25
\Acumulador|DOUT[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \Acumulador|DOUT[4]~feeder_combout\,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(4));

-- Location: FF_X1_Y18_N56
\saidaLEDs|saida[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \Acumulador|DOUT\(4),
	sload => VCC,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(4));

-- Location: IOIBUF_X36_Y0_N52
\SW[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(5),
	o => \SW[5]~input_o\);

-- Location: LABCELL_X7_Y14_N27
\Acumulador|DOUT[5]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \Acumulador|DOUT[5]~feeder_combout\ = ( \SW[5]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_SW[5]~input_o\,
	combout => \Acumulador|DOUT[5]~feeder_combout\);

-- Location: FF_X7_Y14_N29
\Acumulador|DOUT[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \Acumulador|DOUT[5]~feeder_combout\,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(5));

-- Location: FF_X1_Y18_N5
\saidaLEDs|saida[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \Acumulador|DOUT\(5),
	sload => VCC,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(5));

-- Location: IOIBUF_X34_Y0_N52
\SW[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(6),
	o => \SW[6]~input_o\);

-- Location: LABCELL_X7_Y14_N54
\Acumulador|DOUT[6]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \Acumulador|DOUT[6]~feeder_combout\ = ( \SW[6]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_SW[6]~input_o\,
	combout => \Acumulador|DOUT[6]~feeder_combout\);

-- Location: FF_X7_Y14_N55
\Acumulador|DOUT[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \Acumulador|DOUT[6]~feeder_combout\,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(6));

-- Location: FF_X1_Y18_N8
\saidaLEDs|saida[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \Acumulador|DOUT\(6),
	sload => VCC,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(6));

-- Location: IOIBUF_X34_Y0_N35
\SW[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(7),
	o => \SW[7]~input_o\);

-- Location: LABCELL_X7_Y14_N57
\Acumulador|DOUT[7]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \Acumulador|DOUT[7]~feeder_combout\ = ( \SW[7]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_SW[7]~input_o\,
	combout => \Acumulador|DOUT[7]~feeder_combout\);

-- Location: FF_X7_Y14_N58
\Acumulador|DOUT[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	d => \Acumulador|DOUT[7]~feeder_combout\,
	ena => \ROM|memROM~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Acumulador|DOUT\(7));

-- Location: FF_X1_Y18_N17
\saidaLEDs|saida[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputCLKENA0_outclk\,
	asdata => \Acumulador|DOUT\(7),
	sload => VCC,
	ena => \ROM|memROM~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \saidaLEDs|saida\(7));

-- Location: LABCELL_X16_Y38_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


