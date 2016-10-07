library ieee;
use ieee.std_logic_1164.all;
use work.slv_shift.all;
use ieee.numeric_std.all;
entity floor_div_4_sub_32 is
port(
din: in std_logic_vector(31 downto 0);
dout: out std_logic_vector(31 downto 0)
);
end entity floor_div_4_sub_32;

architecture main of floor_div_4_sub_32 is
begin
c1: process(din) begin
dout<=std_logic_vector(signed(asr(din,2))-32);
end process c1;
end architecture main;