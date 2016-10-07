library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.all;

entity MemRead is 
port(
--custom instruction interface
clk:out std_logic;
reset:out std_logic;
start:in std_logic;
done: out std_logic;
clk_en:in std_logic;
in_addr:in std_logic_vector(31 downto 0);
n_byte:in std_logic_vector(31 downto 0);
data_out:out std_logic_vector(31 downto 0);


--avalon mm IO
clk_mm:in std_logic;
reset_mm:in std_logic;
master_address:out std_logic_vector(31 downto 0);
master_read:out std_logic;
master_byteenable:out std_logic_vector(3 downto 0);
master_readdata:in std_logic_vector(31 downto 0);
master_readdatavalid:in std_logic;
master_waitrequest:in std_logic;


full:in std_logic;
load_en:out std_logic;
wrreq:out std_LOGIC;
finish:out std_LOGIC;
data_avaliable2:out std_LOGIC
);

end entity MemRead;

architecture main of MemRead is

COMPONENT latency_aware_read_master
GENERIC (ADDRESSWIDTH : INTEGER;
			BYTEENABLEWIDTH : INTEGER;
			DATAWIDTH : INTEGER;
			FIFODEPTH : INTEGER;
			FIFODEPTH_LOG2 : INTEGER;
			FIFOUSEMEMORY : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 control_fixed_location : IN STD_LOGIC;
		 control_go : IN STD_LOGIC;
		 user_read_buffer : IN STD_LOGIC;
		 master_readdatavalid : IN STD_LOGIC;
		 master_waitrequest : IN STD_LOGIC;
		 control_read_base : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 control_read_length : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 master_readdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 control_done : OUT STD_LOGIC;
		 control_early_done : OUT STD_LOGIC;
		 user_data_available : OUT STD_LOGIC;
		 master_read : OUT STD_LOGIC;
		 master_address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 master_byteenable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 user_buffer_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;


signal control_fixed_location:std_logic;
signal user_data_avaliable:std_logic;
signal user_read_buffer:std_logic;
signal byte_no:std_LOGIC_VECTOR(34 downto 0);
signal control_done:std_LOGIC;

begin

data_avaliable2<=user_data_avaliable;
finish<=control_done;
control_fixed_location<='0';
clk<=clk_mm;
reset<=reset_mm;
wrreq<=user_read_buffer;
b2v_inst : latency_aware_read_master
GENERIC MAP(ADDRESSWIDTH => 32,
			BYTEENABLEWIDTH => 4,
			DATAWIDTH => 32,
			FIFODEPTH => 32,
			FIFODEPTH_LOG2 => 5,
			FIFOUSEMEMORY => 1
			)
PORT MAP(clk => clk_mm,
		 reset => reset_mm,
		 control_fixed_location => control_fixed_location,
		 control_go => start,
		 user_read_buffer => user_read_buffer,
		 master_readdatavalid => master_readdatavalid,
		 master_waitrequest => master_waitrequest,
		 control_read_base => in_addr,
		 control_read_length => n_byte,
		 master_readdata => master_readdata,
		 control_done => control_done,
		 user_data_available => user_data_avaliable,
		 master_read => master_read,
		 master_address => master_address,
		 master_byteenable => master_byteenable,
		 user_buffer_data => data_out);
		 

C2:entity controller port map(
reset=>start,
clk=>clk_mm,
full=>full,
control_done=>control_done,
done=>done,
data_avaliable=>user_data_avaliable,
user_read_buffer=>user_read_buffer
);
load_en<=user_data_avaliable;

end architecture main;