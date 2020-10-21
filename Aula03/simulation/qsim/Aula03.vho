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

-- DATE "09/03/2020 11:33:05"

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

ENTITY 	Aula03 IS
    PORT (
	CLOCK_50 : IN std_logic;
	FPGA_RESET_N : IN std_logic;
	LEDR : OUT std_logic_vector(9 DOWNTO 0)
	);
END Aula03;

-- Design Ports Information
-- LEDR[0]	=>  Location: PIN_AA2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[1]	=>  Location: PIN_AA1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[2]	=>  Location: PIN_W2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[3]	=>  Location: PIN_Y3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[4]	=>  Location: PIN_N2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[5]	=>  Location: PIN_N1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[6]	=>  Location: PIN_U2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[7]	=>  Location: PIN_U1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[8]	=>  Location: PIN_L2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- LEDR[9]	=>  Location: PIN_L1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- FPGA_RESET_N	=>  Location: PIN_P22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- CLOCK_50	=>  Location: PIN_M9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF Aula03 IS
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
SIGNAL ww_FPGA_RESET_N : std_logic;
SIGNAL ww_LEDR : std_logic_vector(9 DOWNTO 0);
SIGNAL \FPGA_RESET_N~input_o\ : std_logic;
SIGNAL \CLOCK_50~input_o\ : std_logic;
SIGNAL \detectorCLK|saidaQ~0_combout\ : std_logic;
SIGNAL \detectorCLK|saidaQ~q\ : std_logic;
SIGNAL \detectorCLK|saida~combout\ : std_logic;
SIGNAL \maqEstados|regA|DOUT[0]~1_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~2_combout\ : std_logic;
SIGNAL \maqEstados|regA|DOUT[2]~0_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~3_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~4_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~5_combout\ : std_logic;
SIGNAL \regA|DOUT[0]~feeder_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~1_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~6_combout\ : std_logic;
SIGNAL \ULA|Add0~34_cout\ : std_logic;
SIGNAL \ULA|Add0~1_sumout\ : std_logic;
SIGNAL \regB|DOUT[1]~feeder_combout\ : std_logic;
SIGNAL \regA|DOUT[1]~feeder_combout\ : std_logic;
SIGNAL \ULA|Add0~2\ : std_logic;
SIGNAL \ULA|Add0~5_sumout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~7_combout\ : std_logic;
SIGNAL \regA|DOUT[2]~feeder_combout\ : std_logic;
SIGNAL \ULA|Add0~6\ : std_logic;
SIGNAL \ULA|Add0~9_sumout\ : std_logic;
SIGNAL \regA|DOUT[3]~feeder_combout\ : std_logic;
SIGNAL \~GND~combout\ : std_logic;
SIGNAL \ULA|Add0~10\ : std_logic;
SIGNAL \ULA|Add0~13_sumout\ : std_logic;
SIGNAL \regA|DOUT[4]~feeder_combout\ : std_logic;
SIGNAL \ULA|Add0~14\ : std_logic;
SIGNAL \ULA|Add0~17_sumout\ : std_logic;
SIGNAL \regA|DOUT[5]~feeder_combout\ : std_logic;
SIGNAL \ULA|Add0~18\ : std_logic;
SIGNAL \ULA|Add0~21_sumout\ : std_logic;
SIGNAL \regA|DOUT[6]~feeder_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~8_combout\ : std_logic;
SIGNAL \ULA|Add0~22\ : std_logic;
SIGNAL \ULA|Add0~25_sumout\ : std_logic;
SIGNAL \regA|DOUT[7]~feeder_combout\ : std_logic;
SIGNAL \ULA|Add0~26\ : std_logic;
SIGNAL \ULA|Add0~29_sumout\ : std_logic;
SIGNAL \maqEstados|memoria1|memROM~0_combout\ : std_logic;
SIGNAL \regA|DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \maqEstados|regA|DOUT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \regB|DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \regA|ALT_INV_DOUT\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ULA|ALT_INV_Add0~29_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~25_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~21_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~17_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~13_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~9_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~5_sumout\ : std_logic;
SIGNAL \ULA|ALT_INV_Add0~1_sumout\ : std_logic;
SIGNAL \maqEstados|regA|ALT_INV_DOUT\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \maqEstados|memoria1|ALT_INV_memROM~0_combout\ : std_logic;
SIGNAL \regB|ALT_INV_DOUT\ : std_logic_vector(6 DOWNTO 0);
SIGNAL \maqEstados|memoria1|ALT_INV_memROM~1_combout\ : std_logic;
SIGNAL \maqEstados|memoria1|ALT_INV_memROM~4_combout\ : std_logic;
SIGNAL \detectorCLK|ALT_INV_saidaQ~q\ : std_logic;
SIGNAL \ALT_INV_FPGA_RESET_N~input_o\ : std_logic;

