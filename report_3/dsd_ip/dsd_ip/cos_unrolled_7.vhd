library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.slv_shift.all;
-- word length is 32 and fractional bit is 28 bit
entity cosine_7 is
	port(
		clk    : in  std_logic;
		radian : in  std_logic_vector(31 downto 0);
		result : out std_logic_vector(31 downto 0)
	);

end entity;
architecture main of cosine_7 is
	subtype fixpt is std_logic_vector( 31 downto 0); 
	type pipe is array (0 to 27) of fixpt;
	type table_t is array (0 to 27) of fixpt;
	alias slv is std_logic_vector;
	constant PI    : fixpt := "00110010010000111111011010101001";
	constant PIx2  : fixpt := "01100100100001111110110101010001";
	constant PIdiv2: fixpt := "00011001001000011111101101010100";
	constant x_init: fixpt := "00001001101101110100111011011011";
	constant table : table_t   := (
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
		if z(0)(31)='1' then
				z(1) <= slv(signed(z(0)) + signed(table(0)));
				x(1) <= slv(signed(x(0)) + signed(asr(y(0),0)));
				y(1) <= slv(signed(y(0)) - signed(asr(x(0),0)));
			else
				z(1) <= slv(signed(z(0)) - signed(table(0)));
				x(1) <= slv(signed(x(0)) - signed(asr(y(0),0)));
				y(1) <= slv(signed(y(0)) + signed(asr(x(0),0)));
			end if;
		if z(1)(31)='1' then
				z(2) <= slv(signed(z(1)) + signed(table(1)));
				x(2) <= slv(signed(x(1)) + signed(asr(y(1),1)));
				y(2) <= slv(signed(y(1)) - signed(asr(x(1),1)));
			else
				z(2) <= slv(signed(z(1)) - signed(table(1)));
				x(2) <= slv(signed(x(1)) - signed(asr(y(1),1)));
				y(2) <= slv(signed(y(1)) + signed(asr(x(1),1)));
			end if;
		if z(2)(31)='1' then
				z(3) <= slv(signed(z(2)) + signed(table(2)));
				x(3) <= slv(signed(x(2)) + signed(asr(y(2),2)));
				y(3) <= slv(signed(y(2)) - signed(asr(x(2),2)));
			else
				z(3) <= slv(signed(z(2)) - signed(table(2)));
				x(3) <= slv(signed(x(2)) - signed(asr(y(2),2)));
				y(3) <= slv(signed(y(2)) + signed(asr(x(2),2)));
			end if;	
		for index in 1 to 6 loop
			if z(index*4-1)(31)='1' then
					z(index*4) <= slv(signed(z(index*4-1)) + signed(table(index*4-1)));
					x(index*4) <= slv(signed(x(index*4-1)) + signed(asr(y(index*4-1),index*4-1)));
					y(index*4) <= slv(signed(y(index*4-1)) - signed(asr(x(index*4-1),index*4-1)));
				else
					z(index*4) <= slv(signed(z(index*4-1)) - signed(table(index*4-1)));
					x(index*4) <= slv(signed(x(index*4-1)) - signed(asr(y(index*4-1),index*4-1)));
					y(index*4) <= slv(signed(y(index*4-1)) + signed(asr(x(index*4-1),index*4-1)));
				end if;
			if z(index*4)(31)='1' then
					z(index*4+1) <= slv(signed(z(index*4)) + signed(table(index*4)));
					x(index*4+1) <= slv(signed(x(index*4)) + signed(asr(y(index*4),index*4)));
					y(index*4+1) <= slv(signed(y(index*4)) - signed(asr(x(index*4),index*4)));
				else                                    
					z(index*4+1) <= slv(signed(z(index*4)) - signed(table(index*4)));
					x(index*4+1) <= slv(signed(x(index*4)) - signed(asr(y(index*4),index*4)));
					y(index*4+1) <= slv(signed(y(index*4)) + signed(asr(x(index*4),index*4)));
				end if;
			if z(index*4+1)(31)='1' then
					z(index*4+2) <= slv(signed(z(index*4+1)) + signed(table(index*4+1)));
					x(index*4+2) <= slv(signed(x(index*4+1)) + signed(asr(y(index*4+1),index*4+1)));
					y(index*4+2) <= slv(signed(y(index*4+1)) - signed(asr(x(index*4+1),index*4+1)));
				else
					z(index*4+2) <= slv(signed(z(index*4+1)) - signed(table(index*4+1)));
					x(index*4+2) <= slv(signed(x(index*4+1)) - signed(asr(y(index*4+1),index*4+1)));
					y(index*4+2) <= slv(signed(y(index*4+1)) + signed(asr(x(index*4+1),index*4+1)));
				end if;
			if z(index*4+2)(31)='1' then
					z(index*4+3) <= slv(signed(z(index*4+2)) + signed(table(index*4+2)));
					x(index*4+3) <= slv(signed(x(index*4+2)) + signed(asr(y(index*4+2),index*4+2)));
					y(index*4+3) <= slv(signed(y(index*4+2)) - signed(asr(x(index*4+2),index*4+2)));
				else
					z(index*4+3)<= slv(signed(z(index*4+2)) - signed(table(index*4+2)));
					x(index*4+3)<= slv(signed(x(index*4+2)) - signed(asr(y(index*4+2),index*4+2)));
					y(index*4+3)<= slv(signed(y(index*4+2)) + signed(asr(x(index*4+2),index*4+2)));
				end if;		
		end loop;
	end process iteration;

	result <= x(27);
end architecture main;