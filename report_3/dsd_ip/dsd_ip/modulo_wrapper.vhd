library ieee;
use work.modulo;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity modulo_wrapper is
port(
norm: in std_logic_vector(31 downto 0);
denorm: in std_logic_vector(31 downto 0);
result: out std_logic_vector(31 downto 0);
mode: in std_logic;
clk:in std_logic
);
end entity modulo_wrapper;

architecture main of modulo_wrapper is
signal q:std_logic_vector(31 downto 0);
signal r:std_logic_vector(31 downto 0);
begin
M1:entity modulo port map(		
		clock	=>clk,
		denom	=>denorm,
		numer	=>norm,
		quotient=>q,
		remain=>r
		);
S1:process(mode,q,r)begin
if mode = '1' then
result<=q;
else
result<=r;
end if;
end process S1;
end architecture;
