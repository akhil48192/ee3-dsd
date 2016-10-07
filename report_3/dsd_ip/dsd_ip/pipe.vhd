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
-- CREATED		"Mon Mar 07 20:33:11 2016"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY pipe IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		counter_enable :  IN  STD_LOGIC;
		x :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		o :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END pipe;

ARCHITECTURE bdf_type OF pipe IS 

COMPONENT dsd_altfp_add
	PORT(clock : IN STD_LOGIC;
		 clk_en : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cos_wrapper
	PORT(clk : IN STD_LOGIC;
		 float_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 float_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT div2
	PORT(x : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 half_x : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT my_ff
GENERIC (input_length : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dsd_fifo
	PORT(wrreq : IN STD_LOGIC;
		 rdreq : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 sclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 full : OUT STD_LOGIC;
		 empty : OUT STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT shift_reg
GENERIC (shift_length : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 input : IN STD_LOGIC;
		 output : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT dsd_altfp_mult
	PORT(clk_en : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	accum_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	add_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	always_1 :  STD_LOGIC;
SIGNAL	cordic_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	div2_rdreq :  STD_LOGIC;
SIGNAL	div2_wrreq :  STD_LOGIC;
SIGNAL	ff1_enable :  STD_LOGIC;
SIGNAL	ff1_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ff2_enable :  STD_LOGIC;
SIGNAL	ff2_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	fifo_div2_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	fifo_x_sq_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	mult_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	x_div2_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	x_sq :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	x_sq_rdreq :  STD_LOGIC;
SIGNAL	x_sq_wrreq :  STD_LOGIC;


BEGIN 



b2v_accum : dsd_altfp_add
PORT MAP(clock => clk,
		 clk_en => always_1,
		 aclr => rst,
		 dataa => ff1_out,
		 datab => ff2_out,
		 result => accum_out);


b2v_add : dsd_altfp_add
PORT MAP(clock => clk,
		 clk_en => always_1,
		 aclr => rst,
		 dataa => mult_out,
		 datab => fifo_div2_out,
		 result => add_out);


b2v_cordic : cos_wrapper
PORT MAP(clk => clk,
		 float_in => x,
		 float_out => cordic_out);


b2v_div2 : div2
PORT MAP(x => x,
		 half_x => x_div2_out);


b2v_ff1 : my_ff
GENERIC MAP(input_length => 32
			)
PORT MAP(clk => clk,
		 rst => rst,
		 enable => ff1_enable,
		 input => add_out,
		 output => ff1_out);


b2v_ff2 : my_ff
GENERIC MAP(input_length => 32
			)
PORT MAP(clk => clk,
		 rst => rst,
		 enable => ff2_enable,
		 input => accum_out,
		 output => ff2_out);


b2v_fifo_div2 : dsd_fifo
PORT MAP(wrreq => div2_wrreq,
		 rdreq => div2_rdreq,
		 clock => clk,
		 sclr => rst,
		 data => x_div2_out,
		 q => fifo_div2_out);


b2v_fifo_x_sq : dsd_fifo
PORT MAP(wrreq => x_sq_wrreq,
		 rdreq => x_sq_rdreq,
		 clock => clk,
		 sclr => rst,
		 data => x_sq,
		 q => fifo_x_sq_out);



b2v_shift_reg_adder : shift_reg
GENERIC MAP(shift_length => 54
			)
PORT MAP(clk => clk,
		 input => div2_wrreq,
		 output => ff1_enable);


b2v_shift_reg_adder_2 : shift_reg
GENERIC MAP(shift_length => 7
			)
PORT MAP(clk => clk,
		 input => ff1_enable,
		 output => ff2_enable);


b2v_shift_reg_cosine : shift_reg
GENERIC MAP(shift_length => 16
			)
PORT MAP(clk => clk,
		 input => div2_wrreq,
		 output => x_sq_rdreq);


b2v_shift_reg_div2 : shift_reg
GENERIC MAP(shift_length => 46
			)
PORT MAP(clk => clk,
		 input => div2_wrreq,
		 output => div2_rdreq);


b2v_shift_reg_sq : shift_reg
GENERIC MAP(shift_length => 11
			)
PORT MAP(clk => clk,
		 input => div2_wrreq,
		 output => x_sq_wrreq);


b2v_x_sq_cos : dsd_altfp_mult
PORT MAP(clk_en => always_1,
		 clock => clk,
		 aclr => rst,
		 dataa => fifo_x_sq_out,
		 datab => cordic_out,
		 result => mult_out);


b2v_x_squared : dsd_altfp_mult
PORT MAP(clk_en => always_1,
		 clock => clk,
		 aclr => rst,
		 dataa => x,
		 datab => x,
		 result => x_sq);

o <= ff2_out;
div2_wrreq <= counter_enable;

always_1 <= '1';
END bdf_type;