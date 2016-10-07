LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;               -- add unsigned, signed
USE work.ALL;

ENTITY DSD_ALTFP_MULT_wrapper IS
	PORT(
		clk : IN std_logic;
		a : IN  std_logic_vector(31 DOWNTO 0);
		b : IN  std_logic_vector(31 DOWNTO 0);
		c : OUT std_logic_vector(31 DOWNTO 0)
	);
END ENTITY DSD_ALTFP_MULT_wrapper;

ARCHITECTURE mul OF DSD_ALTFP_MULT_wrapper IS

BEGIN
	D1 : ENTITY DSD_ALTFP_MULT
		PORT MAP(
			clock => clk,
			dataa  => a,
			datab  => b,
			result => c
		);
	
END ARCHITECTURE mul;
