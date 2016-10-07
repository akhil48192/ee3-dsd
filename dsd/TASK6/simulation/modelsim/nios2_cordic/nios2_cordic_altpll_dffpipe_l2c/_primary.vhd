library verilog;
use verilog.vl_types.all;
entity nios2_cordic_altpll_dffpipe_l2c is
    port(
        clock           : in     vl_logic;
        clrn            : in     vl_logic;
        d               : in     vl_logic_vector(0 downto 0);
        q               : out    vl_logic_vector(0 downto 0)
    );
end nios2_cordic_altpll_dffpipe_l2c;
