library verilog;
use verilog.vl_types.all;
entity fpadd_en_altbarrel_shift_fkb is
    port(
        data            : in     vl_logic_vector(25 downto 0);
        distance        : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(25 downto 0)
    );
end fpadd_en_altbarrel_shift_fkb;
