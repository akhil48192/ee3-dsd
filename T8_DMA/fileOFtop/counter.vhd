library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port(
init_data: std_logic_vector(31 downto 0);
clk:in std_logic;
reset:in std_logic;
enable: in std_logic;
is_zero: out std_logic
);
end entity counter;


architecture main of counter is
signal count:std_logic_vector(31 downto 0);
begin
R1: process (clk,reset,init_data)begin
if reset = '1' then
	count<=std_logic_vector((unsigned(init_data) srl 2)-1);
else
if clk'event and clk='1'then
	if unsigned(count)/=0 then
		if enable ='1' then 
			count<=std_logic_vector(unsigned(count)-1);
		end if; 
	else
		if enable ='1' then 
			count<=(others=>'0');--std_logic_vector((unsigned(init_data) srl 2)-1);
		end if; 
	end if;
end if;
end if;
end process R1;

C1: process(count) begin
if to_integer(unsigned(count))=0 then
is_zero<='1';
else
is_zero<='0';
end if;
end process C1;

end architecture main;