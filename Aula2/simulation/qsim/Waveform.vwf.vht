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
-- Generated on "08/26/2020 09:05:13"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          registradorGenerico
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY registradorGenerico_vhd_vec_tst IS
END registradorGenerico_vhd_vec_tst;
ARCHITECTURE registradorGenerico_arch OF registradorGenerico_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLK : STD_LOGIC;
SIGNAL DIN : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL DOUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL ENABLE : STD_LOGIC;
SIGNAL RST : STD_LOGIC;
COMPONENT registradorGenerico
	PORT (
	CLK : IN STD_LOGIC;
	DIN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	DOUT : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
	ENABLE : IN STD_LOGIC;
	RST : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : registradorGenerico
	PORT MAP (
-- list connections between master ports and signals
	CLK => CLK,
	DIN => DIN,
	DOUT => DOUT,
	ENABLE => ENABLE,
	RST => RST
	);

-- CLK
t_prcs_CLK: PROCESS
BEGIN
LOOP
	CLK <= '0';
	WAIT FOR 10000 ps;
	CLK <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_CLK;
-- DIN[7]
t_prcs_DIN_7: PROCESS
BEGIN
	DIN(7) <= '1';
	WAIT FOR 20000 ps;
	DIN(7) <= '0';
	WAIT FOR 20000 ps;
	DIN(7) <= '1';
	WAIT FOR 20000 ps;
	DIN(7) <= '0';
	WAIT FOR 40000 ps;
	DIN(7) <= '1';
	WAIT FOR 40000 ps;
	DIN(7) <= '0';
	WAIT FOR 20000 ps;
	DIN(7) <= '1';
	WAIT FOR 40000 ps;
	DIN(7) <= '0';
	WAIT FOR 40000 ps;
	DIN(7) <= '1';
	WAIT FOR 40000 ps;
	DIN(7) <= '0';
	WAIT FOR 20000 ps;
	DIN(7) <= '1';
	WAIT FOR 20000 ps;
	DIN(7) <= '0';
	WAIT FOR 60000 ps;
	DIN(7) <= '1';
	WAIT FOR 20000 ps;
	DIN(7) <= '0';
	WAIT FOR 40000 ps;
	DIN(7) <= '1';
	WAIT FOR 180000 ps;
	DIN(7) <= '0';
	WAIT FOR 40000 ps;
	DIN(7) <= '1';
	WAIT FOR 20000 ps;
	DIN(7) <= '0';
	WAIT FOR 80000 ps;
	DIN(7) <= '1';
	WAIT FOR 40000 ps;
	DIN(7) <= '0';
	WAIT FOR 20000 ps;
	DIN(7) <= '1';
	WAIT FOR 20000 ps;
	DIN(7) <= '0';
	WAIT FOR 20000 ps;
	DIN(7) <= '1';
	WAIT FOR 40000 ps;
	DIN(7) <= '0';
	WAIT FOR 20000 ps;
	DIN(7) <= '1';
	WAIT FOR 60000 ps;
	DIN(7) <= '0';
WAIT;
END PROCESS t_prcs_DIN_7;
-- DIN[6]
t_prcs_DIN_6: PROCESS
BEGIN
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
	WAIT FOR 40000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 40000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 80000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 60000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 40000 ps;
	DIN(6) <= '0';
	WAIT FOR 40000 ps;
	DIN(6) <= '1';
	WAIT FOR 40000 ps;
	DIN(6) <= '0';
	WAIT FOR 40000 ps;
	DIN(6) <= '1';
	WAIT FOR 40000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 40000 ps;
	DIN(6) <= '0';
	WAIT FOR 100000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 40000 ps;
	DIN(6) <= '0';
	WAIT FOR 20000 ps;
	DIN(6) <= '1';
	WAIT FOR 20000 ps;
	DIN(6) <= '0';
WAIT;
END PROCESS t_prcs_DIN_6;
-- DIN[5]
t_prcs_DIN_5: PROCESS
BEGIN
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
	WAIT FOR 40000 ps;
	DIN(5) <= '1';
	WAIT FOR 60000 ps;
	DIN(5) <= '0';
	WAIT FOR 60000 ps;
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
	WAIT FOR 20000 ps;
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
	WAIT FOR 20000 ps;
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
	WAIT FOR 60000 ps;
	DIN(5) <= '1';
	WAIT FOR 60000 ps;
	DIN(5) <= '0';
	WAIT FOR 60000 ps;
	DIN(5) <= '1';
	WAIT FOR 40000 ps;
	DIN(5) <= '0';
	WAIT FOR 80000 ps;
	DIN(5) <= '1';
	WAIT FOR 80000 ps;
	DIN(5) <= '0';
	WAIT FOR 20000 ps;
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
	WAIT FOR 20000 ps;
	DIN(5) <= '1';
	WAIT FOR 60000 ps;
	DIN(5) <= '0';
	WAIT FOR 80000 ps;
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
	WAIT FOR 40000 ps;
	DIN(5) <= '1';
	WAIT FOR 20000 ps;
	DIN(5) <= '0';
WAIT;
END PROCESS t_prcs_DIN_5;
-- DIN[4]
t_prcs_DIN_4: PROCESS
BEGIN
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 40000 ps;
	DIN(4) <= '1';
	WAIT FOR 40000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 80000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 40000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 60000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 20000 ps;
	DIN(4) <= '0';
	WAIT FOR 40000 ps;
	DIN(4) <= '1';
	WAIT FOR 80000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 60000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 80000 ps;
	DIN(4) <= '0';
	WAIT FOR 40000 ps;
	DIN(4) <= '1';
	WAIT FOR 60000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
	WAIT FOR 40000 ps;
	DIN(4) <= '0';
	WAIT FOR 20000 ps;
	DIN(4) <= '1';
WAIT;
END PROCESS t_prcs_DIN_4;
-- DIN[3]
t_prcs_DIN_3: PROCESS
BEGIN
	DIN(3) <= '0';
	WAIT FOR 20000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 20000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 20000 ps;
	DIN(3) <= '1';
	WAIT FOR 40000 ps;
	DIN(3) <= '0';
	WAIT FOR 20000 ps;
	DIN(3) <= '1';
	WAIT FOR 40000 ps;
	DIN(3) <= '0';
	WAIT FOR 40000 ps;
	DIN(3) <= '1';
	WAIT FOR 60000 ps;
	DIN(3) <= '0';
	WAIT FOR 60000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 20000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 40000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 40000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 20000 ps;
	DIN(3) <= '1';
	WAIT FOR 40000 ps;
	DIN(3) <= '0';
	WAIT FOR 40000 ps;
	DIN(3) <= '1';
	WAIT FOR 80000 ps;
	DIN(3) <= '0';
	WAIT FOR 40000 ps;
	DIN(3) <= '1';
	WAIT FOR 20000 ps;
	DIN(3) <= '0';
	WAIT FOR 40000 ps;
	DIN(3) <= '1';
	WAIT FOR 100000 ps;
	DIN(3) <= '0';
WAIT;
END PROCESS t_prcs_DIN_3;
-- DIN[2]
t_prcs_DIN_2: PROCESS
BEGIN
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 40000 ps;
	DIN(2) <= '1';
	WAIT FOR 100000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 40000 ps;
	DIN(2) <= '0';
	WAIT FOR 80000 ps;
	DIN(2) <= '1';
	WAIT FOR 40000 ps;
	DIN(2) <= '0';
	WAIT FOR 40000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 40000 ps;
	DIN(2) <= '0';
	WAIT FOR 40000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 40000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 60000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
	WAIT FOR 20000 ps;
	DIN(2) <= '1';
	WAIT FOR 20000 ps;
	DIN(2) <= '0';
WAIT;
END PROCESS t_prcs_DIN_2;
-- DIN[1]
t_prcs_DIN_1: PROCESS
BEGIN
	DIN(1) <= '1';
	WAIT FOR 40000 ps;
	DIN(1) <= '0';
	WAIT FOR 100000 ps;
	DIN(1) <= '1';
	WAIT FOR 40000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 80000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 20000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 40000 ps;
	DIN(1) <= '0';
	WAIT FOR 60000 ps;
	DIN(1) <= '1';
	WAIT FOR 20000 ps;
	DIN(1) <= '0';
	WAIT FOR 60000 ps;
	DIN(1) <= '1';
	WAIT FOR 20000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 20000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 140000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 20000 ps;
	DIN(1) <= '0';
	WAIT FOR 20000 ps;
	DIN(1) <= '1';
	WAIT FOR 80000 ps;
	DIN(1) <= '0';
	WAIT FOR 80000 ps;
	DIN(1) <= '1';
WAIT;
END PROCESS t_prcs_DIN_1;
-- DIN[0]
t_prcs_DIN_0: PROCESS
BEGIN
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 40000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 40000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 40000 ps;
	DIN(0) <= '1';
	WAIT FOR 60000 ps;
	DIN(0) <= '0';
	WAIT FOR 20000 ps;
	DIN(0) <= '1';
	WAIT FOR 60000 ps;
	DIN(0) <= '0';
	WAIT FOR 20000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 40000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 100000 ps;
	DIN(0) <= '1';
	WAIT FOR 40000 ps;
	DIN(0) <= '0';
	WAIT FOR 60000 ps;
	DIN(0) <= '1';
	WAIT FOR 60000 ps;
	DIN(0) <= '0';
	WAIT FOR 20000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 40000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 40000 ps;
	DIN(0) <= '1';
	WAIT FOR 80000 ps;
	DIN(0) <= '0';
	WAIT FOR 20000 ps;
	DIN(0) <= '1';
	WAIT FOR 20000 ps;
	DIN(0) <= '0';
	WAIT FOR 20000 ps;
	DIN(0) <= '1';
WAIT;
END PROCESS t_prcs_DIN_0;

-- ENABLE
t_prcs_ENABLE: PROCESS
BEGIN
	FOR i IN 1 TO 16
	LOOP
		ENABLE <= '0';
		WAIT FOR 30000 ps;
		ENABLE <= '1';
		WAIT FOR 30000 ps;
	END LOOP;
	ENABLE <= '0';
	WAIT FOR 30000 ps;
	ENABLE <= '1';
WAIT;
END PROCESS t_prcs_ENABLE;

-- RST
t_prcs_RST: PROCESS
BEGIN
	FOR i IN 1 TO 12
	LOOP
		RST <= '0';
		WAIT FOR 40000 ps;
		RST <= '1';
		WAIT FOR 40000 ps;
	END LOOP;
	RST <= '0';
WAIT;
END PROCESS t_prcs_RST;
END registradorGenerico_arch;