BEGIN

ww_CLOCK_50 <= CLOCK_50;
ww_FPGA_RESET_N <= FPGA_RESET_N;
LEDR <= ww_LEDR;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\regA|ALT_INV_DOUT\(1) <= NOT \regA|DOUT\(1);
\regA|ALT_INV_DOUT\(0) <= NOT \regA|DOUT\(0);
\ULA|ALT_INV_Add0~29_sumout\ <= NOT \ULA|Add0~29_sumout\;
\ULA|ALT_INV_Add0~25_sumout\ <= NOT \ULA|Add0~25_sumout\;
\ULA|ALT_INV_Add0~21_sumout\ <= NOT \ULA|Add0~21_sumout\;
\ULA|ALT_INV_Add0~17_sumout\ <= NOT \ULA|Add0~17_sumout\;
\ULA|ALT_INV_Add0~13_sumout\ <= NOT \ULA|Add0~13_sumout\;
\ULA|ALT_INV_Add0~9_sumout\ <= NOT \ULA|Add0~9_sumout\;
\ULA|ALT_INV_Add0~5_sumout\ <= NOT \ULA|Add0~5_sumout\;
\ULA|ALT_INV_Add0~1_sumout\ <= NOT \ULA|Add0~1_sumout\;
\regA|ALT_INV_DOUT\(2) <= NOT \regA|DOUT\(2);
\regA|ALT_INV_DOUT\(3) <= NOT \regA|DOUT\(3);
\regA|ALT_INV_DOUT\(5) <= NOT \regA|DOUT\(5);
\regA|ALT_INV_DOUT\(4) <= NOT \regA|DOUT\(4);
\regA|ALT_INV_DOUT\(6) <= NOT \regA|DOUT\(6);
\regA|ALT_INV_DOUT\(7) <= NOT \regA|DOUT\(7);
\maqEstados|regA|ALT_INV_DOUT\(1) <= NOT \maqEstados|regA|DOUT\(1);
\maqEstados|regA|ALT_INV_DOUT\(0) <= NOT \maqEstados|regA|DOUT\(0);
\maqEstados|memoria1|ALT_INV_memROM~0_combout\ <= NOT \maqEstados|memoria1|memROM~0_combout\;
\maqEstados|regA|ALT_INV_DOUT\(2) <= NOT \maqEstados|regA|DOUT\(2);
\regB|ALT_INV_DOUT\(0) <= NOT \regB|DOUT\(0);
\maqEstados|memoria1|ALT_INV_memROM~1_combout\ <= NOT \maqEstados|memoria1|memROM~1_combout\;
\regB|ALT_INV_DOUT\(1) <= NOT \regB|DOUT\(1);
\regB|ALT_INV_DOUT\(2) <= NOT \regB|DOUT\(2);
\regB|ALT_INV_DOUT\(6) <= NOT \regB|DOUT\(6);
\maqEstados|memoria1|ALT_INV_memROM~4_combout\ <= NOT \maqEstados|memoria1|memROM~4_combout\;
\detectorCLK|ALT_INV_saidaQ~q\ <= NOT \detectorCLK|saidaQ~q\;
\ALT_INV_FPGA_RESET_N~input_o\ <= NOT \FPGA_RESET_N~input_o\;

-- Location: IOOBUF_X0_Y18_N79
\LEDR[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ULA|Add0~1_sumout\,
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
	i => \ULA|Add0~5_sumout\,
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
	i => \ULA|Add0~9_sumout\,
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
	i => \ULA|Add0~13_sumout\,
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
	i => \ULA|Add0~17_sumout\,
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
	i => \ULA|Add0~21_sumout\,
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
	i => \ULA|Add0~25_sumout\,
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
	i => \ULA|Add0~29_sumout\,
	devoe => ww_devoe,
	o => ww_LEDR(7));

-- Location: IOOBUF_X0_Y20_N39
\LEDR[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \maqEstados|memoria1|ALT_INV_memROM~0_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(8));

