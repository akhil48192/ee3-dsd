library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity lsr34 is
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		enable		: IN STD_LOGIC ;
		shiftin		: IN STD_LOGIC ;
		shiftout		: OUT STD_LOGIC 
	);
end entity lsr34;

architecture main of lsr34 is
signal out_32:std_logic;
begin
sft1:entity lsr32 port map(
aclr,clock,enable,shiftin,out_32
);
sft2:entity lsr2 port map(
aclr,clock,enable,out_32,shiftout);

end architecture main;