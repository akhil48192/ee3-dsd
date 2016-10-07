LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;               -- add unsigned, signed
USE work.ALL;
LIBRARY lpm;
USE lpm.all;

ENTITY DSD_LPM_MULT_wrapper IS
	PORT(
		a : IN  std_logic_vector(31 DOWNTO 0);
		b : IN  std_logic_vector(31 DOWNTO 0);
		c : OUT std_logic_vector(31 DOWNTO 0)
	);
END ENTITY DSD_LPM_MULT_wrapper;

ARCHITECTURE add OF DSD_LPM_MULT_wrapper IS
	SIGNAL mult_out : std_logic_vector(63 DOWNTO 0);
BEGIN
	D1 : ENTITY DSD_LPM_MULT
		PORT MAP(
			dataa  => a,
			datab  => b,
			result => mult_out
		);
	c <= mult_out(31 DOWNTO 0);
END ARCHITECTURE add;