-- Location: IOOBUF_X0_Y20_N56
\LEDR[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \maqEstados|memoria1|memROM~1_combout\,
	devoe => ww_devoe,
	o => ww_LEDR(9));

-- Location: IOIBUF_X54_Y16_N55
\FPGA_RESET_N~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_FPGA_RESET_N,
	o => \FPGA_RESET_N~input_o\);

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

-- Location: LABCELL_X2_Y18_N18
\detectorCLK|saidaQ~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \detectorCLK|saidaQ~0_combout\ = !\FPGA_RESET_N~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001100110011001100110011001100110011001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_FPGA_RESET_N~input_o\,
	combout => \detectorCLK|saidaQ~0_combout\);

-- Location: FF_X2_Y18_N20
\detectorCLK|saidaQ\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~input_o\,
	d => \detectorCLK|saidaQ~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \detectorCLK|saidaQ~q\);

-- Location: LABCELL_X2_Y18_N3
\detectorCLK|saida\ : cyclonev_lcell_comb
-- Equation(s):
-- \detectorCLK|saida~combout\ = LCELL(( \detectorCLK|saidaQ~q\ & ( \FPGA_RESET_N~input_o\ ) ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000111111110000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_FPGA_RESET_N~input_o\,
	dataf => \detectorCLK|ALT_INV_saidaQ~q\,
	combout => \detectorCLK|saida~combout\);

-- Location: LABCELL_X2_Y18_N27
\maqEstados|regA|DOUT[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|regA|DOUT[0]~1_combout\ = !\maqEstados|regA|DOUT\(0)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001100110011001100110011001100110011001100110011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|regA|DOUT[0]~1_combout\);

-- Location: FF_X2_Y18_N11
\maqEstados|regA|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	asdata => \maqEstados|regA|DOUT[0]~1_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \maqEstados|regA|DOUT\(0));

-- Location: LABCELL_X2_Y18_N6
\maqEstados|memoria1|memROM~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~2_combout\ = ( \maqEstados|regA|DOUT\(0) & ( !\maqEstados|regA|DOUT\(1) ) ) # ( !\maqEstados|regA|DOUT\(0) & ( \maqEstados|regA|DOUT\(1) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010110101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(1),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|memoria1|memROM~2_combout\);

-- Location: FF_X2_Y18_N26
\maqEstados|regA|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	asdata => \maqEstados|memoria1|memROM~2_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \maqEstados|regA|DOUT\(1));

-- Location: LABCELL_X2_Y18_N24
\maqEstados|regA|DOUT[2]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|regA|DOUT[2]~0_combout\ = ( \maqEstados|regA|DOUT\(2) & ( (!\maqEstados|regA|DOUT\(0)) # (!\maqEstados|regA|DOUT\(1)) ) ) # ( !\maqEstados|regA|DOUT\(2) & ( (\maqEstados|regA|DOUT\(0) & \maqEstados|regA|DOUT\(1)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000110011000000000011001111111111110011001111111111001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datad => \maqEstados|regA|ALT_INV_DOUT\(1),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(2),
	combout => \maqEstados|regA|DOUT[2]~0_combout\);

-- Location: FF_X2_Y18_N29
\maqEstados|regA|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	asdata => \maqEstados|regA|DOUT[2]~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \maqEstados|regA|DOUT\(2));

-- Location: LABCELL_X2_Y18_N9
\maqEstados|memoria1|memROM~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~3_combout\ = ( \maqEstados|regA|DOUT\(1) & ( (\maqEstados|regA|DOUT\(2) & !\maqEstados|regA|DOUT\(0)) ) ) # ( !\maqEstados|regA|DOUT\(1) & ( !\maqEstados|regA|DOUT\(0) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100000000111111110000000000001111000000000000111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \maqEstados|regA|ALT_INV_DOUT\(2),
	datad => \maqEstados|regA|ALT_INV_DOUT\(0),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(1),
	combout => \maqEstados|memoria1|memROM~3_combout\);

