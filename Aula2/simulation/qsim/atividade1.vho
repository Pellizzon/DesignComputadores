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

-- DATE "09/02/2020 08:46:48"

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

ENTITY 	MEF IS
    PORT (
	CLK : IN std_logic;
	Pontos_de_Controle : OUT std_logic_vector(13 DOWNTO 0)
	);
END MEF;

ARCHITECTURE structure OF MEF IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_Pontos_de_Controle : std_logic_vector(13 DOWNTO 0);
SIGNAL \Pontos_de_Controle[0]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[1]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[2]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[3]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[4]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[5]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[6]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[7]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[8]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[9]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[10]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[11]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[12]~output_o\ : std_logic;
SIGNAL \Pontos_de_Controle[13]~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \RegA|DOUT[0]~2_combout\ : std_logic;
SIGNAL \RegA|DOUT[1]~1_combout\ : std_logic;
SIGNAL \RegA|DOUT[2]~0_combout\ : std_logic;
SIGNAL \memoria1|memROM~0_combout\ : std_logic;
SIGNAL \memoria1|memROM~1_combout\ : std_logic;
SIGNAL \memoria1|memROM~2_combout\ : std_logic;
SIGNAL \RegA|DOUT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RegA|ALT_INV_DOUT\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \memoria1|ALT_INV_memROM~1_combout\ : std_logic;
SIGNAL \memoria1|ALT_INV_memROM~2_combout\ : std_logic;

BEGIN

ww_CLK <= CLK;
Pontos_de_Controle <= ww_Pontos_de_Controle;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\RegA|ALT_INV_DOUT\(2) <= NOT \RegA|DOUT\(2);
\RegA|ALT_INV_DOUT\(1) <= NOT \RegA|DOUT\(1);
\RegA|ALT_INV_DOUT\(0) <= NOT \RegA|DOUT\(0);
\memoria1|ALT_INV_memROM~1_combout\ <= NOT \memoria1|memROM~1_combout\;
\memoria1|ALT_INV_memROM~2_combout\ <= NOT \memoria1|memROM~2_combout\;

\Pontos_de_Controle[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \memoria1|memROM~0_combout\,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[0]~output_o\);

\Pontos_de_Controle[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \memoria1|ALT_INV_memROM~1_combout\,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[1]~output_o\);

\Pontos_de_Controle[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[2]~output_o\);

\Pontos_de_Controle[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[3]~output_o\);

\Pontos_de_Controle[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[4]~output_o\);

\Pontos_de_Controle[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[5]~output_o\);

\Pontos_de_Controle[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \memoria1|ALT_INV_memROM~2_combout\,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[6]~output_o\);

\Pontos_de_Controle[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[7]~output_o\);

\Pontos_de_Controle[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[8]~output_o\);

\Pontos_de_Controle[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[9]~output_o\);

\Pontos_de_Controle[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[10]~output_o\);

\Pontos_de_Controle[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[11]~output_o\);

\Pontos_de_Controle[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[12]~output_o\);

\Pontos_de_Controle[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \Pontos_de_Controle[13]~output_o\);

\CLK~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

\RegA|DOUT[0]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \RegA|DOUT[0]~2_combout\ = !\RegA|DOUT\(0)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010101010101010101010101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RegA|ALT_INV_DOUT\(0),
	combout => \RegA|DOUT[0]~2_combout\);

\RegA|DOUT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~input_o\,
	d => \RegA|DOUT[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|DOUT\(0));

\RegA|DOUT[1]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \RegA|DOUT[1]~1_combout\ = !\RegA|DOUT\(1) $ (!\RegA|DOUT\(0))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RegA|ALT_INV_DOUT\(1),
	datab => \RegA|ALT_INV_DOUT\(0),
	combout => \RegA|DOUT[1]~1_combout\);

\RegA|DOUT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~input_o\,
	d => \RegA|DOUT[1]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|DOUT\(1));

\RegA|DOUT[2]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \RegA|DOUT[2]~0_combout\ = !\RegA|DOUT\(2) $ (((!\RegA|DOUT\(1)) # (!\RegA|DOUT\(0))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101011001010110010101100101011001010110010101100101011001010110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RegA|ALT_INV_DOUT\(2),
	datab => \RegA|ALT_INV_DOUT\(1),
	datac => \RegA|ALT_INV_DOUT\(0),
	combout => \RegA|DOUT[2]~0_combout\);

\RegA|DOUT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~input_o\,
	d => \RegA|DOUT[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RegA|DOUT\(2));

\memoria1|memROM~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \memoria1|memROM~0_combout\ = (!\RegA|DOUT\(2) & (!\RegA|DOUT\(1) & !\RegA|DOUT\(0)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000010000000100000001000000010000000100000001000000010000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RegA|ALT_INV_DOUT\(2),
	datab => \RegA|ALT_INV_DOUT\(1),
	datac => \RegA|ALT_INV_DOUT\(0),
	combout => \memoria1|memROM~0_combout\);

\memoria1|memROM~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \memoria1|memROM~1_combout\ = (!\RegA|DOUT\(2) & (!\RegA|DOUT\(1) & !\RegA|DOUT\(0))) # (\RegA|DOUT\(2) & (\RegA|DOUT\(1) & \RegA|DOUT\(0)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000110000001100000011000000110000001100000011000000110000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RegA|ALT_INV_DOUT\(2),
	datab => \RegA|ALT_INV_DOUT\(1),
	datac => \RegA|ALT_INV_DOUT\(0),
	combout => \memoria1|memROM~1_combout\);

\memoria1|memROM~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \memoria1|memROM~2_combout\ = (\RegA|DOUT\(2) & (\RegA|DOUT\(1) & \RegA|DOUT\(0)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000010000000100000001000000010000000100000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \RegA|ALT_INV_DOUT\(2),
	datab => \RegA|ALT_INV_DOUT\(1),
	datac => \RegA|ALT_INV_DOUT\(0),
	combout => \memoria1|memROM~2_combout\);

ww_Pontos_de_Controle(0) <= \Pontos_de_Controle[0]~output_o\;

ww_Pontos_de_Controle(1) <= \Pontos_de_Controle[1]~output_o\;

ww_Pontos_de_Controle(2) <= \Pontos_de_Controle[2]~output_o\;

ww_Pontos_de_Controle(3) <= \Pontos_de_Controle[3]~output_o\;

ww_Pontos_de_Controle(4) <= \Pontos_de_Controle[4]~output_o\;

ww_Pontos_de_Controle(5) <= \Pontos_de_Controle[5]~output_o\;

ww_Pontos_de_Controle(6) <= \Pontos_de_Controle[6]~output_o\;

ww_Pontos_de_Controle(7) <= \Pontos_de_Controle[7]~output_o\;

ww_Pontos_de_Controle(8) <= \Pontos_de_Controle[8]~output_o\;

ww_Pontos_de_Controle(9) <= \Pontos_de_Controle[9]~output_o\;

ww_Pontos_de_Controle(10) <= \Pontos_de_Controle[10]~output_o\;

ww_Pontos_de_Controle(11) <= \Pontos_de_Controle[11]~output_o\;

ww_Pontos_de_Controle(12) <= \Pontos_de_Controle[12]~output_o\;

ww_Pontos_de_Controle(13) <= \Pontos_de_Controle[13]~output_o\;
END structure;


