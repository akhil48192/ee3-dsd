library verilog;
use verilog.vl_types.all;
entity nios2_cordic_altpll is
    port(
        address         : in     vl_logic_vector(1 downto 0);
        areset          : in     vl_logic;
        c0              : out    vl_logic;
        c1              : out    vl_logic;
        clk             : in     vl_logic;
        locked          : out    vl_logic;
        phasedone       : out    vl_logic;
        read            : in     vl_logic;
        readdata        : out    vl_logic_vector(31 downto 0);
        reset           : in     vl_logic;
        write           : in     vl_logic;
        writedata       : in     vl_logic_vector(31 downto 0)
    );
end nios2_cordic_altpll;
