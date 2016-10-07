library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_finish is
port(
clk:in std_logic;
reset:in std_logic;
empty: in std_logic;
control_done:in std_logic;
done:out std_logic
);
end entity fsm_finish;


architecture main of fsm_finish is
type state_t is (idle,check1,check2,finish);
signal state:state_t;
signal nstate:state_t;
begin
R1: process (clk,reset)begin
if reset = '1' then
	state<=idle;
else
	if clk'event and clk='1'then
		state<=nstate;
	end if;
end if;
end process R1;

C1: process(state,empty,control_done) begin
done<='0';
case state is
when idle=>
if control_done='1' then
	nstate<=check1;
else
	nstate<=idle;
end if;
when check1 =>
if empty ='0' then
nstate<=check1;
else
nstate<=check2;
end if;
when check2=>
if empty='0' then
nstate<=check2;
else
nstate<=finish;
end if;
when finish=>
nstate<=finish;
done<='1';
end case;
end process C1;

end architecture main;