-- Location: LABCELL_X1_Y18_N15
\maqEstados|memoria1|memROM~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~4_combout\ = ( \maqEstados|regA|DOUT\(0) & ( (\maqEstados|regA|DOUT\(2) & \maqEstados|regA|DOUT\(1)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000101000001010000010100000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(2),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|memoria1|memROM~4_combout\);

-- Location: LABCELL_X2_Y18_N21
\maqEstados|memoria1|memROM~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~5_combout\ = ( \maqEstados|regA|DOUT\(0) & ( (!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(2)) ) ) # ( !\maqEstados|regA|DOUT\(0) & ( !\maqEstados|regA|DOUT\(1) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000011110000111100001111000011110000000000001111000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	datad => \maqEstados|regA|ALT_INV_DOUT\(2),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|memoria1|memROM~5_combout\);

-- Location: FF_X2_Y18_N14
\regB|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	asdata => \maqEstados|memoria1|memROM~3_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => VCC,
	ena => \maqEstados|memoria1|memROM~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regB|DOUT\(0));

-- Location: LABCELL_X1_Y18_N48
\regA|DOUT[0]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[0]~feeder_combout\ = \ULA|Add0~1_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ULA|ALT_INV_Add0~1_sumout\,
	combout => \regA|DOUT[0]~feeder_combout\);

-- Location: LABCELL_X1_Y18_N54
\maqEstados|memoria1|memROM~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~1_combout\ = ( \maqEstados|regA|DOUT\(0) & ( !\maqEstados|regA|DOUT\(2) ) ) # ( !\maqEstados|regA|DOUT\(0) & ( !\maqEstados|regA|DOUT\(1) $ (!\maqEstados|regA|DOUT\(2)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100001111000011110011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(1),
	datac => \maqEstados|regA|ALT_INV_DOUT\(2),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|memoria1|memROM~1_combout\);

-- Location: LABCELL_X1_Y18_N24
\maqEstados|memoria1|memROM~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~6_combout\ = ( \maqEstados|regA|DOUT\(0) & ( !\maqEstados|regA|DOUT\(2) ) ) # ( !\maqEstados|regA|DOUT\(0) & ( (!\maqEstados|regA|DOUT\(1)) # (!\maqEstados|regA|DOUT\(2)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111110011111100111111001111110011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(1),
	datac => \maqEstados|regA|ALT_INV_DOUT\(2),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|memoria1|memROM~6_combout\);

-- Location: FF_X1_Y18_N49
\regA|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[0]~feeder_combout\,
	asdata => \maqEstados|memoria1|memROM~3_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(0));

-- Location: LABCELL_X2_Y18_N30
\ULA|Add0~34\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~34_cout\ = CARRY(( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	cin => GND,
	cout => \ULA|Add0~34_cout\);

-- Location: LABCELL_X2_Y18_N33
\ULA|Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~1_sumout\ = SUM(( \regA|DOUT\(0) ) + ( !\regB|DOUT\(0) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \ULA|Add0~34_cout\ ))
-- \ULA|Add0~2\ = CARRY(( \regA|DOUT\(0) ) + ( !\regB|DOUT\(0) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \ULA|Add0~34_cout\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100001111000011100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(1),
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \regB|ALT_INV_DOUT\(0),
	datad => \regA|ALT_INV_DOUT\(0),
	cin => \ULA|Add0~34_cout\,
	sumout => \ULA|Add0~1_sumout\,
	cout => \ULA|Add0~2\);

-- Location: LABCELL_X2_Y18_N0
\regB|DOUT[1]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regB|DOUT[1]~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	combout => \regB|DOUT[1]~feeder_combout\);

-- Location: FF_X2_Y18_N2
\regB|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regB|DOUT[1]~feeder_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	ena => \maqEstados|memoria1|memROM~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regB|DOUT\(1));

-- Location: LABCELL_X1_Y18_N57
\regA|DOUT[1]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[1]~feeder_combout\ = ( \ULA|Add0~5_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ULA|ALT_INV_Add0~5_sumout\,
	combout => \regA|DOUT[1]~feeder_combout\);

-- Location: FF_X1_Y18_N58
\regA|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[1]~feeder_combout\,
	asdata => VCC,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(1));

