#//////////////////////////////////////////////////////////////////////////////////////////////////
#//
#// Author Name : Walid Akash (walidakash070@gmail.com)
#// Description : Makefile for verif folder testbenches
#//
#//////////////////////////////////////////////////////////////////////////////////////////////////

FLIST += ../include/rv32i_func_code.svh
FLIST += ../include/rv32i_pkg.sv
FLIST += ../src/unit_blocks/mux_1.sv
FLIST += ../src/unit_blocks/mux_2.sv
FLIST += ../src/unit_blocks/i_cache.sv
FLIST += ../src/unit_blocks/d_cache.sv
FLIST += ../src/unit_blocks/branch_unit.sv

#ALU
FLIST += ../src/unit_blocks/alu/adder_sub.sv
FLIST += ../src/unit_blocks/alu/shift_stage.sv
FLIST += ../src/unit_blocks/alu/shifter.sv
FLIST += ../src/unit_blocks/alu/alu.sv
#Control Unit
FLIST += ../src/unit_blocks/control_unit/instr_dec.sv
FLIST += ../src/unit_blocks/control_unit/alu_dec.sv
FLIST += ../src/unit_blocks/control_unit/control_unit.sv

FLIST += ../src/unit_blocks/instr_assign_unit.sv
FLIST += ../src/unit_blocks/extend_unit.sv
FLIST += ../src/unit_blocks/reg_file.sv
FLIST += ../src/unit_blocks/hazard_unit.sv
FLIST += ../src/fetch_stage.sv
FLIST += ../src/decode_stage.sv
FLIST += ../src/execute_stage.sv
FLIST += ../src/memory_stage.sv
FLIST += ../src/writeback_stage.sv
FLIST += ../src/top.sv
FLIST += tb_unit_blocks/tb_reg_file.sv
FLIST += tb_unit_blocks/tb_i_cache.sv
FLIST += tb_unit_blocks/tb_alu.sv
FLIST += tb_unit_blocks/tb_control_unit.sv
#FLIST += tb_decode_stage.sv
#FLIST += tb_execute_stage.sv
#FLIST += tb_instr_assign.sv
#FLIST += tb_fetch_stage_reg.sv
FLIST += tb_unit_blocks/tb_d_cache.sv
FLIST += tb_top.sv


#// Change the TOP module name as per as the testbench module 
TOP = tb_top

CT += *.log
CT += *.pb
CT += *.jou
CT += *.vcd
CT += xsim.dir
CT += top.wdb

run: clean
	@xvlog -sv $(FLIST)
	@xelab $(TOP) -s top
	@xsim top -runall

#// for questa only
run_questa:
	@vlog $(FLIST)
	@vsim $(TOP) -c -do "run -all;exit"

clean:
	@rm -rf $(CT)
