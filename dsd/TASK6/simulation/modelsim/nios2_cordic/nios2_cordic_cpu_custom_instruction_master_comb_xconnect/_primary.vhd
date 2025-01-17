library verilog;
use verilog.vl_types.all;
entity nios2_cordic_cpu_custom_instruction_master_comb_xconnect is
    port(
        ci_master0_dataa: out    vl_logic_vector(31 downto 0);
        ci_master0_datab: out    vl_logic_vector(31 downto 0);
        ci_master0_result: in     vl_logic_vector(31 downto 0);
        ci_master0_n    : out    vl_logic_vector(7 downto 0);
        ci_master0_readra: out    vl_logic;
        ci_master0_readrb: out    vl_logic;
        ci_master0_writerc: out    vl_logic;
        ci_master0_a    : out    vl_logic_vector(4 downto 0);
        ci_master0_b    : out    vl_logic_vector(4 downto 0);
        ci_master0_c    : out    vl_logic_vector(4 downto 0);
        ci_master0_ipending: out    vl_logic_vector(31 downto 0);
        ci_master0_estatus: out    vl_logic;
        ci_slave_dataa  : in     vl_logic_vector(31 downto 0);
        ci_slave_datab  : in     vl_logic_vector(31 downto 0);
        ci_slave_result : out    vl_logic_vector(31 downto 0);
        ci_slave_n      : in     vl_logic_vector(7 downto 0);
        ci_slave_readra : in     vl_logic;
        ci_slave_readrb : in     vl_logic;
        ci_slave_writerc: in     vl_logic;
        ci_slave_a      : in     vl_logic_vector(4 downto 0);
        ci_slave_b      : in     vl_logic_vector(4 downto 0);
        ci_slave_c      : in     vl_logic_vector(4 downto 0);
        ci_slave_ipending: in     vl_logic_vector(31 downto 0);
        ci_slave_estatus: in     vl_logic
    );
end nios2_cordic_cpu_custom_instruction_master_comb_xconnect;