-- Location: LABCELL_X2_Y18_N36
\ULA|Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~5_sumout\ = SUM(( \regA|DOUT\(1) ) + ( !\regB|DOUT\(1) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \ULA|Add0~2\ ))
-- \ULA|Add0~6\ = CARRY(( \regA|DOUT\(1) ) + ( !\regB|DOUT\(1) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \ULA|Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100001111000011100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(1),
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \regB|ALT_INV_DOUT\(1),
	datad => \regA|ALT_INV_DOUT\(1),
	cin => \ULA|Add0~2\,
	sumout => \ULA|Add0~5_sumout\,
	cout => \ULA|Add0~6\);

-- Location: LABCELL_X2_Y18_N12
\maqEstados|memoria1|memROM~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~7_combout\ = (\maqEstados|regA|DOUT\(2) & ((!\maqEstados|regA|DOUT\(0)) # (!\maqEstados|regA|DOUT\(1))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010001010100010101000101010001010100010101000101010001010100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(2),
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	combout => \maqEstados|memoria1|memROM~7_combout\);

-- Location: FF_X2_Y18_N17
\regB|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	asdata => \maqEstados|memoria1|memROM~7_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => VCC,
	ena => \maqEstados|memoria1|memROM~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regB|DOUT\(2));

-- Location: LABCELL_X1_Y18_N42
\regA|DOUT[2]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[2]~feeder_combout\ = \ULA|Add0~9_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ULA|ALT_INV_Add0~9_sumout\,
	combout => \regA|DOUT[2]~feeder_combout\);

-- Location: FF_X1_Y18_N43
\regA|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[2]~feeder_combout\,
	asdata => \maqEstados|memoria1|memROM~7_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(2));

-- Location: LABCELL_X2_Y18_N39
\ULA|Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~9_sumout\ = SUM(( \regA|DOUT\(2) ) + ( !\regB|DOUT\(2) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \ULA|Add0~6\ ))
-- \ULA|Add0~10\ = CARRY(( \regA|DOUT\(2) ) + ( !\regB|DOUT\(2) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \ULA|Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000100001111000011100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(1),
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \regB|ALT_INV_DOUT\(2),
	datad => \regA|ALT_INV_DOUT\(2),
	cin => \ULA|Add0~6\,
	sumout => \ULA|Add0~9_sumout\,
	cout => \ULA|Add0~10\);

-- Location: LABCELL_X1_Y18_N21
\regA|DOUT[3]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[3]~feeder_combout\ = \ULA|Add0~13_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ULA|ALT_INV_Add0~13_sumout\,
	combout => \regA|DOUT[3]~feeder_combout\);

-- Location: LABCELL_X1_Y18_N0
\~GND\ : cyclonev_lcell_comb
-- Equation(s):
-- \~GND~combout\ = GND

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	combout => \~GND~combout\);

-- Location: FF_X1_Y18_N22
\regA|DOUT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[3]~feeder_combout\,
	asdata => \~GND~combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(3));

