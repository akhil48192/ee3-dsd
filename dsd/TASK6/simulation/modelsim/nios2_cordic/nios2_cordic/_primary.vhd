library verilog;
use verilog.vl_types.all;
entity nios2_cordic is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        sdram_wire_addr : out    vl_logic_vector(11 downto 0);
        sdram_wire_ba   : out    vl_logic_vector(1 downto 0);
        sdram_wire_cas_n: out    vl_logic;
        sdram_wire_cke  : out    vl_logic;
        sdram_wire_cs_n : out    vl_logic;
        sdram_wire_dq   : inout  vl_logic_vector(15 downto 0);
        sdram_wire_dqm  : out    vl_logic_vector(1 downto 0);
        sdram_wire_ras_n: out    vl_logic;
        sdram_wire_we_n : out    vl_logic;
        altpll_c1_clk   : out    vl_logic
    );
end nios2_cordic;
