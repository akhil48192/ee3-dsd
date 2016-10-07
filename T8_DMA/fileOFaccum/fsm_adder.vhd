LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY fsm_adder IS
	PORT(
		clk   : IN  std_logic;
		reset : IN  std_logic;
		empty : IN  std_logic;
		rdreq : OUT std_logic;
		add_en	: OUT std_logic
	);
END ENTITY fsm_adder;

ARCHITECTURE fsm OF fsm_adder IS
	TYPE state_t IS (idle, pop, delay);
	SIGNAL state, nstate : state_t;
	SIGNAL delay_count   : std_logic_vector(2 DOWNTO 0);
	signal is_zero: std_logic;
	signal decrement:std_logic;
	
BEGIN
	R1 : PROCESS(clk,reset)
	BEGIN
		IF reset = '1' THEN
			state       <= idle;
			delay_count <= (others=>'1');
		ELSE
			if clk'event and clk='1' then
				state <= nstate;

				if is_zero ='0' then
					if decrement ='1' then
						delay_count <= std_logic_vector(unsigned(delay_count) - 1);
					end if;
				else
					delay_count <= (others=>'1');
				end if;
			end if;
		end if;
	END PROCESS R1;
	
	P1 : PROCESS(state, is_zero,empty)
	BEGIN
		decrement<='0';
		add_en<='0';
		rdreq <= '0';
		nstate <= state;
		
		CASE (state) IS
			WHEN idle =>
				rdreq   <= '0';
				IF empty = '0' THEN
					nstate <= pop;
				else
					nstate<=idle;
				end if;
				
			WHEN pop =>
				nstate <= delay;
				rdreq  <= '1';
			WHEN delay =>
				rdreq   <= '0';

				decrement<='1';
				IF is_zero= '1' THEN
					add_en <= '0';
					nstate <= idle;
				else
					add_en <= '1';
					nstate<=delay;
				END IF;
				
			WHEN OTHERS => NULL;

		END CASE;
	END PROCESS P1;
c1: process (delay_count) begin
if to_integer(unsigned(delay_count))=0 then
is_zero <='1';
else
is_zero<='0';
end if;
end process c1;

END ARCHITECTURE fsm;