-- Location: LABCELL_X2_Y18_N42
\ULA|Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~13_sumout\ = SUM(( \regA|DOUT\(3) ) + ( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( \ULA|Add0~10\ ))
-- \ULA|Add0~14\ = CARRY(( \regA|DOUT\(3) ) + ( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( \ULA|Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110000001100000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	datad => \regA|ALT_INV_DOUT\(3),
	cin => \ULA|Add0~10\,
	sumout => \ULA|Add0~13_sumout\,
	cout => \ULA|Add0~14\);

-- Location: LABCELL_X1_Y18_N12
\regA|DOUT[4]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[4]~feeder_combout\ = \ULA|Add0~17_sumout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ULA|ALT_INV_Add0~17_sumout\,
	combout => \regA|DOUT[4]~feeder_combout\);

-- Location: FF_X1_Y18_N13
\regA|DOUT[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[4]~feeder_combout\,
	asdata => \~GND~combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(4));

-- Location: LABCELL_X2_Y18_N45
\ULA|Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~17_sumout\ = SUM(( \regA|DOUT\(4) ) + ( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( \ULA|Add0~14\ ))
-- \ULA|Add0~18\ = CARRY(( \regA|DOUT\(4) ) + ( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( \ULA|Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110000001100000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	datad => \regA|ALT_INV_DOUT\(4),
	cin => \ULA|Add0~14\,
	sumout => \ULA|Add0~17_sumout\,
	cout => \ULA|Add0~18\);

-- Location: LABCELL_X1_Y18_N27
\regA|DOUT[5]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[5]~feeder_combout\ = ( \ULA|Add0~21_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ULA|ALT_INV_Add0~21_sumout\,
	combout => \regA|DOUT[5]~feeder_combout\);

-- Location: FF_X1_Y18_N28
\regA|DOUT[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[5]~feeder_combout\,
	asdata => \~GND~combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(5));

-- Location: LABCELL_X2_Y18_N48
\ULA|Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~21_sumout\ = SUM(( \regA|DOUT\(5) ) + ( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( \ULA|Add0~18\ ))
-- \ULA|Add0~22\ = CARRY(( \regA|DOUT\(5) ) + ( (\maqEstados|regA|DOUT\(1)) # (\maqEstados|regA|DOUT\(0)) ) + ( \ULA|Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110000001100000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	datad => \regA|ALT_INV_DOUT\(5),
	cin => \ULA|Add0~18\,
	sumout => \ULA|Add0~21_sumout\,
	cout => \ULA|Add0~22\);

-- Location: LABCELL_X1_Y18_N9
\regA|DOUT[6]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[6]~feeder_combout\ = ( \ULA|Add0~25_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ULA|ALT_INV_Add0~25_sumout\,
	combout => \regA|DOUT[6]~feeder_combout\);

-- Location: LABCELL_X2_Y18_N15
\maqEstados|memoria1|memROM~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~8_combout\ = (\maqEstados|regA|DOUT\(2) & (!\maqEstados|regA|DOUT\(0) $ (!\maqEstados|regA|DOUT\(1))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000101000100000100010100010000010001010001000001000101000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(2),
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datad => \maqEstados|regA|ALT_INV_DOUT\(1),
	combout => \maqEstados|memoria1|memROM~8_combout\);

-- Location: FF_X1_Y18_N10
\regA|DOUT[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[6]~feeder_combout\,
	asdata => \maqEstados|memoria1|memROM~8_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(6));

-- Location: FF_X2_Y18_N5
\regB|DOUT[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	asdata => \maqEstados|memoria1|memROM~8_combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => VCC,
	ena => \maqEstados|memoria1|memROM~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regB|DOUT\(6));

-- Location: LABCELL_X2_Y18_N51
\ULA|Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~25_sumout\ = SUM(( !\regB|DOUT\(6) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \regA|DOUT\(6) ) + ( \ULA|Add0~22\ ))
-- \ULA|Add0~26\ = CARRY(( !\regB|DOUT\(6) $ (((!\maqEstados|regA|DOUT\(1) & !\maqEstados|regA|DOUT\(0)))) ) + ( \regA|DOUT\(6) ) + ( \ULA|Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000000000000000000000111011110001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \maqEstados|regA|ALT_INV_DOUT\(1),
	datab => \maqEstados|regA|ALT_INV_DOUT\(0),
	datac => \regA|ALT_INV_DOUT\(6),
	datad => \regB|ALT_INV_DOUT\(6),
	cin => \ULA|Add0~22\,
	sumout => \ULA|Add0~25_sumout\,
	cout => \ULA|Add0~26\);

-- Location: LABCELL_X1_Y18_N18
\regA|DOUT[7]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \regA|DOUT[7]~feeder_combout\ = ( \ULA|Add0~29_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ULA|ALT_INV_Add0~29_sumout\,
	combout => \regA|DOUT[7]~feeder_combout\);

-- Location: FF_X1_Y18_N19
\regA|DOUT[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \detectorCLK|saida~combout\,
	d => \regA|DOUT[7]~feeder_combout\,
	asdata => \~GND~combout\,
	clrn => \maqEstados|memoria1|ALT_INV_memROM~4_combout\,
	sload => \maqEstados|memoria1|ALT_INV_memROM~1_combout\,
	ena => \maqEstados|memoria1|memROM~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \regA|DOUT\(7));

-- Location: LABCELL_X2_Y18_N54
\ULA|Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \ULA|Add0~29_sumout\ = SUM(( (\maqEstados|regA|DOUT\(0)) # (\maqEstados|regA|DOUT\(1)) ) + ( \regA|DOUT\(7) ) + ( \ULA|Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010101000000000000000000000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \regA|ALT_INV_DOUT\(7),
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	datad => \maqEstados|regA|ALT_INV_DOUT\(0),
	cin => \ULA|Add0~26\,
	sumout => \ULA|Add0~29_sumout\);

-- Location: LABCELL_X1_Y18_N39
\maqEstados|memoria1|memROM~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \maqEstados|memoria1|memROM~0_combout\ = ( \maqEstados|regA|DOUT\(0) ) # ( !\maqEstados|regA|DOUT\(0) & ( \maqEstados|regA|DOUT\(1) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \maqEstados|regA|ALT_INV_DOUT\(1),
	dataf => \maqEstados|regA|ALT_INV_DOUT\(0),
	combout => \maqEstados|memoria1|memROM~0_combout\);
END structure;


