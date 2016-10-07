LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY div2 IS
PORT(
	x		: IN std_logic_vector(31 DOWNTO 0);
	half_x	: OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY div2; 

ARCHITECTURE main OF div2 IS
SIGNAL exponent	: std_logic_vector(7 DOWNTO 0);

begin
sub_exponent: process (x) begin
exponent<=std_logic_vector(signed(x(30 downto 23))-1);
end process sub_exponent;

p1: process(exponent,x) begin
if to_integer(signed(x))= 0 then
half_x<=(others=>'0');
else
half_x<=x(31)&exponent&x(22 downto 0);
end if;
end process p1;

END ARCHITECTURE main;