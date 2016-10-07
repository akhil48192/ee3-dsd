LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY counter_add IS
PORT (
	clk			: IN std_logic;
	reset	: IN std_logic;
	output_enable	: OUT std_logic;
	output_enable_not	: OUT std_logic
);
END ENTITY counter_add;

ARCHITECTURE func OF counter_add IS
SIGNAL tmp	: std_logic_vector(7 DOWNTO 0);
CONSTANT max : std_logic_vector(7 DOWNTO 0) := "10001000";
--CONSTANT max : std_logic_vector(7 DOWNTO 0) := "00001000";

ALIAS slv IS std_logic_vector;
ALIAS usgn IS unsigned;

BEGIN
P1: PROCESS
BEGIN
	WAIT UNTIL rising_edge(clk);
	IF reset = '1' THEN
		tmp <= slv(max);
	ELSE 
		IF (usgn(tmp) /= 0) THEN
			tmp <= slv(usgn(tmp) - 1);
		ELSE NULL;
		END IF;
	END IF;
END PROCESS P1;

P2: PROCESS(tmp)
BEGIN
	IF (usgn(tmp) = 0) THEN
		output_enable <= '1';
		output_enable_not <= '0';
	ELSE 
		output_enable <= '0';
		output_enable_not <= '1';
	END IF;
END PROCESS P2;


END ARCHITECTURE func;