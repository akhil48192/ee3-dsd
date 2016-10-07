library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity pipeline is
	port(
		--custom instruction interface
		clk                  : out std_logic;
		reset                : out std_logic;
		start                : in  std_logic;
		done                 : out std_logic;
		clk_en               : in  std_logic;
		in_addr              : in  std_logic_vector(31 downto 0);
		n_byte               : in  std_logic_vector(31 downto 0);
		result               : out std_logic_vector(31 downto 0);
		--mm interface
		clk_mm               : in  std_logic;
		reset_mm             : in  std_logic;
		master_address       : out std_logic_vector(31 downto 0);
		master_read          : out std_logic;
		master_byteenable    : out std_logic_vector(3 downto 0);
		master_readdata      : in  std_logic_vector(31 downto 0);
		master_readdatavalid : in  std_logic;
		master_waitrequest   : in  std_logic
	);
end entity pipeline;
architecture main of pipeline is
	signal transfer_done  : std_logic;
	signal ram_out        : std_logic_vector(31 downto 0);
	signal full           : std_logic;
	signal load_en        : std_logic;
	signal cordic_in      : std_logic_vector(31 downto 0);
	signal cordic_out     : std_logic_vector(31 downto 0);
	signal fifo_out       : std_logic_vector(31 downto 0);
	signal rdreq          : std_logic;
	signal fsm_wrreq      : std_logic;
	signal empty          : std_logic;
	signal fifo_wrreq     : std_logic;
	signal control_done   : std_logic;
	signal data_avaliable : std_logic;
	signal delay          : std_logic;
	signal tmp_delay      : std_logic;
	constant tmp_count    : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(208, 32));
begin

	--count_byte: entity counter 
	--port map(n_byte,clk_mm,start,rdreq,delay);
	control_finish : entity fsm_finish port map(clk_mm, start, empty, control_done, delay);
	tmp_delay <= '0';

	DMA : entity MemRead port map(clk, reset, start, transfer_done, clk_en, in_addr, n_byte, ram_out,
			                      clk_mm, reset_mm, master_address, master_read, master_byteenable, master_readdata, master_readdatavalid, master_waitrequest,
			                      full, load_en, fsm_wrreq, control_done, data_avaliable
		);

	data_register : process
	begin
		wait until clk_mm'event and clk_mm = '1';
		if load_en = '1' then
			cordic_in <= ram_out;
		end if;
	end process data_register;

	fifo : entity fifo_cordic port map(
			start, clk_mm, cordic_out, rdreq, fifo_wrreq, empty, full, fifo_out
		);

	accum : entity accumulator port map(
			clk_mm, fifo_out, start, empty, result, rdreq
		);

	count_finish : entity lsr34 port map(
			start, clk_mm, clk_en, delay, done
		);

	delay_wrrqt : entity lsr26 port map(
			start, clk_mm, clk_en, fsm_wrreq, fifo_wrreq
		);

	cordic_blk : entity combined_func2 port map(clk_mm, cordic_in, cordic_out, clk_en);

end architecture main;