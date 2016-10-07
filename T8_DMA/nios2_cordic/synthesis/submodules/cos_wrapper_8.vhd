library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity cos_wrapper_8 is 
port(
clk: in std_logic; 
float_in: in std_logic_vector(31 downto 0);
float_out: out std_logic_vector(31 downto 0);
clk_en:in std_logic
);
end entity;

architecture main of cos_wrapper_8 is
signal fx_in:std_logic_vector(31 downto 0);
signal fx_out:std_logic_vector(31 downto 0);
begin
R1: entity cos_rom port map(float_in,fx_in);
C1: entity cosine_8 port map(clk,fx_in,fx_out,clk_en);
C2: entity fx2fp port map(clk,fx_out,float_out);
end architecture main;

