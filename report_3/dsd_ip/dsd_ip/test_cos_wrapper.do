restart -force -nowave;
add wave -r /*;
force clk 1 0 ns, 0 10ns -repeat 20ns;
force radian 32'h0x00000000 20ns;
run 1000ns;
radix hexadecimal;