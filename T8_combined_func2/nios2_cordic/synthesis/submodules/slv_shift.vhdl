library ieee;
use ieee. std_logic_1164.all;
use ieee.numeric_std.all;
package slv_shift is 
	function asr(in_v:std_logic_vector; n :integer )return std_logic_vector;
	function lsl(in_v:std_logic_vector; n :integer )return std_logic_vector;
end;
	
package body slv_shift is

	function asr(in_v:std_logic_vector; n :integer )return std_logic_vector is
	variable result:std_logic_vector(in_v'length-1 downto 0);
	begin
	  for index in 0 to in_v'length-1 loop
	    if(index<=in_v'left-n) then 
	     result(index):= in_v(index+n);
	     else
	       result(index):=in_v(in_v'left);
	 end if;
	 end loop;
	 return result; 
	end asr;
	
	function lsl(in_v:std_logic_vector; n :integer )return std_logic_vector is
		variable result:std_logic_vector(in_v'length-1 downto 0);
		begin
	for index in 0 to in_v'length-1 loop
		if(index<n) then 
			result(index):= '0';
		else
			result(index):=in_v(index+n);
		end if;
	end loop;
	return result; 
	end lsl;
end package body slv_shift;