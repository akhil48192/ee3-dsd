library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.all;

entity accumulator is
port(
clk:in std_logic;
fifo_out:in std_logic_vector(31 downto 0);
reset:in std_logic;
empty: in std_logic;
result:out std_LOGIC_VECTOR(31 downto 0);
rdreq: out std_LOGIC

);

end entity accumulator;

architecture main of accumulator is

COMPONENT fpadd_en
	PORT(clock : IN STD_LOGIC;
		 clk_en : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fsm_adder
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 empty : IN STD_LOGIC;
		 rdreq : OUT STD_LOGIC;
		 add_en : OUT STD_LOGIC
	);
END COMPONENT;

signal last_result:std_LOGIC_VECTOR(31 downto 0);
signal add_en:std_LOGIC;
signal add_out:std_LOGIC_VECTOR(31 downto 0);
begin
result<=add_out;
last_result<=add_out;

control: fsm_adder port map
(clk=>clk,
reset=>reset,
empty=>empty,
rdreq=>rdreq,
add_en=>add_en
);

feedback_adder: fpadd_en port map
(
clock=>clk,
clk_en=>add_en,
aclr=>reset,
dataa=>fifo_out,
datab=>last_result,
result=>add_out
);


end architecture main;