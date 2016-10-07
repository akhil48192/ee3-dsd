-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"
-- CREATED		"Mon Mar 14 14:41:11 2016"

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY hello_world IS
	PORT(
		iCLK_50     : IN    STD_LOGIC;
		DRAM_DQ     : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		oDRAM_CAS_N : OUT   STD_LOGIC;
		oDRAM_CKE   : OUT   STD_LOGIC;
		oDRAM_CS_N  : OUT   STD_LOGIC;
		oDRAM_RAS_N : OUT   STD_LOGIC;
		oDRAM_WE_N  : OUT   STD_LOGIC;
		oDRAM_CLK   : OUT   STD_LOGIC;
		oDRAM_A     : OUT   STD_LOGIC_VECTOR(11 DOWNTO 0);
		oDRAM_BA    : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);
		oDRAM_DQM   : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);
		oLEDG       : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END hello_world;

ARCHITECTURE bdf_type OF hello_world IS
	COMPONENT nios2_cordic
		PORT(clk_clk          : IN    STD_LOGIC;
			 reset_reset_n    : IN    STD_LOGIC;
			 sdram_wire_dq    : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			 sdram_wire_cas_n : OUT   STD_LOGIC;
			 sdram_wire_cke   : OUT   STD_LOGIC;
			 sdram_wire_cs_n  : OUT   STD_LOGIC;
			 sdram_wire_ras_n : OUT   STD_LOGIC;
			 sdram_wire_we_n  : OUT   STD_LOGIC;
			 altpll_c1_clk    : OUT   STD_LOGIC;
			 sdram_wire_addr  : OUT   STD_LOGIC_VECTOR(11 DOWNTO 0);
			 sdram_wire_ba    : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);
			 sdram_wire_dqm   : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL SYNTHESIZED_WIRE_0 : STD_LOGIC;

BEGIN
	SYNTHESIZED_WIRE_0 <= '1';

	b2v_inst : nios2_cordic
		PORT MAP(clk_clk          => iCLK_50,
			     reset_reset_n    => SYNTHESIZED_WIRE_0,
			     sdram_wire_dq    => DRAM_DQ,
			     sdram_wire_cas_n => oDRAM_CAS_N,
			     sdram_wire_cke   => oDRAM_CKE,
			     sdram_wire_cs_n  => oDRAM_CS_N,
			     sdram_wire_ras_n => oDRAM_RAS_N,
			     sdram_wire_we_n  => oDRAM_WE_N,
			     altpll_c1_clk    => oDRAM_CLK,
			     sdram_wire_addr  => oDRAM_A,
			     sdram_wire_ba    => oDRAM_BA,
			     sdram_wire_dqm   => oDRAM_DQM);

END bdf_type;