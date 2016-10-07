library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	port(
		reset            : in  std_logic;
		clk              : in  std_logic;
		full             : in  std_logic;
		data_avaliable   : in  std_logic;
		control_done     : in std_logic;
		done 			 : out std_logic;
		user_read_buffer : out std_logic
	);
end entity controller;

architecture main of controller is
	type state_t is (idle, reading, read_done, finish);
	signal state   : state_t;
	signal n_state : state_t;
begin
	R1 : process
	begin
		wait until clk'event and clk = '1';
		if reset = '1' then
			state <= idle;
			done<='0';
		else
			if control_done = '1' and data_avaliable ='0' then
			state<= finish;
			done<='1';
			else
			done<='0';
			state <= n_state;
			end if;
		end if;
	end process R1;
	C1 : process(state, data_avaliable,full)
	begin
		user_read_buffer <= '0';

		case state is
			when idle =>
					if data_avaliable = '1' and full = '0' then
						n_state <= reading;
					else
						n_state <= idle;
					end if;
			when reading =>
					n_state <= read_done;
			when read_done =>
				user_read_buffer <= '1';
				n_state<=idle;
			when  finish =>
				n_state<= finish;
		end case;
	end process C1;

end architecture main;
