transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib nios2_cordic
vmap nios2_cordic nios2_cordic
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis {H:/DSD/system_template_de0/nios2_cordic/synthesis/nios2_cordic.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_customins_master_translator.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_altpll.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_sdram.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_sysid_qsys.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_timer.v}
vlog -vlog01compat -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_jtag_uart.v}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_irq_mapper.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_width_adapter.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_burst_uncompressor.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_arbitrator.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_rsp_xbar_mux_001.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_rsp_xbar_mux.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_rsp_xbar_demux_002.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_rsp_xbar_demux.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_cmd_xbar_mux.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_cmd_xbar_demux_001.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_cmd_xbar_demux.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_burst_adapter.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_traffic_limiter.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_id_router_002.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_id_router_001.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_id_router.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_addr_router_001.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_addr_router.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_slave_agent.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_master_agent.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_cpu_custom_instruction_master_multi_xconnect.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/altera_customins_slave_translator.sv}
vlog -sv -work nios2_cordic +incdir+H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/nios2_cordic_cpu_custom_instruction_master_comb_xconnect.sv}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/DSD_FP_MULT_CORDIC.vhd}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/DSD_FP_ADD_CORDIC.vhd}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/cos_rom.vhd}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/slv_shift.vhdl}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/cos_wrapper.vhd}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/fx2fp.vhd}
vcom -93 -work nios2_cordic {H:/DSD/system_template_de0/nios2_cordic/synthesis/submodules/cosine_fixpt.vhd}

