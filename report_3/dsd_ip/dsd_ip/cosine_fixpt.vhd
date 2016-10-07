library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.slv_shift.all;
-- word length is 32 and fractional bit is 28 bit
entity cosine is
	port(
		clk    : in  std_logic;
		radian : in  std_logic_vector(31 downto 0);
		result : out std_logic_vector(31 downto 0)
	);

end entity;
architecture main of cosine is
	subtype fixpt is std_logic_vector( 31 downto 0); 
	type pipe is array (0 to 27) of fixpt;
	type D_type is array (0 to 27) of std_logic;
	type int_array is array (1 to 26) of integer;
	alias slv is std_logic_vector;
	constant PI    : fixpt := "00110010010000111111011010101001";
	constant PIx2  : fixpt := "01100100100001111110110101010001";
	constant PIdiv2: fixpt := "00011001001000011111101101010100";
	constant x_init: fixpt := "00001001101101110100111011011011";
	constant table : pipe   := (
		"00001100100100001111110110101010",
		"00000111011010110001100111000001",
		"00000011111010110110111010111111",
		"00000001111111010101101110101010",
		"00000000111111111010101011011110",
		"00000000011111111111010101010111",
		"00000000001111111111111010101011",
		"00000000000111111111111111010101",
		"00000000000011111111111111111011",
		"00000000000001111111111111111111",
		"00000000000001000000000000000000",
		"00000000000000100000000000000000",
		"00000000000000010000000000000000",
		"00000000000000001000000000000000",
		"00000000000000000100000000000000",
		"00000000000000000010000000000000",
		"00000000000000000001000000000000",
		"00000000000000000000100000000000",
		"00000000000000000000010000000000",
		"00000000000000000000001000000000",
		"00000000000000000000000100000000",
		"00000000000000000000000010000000",
		"00000000000000000000000001000000",
		"00000000000000000000000000100000",
		"00000000000000000000000000010000",
		"00000000000000000000000000001000",
		"00000000000000000000000000000100",
		"00000000000000000000000000000010"
	);
	signal x, y, z: pipe;
	signal d       : D_type;
	signal tmp : fixpt;
	

	
	
begin
	absolute : process(radian)
	begin
	if radian(31)='0' then
		if signed(radian) > signed(PI) then
			tmp <= slv(signed(radian)-signed(PIx2));
		else 
			tmp<= radian;
		end if;
	else
		if signed(radian) < -signed(PI) then
			tmp <= slv(signed(radian)+signed(PIx2));
		else 
			tmp<= radian;
		end if;
	end if;
	end process absolute;

	iteration : process
	begin
		wait until rising_edge(clk);
		if ( signed(tmp) > signed(PIdiv2) ) AND (signed(tmp)<signed(PI)) then
			x(0) <= (others=>'0');
			y(0) <= x_init;
			z(0) <= slv(signed(tmp)-signed(PIdiv2));
		elsif (signed(tmp) < -signed(PIdiv2)) and (signed(tmp) > -signed(PI)) then
			x(0) <= (others=>'0');
			y(0) <= slv(-signed(x_init));
			z(0) <= slv(signed(tmp)+signed(PIdiv2));
		else
			x(0) <= x_init;
			y(0) <= (others=>'0');
			z(0) <= tmp;
		end if;
		for index in 1 to 16 loop
			if z(index-1)(31)='1' then
				z(index) <= slv(signed(z(index - 1)) + signed(table(index-1)));
				x(index) <= slv(signed(x(index - 1)) + signed(asr(y(index-1),index-1)));
				y(index) <= slv(signed(y(index - 1)) - signed(asr(x(index-1),index-1)));
			else
				z(index) <= slv(signed(z(index - 1)) - signed(table(index-1)));
				x(index) <= slv(signed(x(index - 1)) - signed(asr(y(index-1),index-1)));
				y(index) <= slv(signed(y(index - 1)) + signed(asr(x(index-1),index-1)));
			end if;
		end loop;
	end process iteration;

	result <= x(16);
end architecture main;