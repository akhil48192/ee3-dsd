library ieee;
use ieee.std_logic_1164.all;

ENTITY my_lsb IS
PORT (
	input : IN std_logic_vector(31 DOWNTO 0);
	output : OUT std_logic
	);
END ENTITY my_lsb;

ARCHITECTURE a OF my_lsb IS
BEGIN
P1: PROCESS IS BEGIN
	output <= input(0);
END PROCESS P1;
END ARCHITECTURE a;
