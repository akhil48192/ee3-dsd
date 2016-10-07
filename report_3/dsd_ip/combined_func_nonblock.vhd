library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity combined_func_nonblock is 
port(
clk:in std_logic;
x:in std_logic_vector(31 downto 0);
result: out std_logic_vector(31 downto 0);
);
end entity combined_func_nonblock;

architecture main of combined_func_nonblock is
signal exponent: std_logic_vector(7 downto 0);
signal half_x:std_logic_vector(31 downto 0);
signal cos_out:std_logic_vector(31 downto 0);
signal sq_out:std_logic_vector(31 downto 0);
signal mult_out:std_logic_vector(31 downto 0);
begin
sub_exponent: process (x) begin
exponent<=std_logic_vector(signed(x(30 downto 23))-1);
end process sub_exponent;

div2: process(exponent,x) begin
if to_integer(signed(x))= 0 then
half_x<=(others=>'0');
else
half_x<=x(31)&exponent&x(22 downto 0);
end if;
end process div2;

cosine_blk: entity cos_wrapper port map(
clk,
x,
cos_out
);

sq_block: ENTITY DSD_ALTFP_MULT PORT map
(
clk,
x,
x,
sq_out
);

mult_block: ENTITY DSD_ALTFP_MULT PORT map
(
clk,
sq_out,
cos_out,
mult_out
);

adder_block: ENTITY DSD_ALTFP_ADD PORT map
(
clk,
mult_out,
half_x,
result
);


end architecture main;