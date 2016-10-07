LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY my_ff IS
GENERIC(
	input_length : INTEGER := 32
);
PORT (
	clk			: IN std_logic;
	rst			: IN std_logic;
	enable	: IN std_logic;
	input	: IN std_logic_vector(input_length-1 DOWNTO 0);
	output	: OUT std_logic_vector(input_length-1 DOWNTO 0)
);
END ENTITY my_ff;

ARCHITECTURE func OF my_ff IS
SIGNAL tmp 	: std_logic_vector(input_length-1 DOWNTO 0);
ALIAS slv IS std_logic_vector;
BEGIN
P1: PROCESS
	BEGIN
		WAIT UNTIL rising_edge(clk);
		IF rst = '1' THEN
			output <= (OTHERS => '0');
		ELSIF enable = '1' THEN
			output <= slv(input);
		END IF;
	END PROCESS P1;
END ARCHITECTURE func;