library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cos_rom is  
port(
x: in std_logic_vector(31 downto 0);
fx_out:out std_logic_vector(31 downto 0)
);
end entity cos_rom;

architecture main of cos_rom is
type rom_t is array (0 to 63) of std_logic_vector(31 downto 0);
type thres_t is array (0 to 62) of std_logic_vector(31 downto 0);
constant rom : rom_t:=(
"11110110101001111010001010010101",
"10100010000111111011010101000100",
"10110010000111111011010101000100",
"11000010000111111011010101000100",
"11010010000111111011010101000100",
"11100010000111111011010101000100",
"11110010000111111011010101000100",
"10011101100101111100011111110011",
"10101101100101111100011111110011",
"10111101100101111100011111110011",
"11001101100101111100011111110011",
"11011101100101111100011111110011",
"11101101100101111100011111110011",
"11111101100101111100011111110011",
"10101001000011111101101010100010",
"10111001000011111101101010100010",
"11001001000011111101101010100010",
"11011001000011111101101010100010",
"11101001000011111101101010100010",
"11111001000011111101101010100010",
"10100100100001111110110101010001",
"10110100100001111110110101010001",
"11000100100001111110110101010001",
"11010100100001111110110101010001",
"11100100100001111110110101010001",
"11110100100001111110110101010001",
"10100000000000000000000000000000",
"10110000000000000000000000000000",
"11000000000000000000000000000000",
"11010000000000000000000000000000",
"11100000000000000000000000000000",
"11110000000000000000000000000000",
"00000000000000000000000000000000",
"00010000000000000000000000000000",
"00100000000000000000000000000000",
"00110000000000000000000000000000",
"01000000000000000000000000000000",
"01010000000000000000000000000000",
"01100000000000000000000000000000",
"00001011011110000001001010101111",
"00011011011110000001001010101111",
"00101011011110000001001010101111",
"00111011011110000001001010101111",
"01001011011110000001001010101111",
"01011011011110000001001010101111",
"00000110111100000010010101011110",
"00010110111100000010010101011110",
"00100110111100000010010101011110",
"00110110111100000010010101011110",
"01000110111100000010010101011110",
"01010110111100000010010101011110",
"00000010011010000011100000001101",
"00010010011010000011100000001101",
"00100010011010000011100000001101",
"00110010011010000011100000001101",
"01000010011010000011100000001101",
"01010010011010000011100000001101",
"01100010011010000011100000001101",
"00001101111000000100101010111100",
"00011101111000000100101010111100",
"00101101111000000100101010111100",
"00111101111000000100101010111100",
"01001101111000000100101010111100",
"01011101111000000100101010111100"
);
constant thres : thres_t:=(
X"40800000",
X"41000000",
X"41400000",
X"41800000",
X"41a00000",
X"41c00000",
X"41e00000",
X"42000000",
X"42100000",
X"42200000",
X"42300000",
X"42400000",
X"42500000",
X"42600000",
X"42700000",
X"42800000",
X"42880000",
X"42900000",
X"42980000",
X"42a00000",
X"42a80000",
X"42b00000",
X"42b80000",
X"42c00000",
X"42c80000",
X"42d00000",
X"42d80000",
X"42e00000",
X"42e80000",
X"42f00000",
X"42f80000",
X"43000000",
X"43040000",
X"43080000",
X"430c0000",
X"43100000",
X"43140000",
X"43180000",
X"431c0000",
X"43200000",
X"43240000",
X"43280000",
X"432c0000",
X"43300000",
X"43340000",
X"43380000",
X"433c0000",
X"43400000",
X"43440000",
X"43480000",
X"434c0000",
X"43500000",
X"43540000",
X"43580000",
X"435c0000",
X"43600000",
X"43640000",
X"43680000",
X"436c0000",
X"43700000",
X"43740000",
X"43780000",
X"437c0000"
);
begin
C1:process(x) begin
if  signed(x)   	<   signed(thres(   0   ))  	THEN    fx_out <=   std_logic_vector(rom(   0   ));
elsif   signed(x)   <   signed(thres(   1   ))  THEN    fx_out <=   std_logic_vector(rom(   1   ));
elsif   signed(x)   <   signed(thres(   2   ))  THEN    fx_out <=   std_logic_vector(rom(   2   ));
elsif   signed(x)   <   signed(thres(   3   ))  THEN    fx_out <=   std_logic_vector(rom(   3   ));
elsif   signed(x)   <   signed(thres(   4   ))  THEN    fx_out <=   std_logic_vector(rom(   4   ));
elsif   signed(x)   <   signed(thres(   5   ))  THEN    fx_out <=   std_logic_vector(rom(   5   ));
elsif   signed(x)   <   signed(thres(   6   ))  THEN    fx_out <=   std_logic_vector(rom(   6   ));
elsif   signed(x)   <   signed(thres(   7   ))  THEN    fx_out <=   std_logic_vector(rom(   7   ));
elsif   signed(x)   <   signed(thres(   8   ))  THEN    fx_out <=   std_logic_vector(rom(   8   ));
elsif   signed(x)   <   signed(thres(   9   ))  THEN    fx_out <=   std_logic_vector(rom(   9   ));
elsif   signed(x)   <   signed(thres(   10  ))  THEN    fx_out <=   std_logic_vector(rom(   10  ));
elsif   signed(x)   <   signed(thres(   11  ))  THEN    fx_out <=   std_logic_vector(rom(   11  ));
elsif   signed(x)   <   signed(thres(   12  ))  THEN    fx_out <=   std_logic_vector(rom(   12  ));
elsif   signed(x)   <   signed(thres(   13  ))  THEN    fx_out <=   std_logic_vector(rom(   13  ));
elsif   signed(x)   <   signed(thres(   14  ))  THEN    fx_out <=   std_logic_vector(rom(   14  ));
elsif   signed(x)   <   signed(thres(   15  ))  THEN    fx_out <=   std_logic_vector(rom(   15  ));
elsif   signed(x)   <   signed(thres(   16  ))  THEN    fx_out <=   std_logic_vector(rom(   16  ));
elsif   signed(x)   <   signed(thres(   17  ))  THEN    fx_out <=   std_logic_vector(rom(   17  ));
elsif   signed(x)   <   signed(thres(   18  ))  THEN    fx_out <=   std_logic_vector(rom(   18  ));
elsif   signed(x)   <   signed(thres(   19  ))  THEN    fx_out <=   std_logic_vector(rom(   19  ));
elsif   signed(x)   <   signed(thres(   20  ))  THEN    fx_out <=   std_logic_vector(rom(   20  ));
elsif   signed(x)   <   signed(thres(   21  ))  THEN    fx_out <=   std_logic_vector(rom(   21  ));
elsif   signed(x)   <   signed(thres(   22  ))  THEN    fx_out <=   std_logic_vector(rom(   22  ));
elsif   signed(x)   <   signed(thres(   23  ))  THEN    fx_out <=   std_logic_vector(rom(   23  ));
elsif   signed(x)   <   signed(thres(   24  ))  THEN    fx_out <=   std_logic_vector(rom(   24  ));
elsif   signed(x)   <   signed(thres(   25  ))  THEN    fx_out <=   std_logic_vector(rom(   25  ));
elsif   signed(x)   <   signed(thres(   26  ))  THEN    fx_out <=   std_logic_vector(rom(   26  ));
elsif   signed(x)   <   signed(thres(   27  ))  THEN    fx_out <=   std_logic_vector(rom(   27  ));
elsif   signed(x)   <   signed(thres(   28  ))  THEN    fx_out <=   std_logic_vector(rom(   28  ));
elsif   signed(x)   <   signed(thres(   29  ))  THEN    fx_out <=   std_logic_vector(rom(   29  ));
elsif   signed(x)   <   signed(thres(   30  ))  THEN    fx_out <=   std_logic_vector(rom(   30  ));
elsif   signed(x)   <   signed(thres(   31  ))  THEN    fx_out <=   std_logic_vector(rom(   31  ));
elsif   signed(x)   <   signed(thres(   32  ))  THEN    fx_out <=   std_logic_vector(rom(   32  ));
elsif   signed(x)   <   signed(thres(   33  ))  THEN    fx_out <=   std_logic_vector(rom(   33  ));
elsif   signed(x)   <   signed(thres(   34  ))  THEN    fx_out <=   std_logic_vector(rom(   34  ));
elsif   signed(x)   <   signed(thres(   35  ))  THEN    fx_out <=   std_logic_vector(rom(   35  ));
elsif   signed(x)   <   signed(thres(   36  ))  THEN    fx_out <=   std_logic_vector(rom(   36  ));
elsif   signed(x)   <   signed(thres(   37  ))  THEN    fx_out <=   std_logic_vector(rom(   37  ));
elsif   signed(x)   <   signed(thres(   38  ))  THEN    fx_out <=   std_logic_vector(rom(   38  ));
elsif   signed(x)   <   signed(thres(   39  ))  THEN    fx_out <=   std_logic_vector(rom(   39  ));
elsif   signed(x)   <   signed(thres(   40  ))  THEN    fx_out <=   std_logic_vector(rom(   40  ));
elsif   signed(x)   <   signed(thres(   41  ))  THEN    fx_out <=   std_logic_vector(rom(   41  ));
elsif   signed(x)   <   signed(thres(   42  ))  THEN    fx_out <=   std_logic_vector(rom(   42  ));
elsif   signed(x)   <   signed(thres(   43  ))  THEN    fx_out <=   std_logic_vector(rom(   43  ));
elsif   signed(x)   <   signed(thres(   44  ))  THEN    fx_out <=   std_logic_vector(rom(   44  ));
elsif   signed(x)   <   signed(thres(   45  ))  THEN    fx_out <=   std_logic_vector(rom(   45  ));
elsif   signed(x)   <   signed(thres(   46  ))  THEN    fx_out <=   std_logic_vector(rom(   46  ));
elsif   signed(x)   <   signed(thres(   47  ))  THEN    fx_out <=   std_logic_vector(rom(   47  ));
elsif   signed(x)   <   signed(thres(   48  ))  THEN    fx_out <=   std_logic_vector(rom(   48  ));
elsif   signed(x)   <   signed(thres(   49  ))  THEN    fx_out <=   std_logic_vector(rom(   49  ));
elsif   signed(x)   <   signed(thres(   50  ))  THEN    fx_out <=   std_logic_vector(rom(   50  ));
elsif   signed(x)   <   signed(thres(   51  ))  THEN    fx_out <=   std_logic_vector(rom(   51  ));
elsif   signed(x)   <   signed(thres(   52  ))  THEN    fx_out <=   std_logic_vector(rom(   52  ));
elsif   signed(x)   <   signed(thres(   53  ))  THEN    fx_out <=   std_logic_vector(rom(   53  ));
elsif   signed(x)   <   signed(thres(   54  ))  THEN    fx_out <=   std_logic_vector(rom(   54  ));
elsif   signed(x)   <   signed(thres(   55  ))  THEN    fx_out <=   std_logic_vector(rom(   55  ));
elsif   signed(x)   <   signed(thres(   56  ))  THEN    fx_out <=   std_logic_vector(rom(   56  ));
elsif   signed(x)   <   signed(thres(   57  ))  THEN    fx_out <=   std_logic_vector(rom(   57  ));
elsif   signed(x)   <   signed(thres(   58  ))  THEN    fx_out <=   std_logic_vector(rom(   58  ));
elsif   signed(x)   <   signed(thres(   59  ))  THEN    fx_out <=   std_logic_vector(rom(   59  ));
elsif   signed(x)   <   signed(thres(   60  ))  THEN    fx_out <=   std_logic_vector(rom(   60  ));
elsif   signed(x)   <   signed(thres(   61  ))  THEN    fx_out <=   std_logic_vector(rom(   61  ));
elsif   signed(x)   <   signed(thres(   62  ))  THEN    fx_out <=   std_logic_vector(rom(   62  ));
else    fx_out <= std_logic_vector(rom(63));
end if;
end process C1;
end architecture main;
