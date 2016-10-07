library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg_en is 
port(
reset:in std_logic;
clk: in std_logic; 
enable: in std_logic;
d_in: in std_logic_vector(31 downto 0);
d_out: out std_logic_vector(31 downto 0)
);
end entity;

architecture main of reg_en is
begin
R1:process begin
wait until clk'event and clk='1';
if reset ='1' then
d_out<=(others=>'0');
else
if enable ='1' then
d_out<=d_in;
end if;
end if;
end process R1;
end architecture main;

