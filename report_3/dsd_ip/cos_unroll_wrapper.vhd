library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity cos14_wrapper is 
port(
clk: in std_logic;
float_in: in std_logic_vector(31 downto 0);
float_out: out std_logic_vector(31 downto 0)
);
end entity;

architecture main of cos14_wrapper is
signal fx_in:std_logic_vector(31 downto 0);
signal fx_out:std_logic_vector(31 downto 0);
begin
R1: entity cos_rom port map(float_in,fx_in);
C1: entity cosine_14 port map(clk,fx_in,fx_out);
C2: entity fx2fp port map(clk,fx_out,float_out);
end architecture main;

