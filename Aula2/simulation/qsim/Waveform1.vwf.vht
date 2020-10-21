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

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "09/02/2020 08:46:46"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          MEF
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY MEF_vhd_vec_tst IS
END MEF_vhd_vec_tst;
ARCHITECTURE MEF_arch OF MEF_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLK : STD_LOGIC;
SIGNAL Pontos_de_Controle : STD_LOGIC_VECTOR(13 DOWNTO 0);
COMPONENT MEF
	PORT (
	CLK : IN STD_LOGIC;
	Pontos_de_Controle : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : MEF
	PORT MAP (
-- list connections between master ports and signals
	CLK => CLK,
	Pontos_de_Controle => Pontos_de_Controle
	);
END MEF_arch;
