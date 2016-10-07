restart -force -nowave;

add wave -r /*

force clk 1 0ns, 0 10ns -repeat 20ns;
force rst 1 0ns, 0 40ns;
force x 32'h0 100ns, 32'h0x40a00000 900ns, 32'h0x41200000 1800ns, 32'h0x41700000 2700ns; 
force counter_enable 1 100ns, 0 120ns, 1 900ns, 0 920ns, 1 1800ns, 0 1820ns, 1 2700ns, 0 2720ns;
run 10000ns