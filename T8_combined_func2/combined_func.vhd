library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all; 

entity combined_func2 is
	port(
		clk    : in  std_logic;
		x      : in  std_logic_vector(31 downto 0);
		last_result: std_logic_vector(31 downto 0);
		result : out std_logic_vector(31 downto 0);
		clk_en : in std_logic
	);
end entity combined_func2;

architecture main of combined_func2 is
	signal exponent : std_logic_vector(7 downto 0);
	signal half_x   : std_logic_vector(31 downto 0);
	signal cos_out  : std_logic_vector(31 downto 0);
	signal sq_out   : std_logic_vector(31 downto 0);
	signal mult_out : std_logic_vector(31 downto 0);
	signal add_out : std_logic_vector(31 downto 0);
begin
	sub_exponent : process(x)
	begin
		exponent <= std_logic_vector(signed(x(30 downto 23)) - 1);
	end process sub_exponent;

	div2 : process(exponent, x)
	begin
		if to_integer(signed(x)) = 0 then
			half_x <= (others => '0');
		else
			half_x <= x(31) & exponent & x(22 downto 0);
		end if;
	end process div2;

	cosine_blk : entity cos_wrapper_8 port map(
			clk,
			x,
			cos_out,
			clk_en
		);

	sq_block : ENTITY fpmul PORT map(
			clk_en,
			clk,
			x,
			x,
			sq_out
		);

	mult_block : ENTITY fpmul PORT map(
			clk_en,
			clk,
			sq_out,
			cos_out,
			mult_out
		);

	adder_block1 : ENTITY fpadd PORT map(
			clk_en,
			clk,
			mult_out,
			half_x,
			add_out
		);
	adder_block2 : ENTITY fpadd PORT map(
			clk_en,
			clk,
			add_out,
			last_result,
			result
		);

end architecture main;