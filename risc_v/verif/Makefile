#//////////////////////////////////////////////////////////////////////////////////////////////////
#//
#// Author Name : Walid Akash (walidakash070@gmail.com)
#// Description : Makefile for verif folder testbenches
#//
#//////////////////////////////////////////////////////////////////////////////////////////////////

FLIST += ../include/rv32i_func_code.svh
FLIST += ../include/rv32i_pkg.sv
FLIST += ../src/unit_blocks/mux2_1.sv
FLIST += ../src/unit_blocks/i_cache.sv
FLIST += ../src/unit_blocks/d_cache.sv
FLIST += ../src/unit_blocks/branch_unit.sv
FLIST += ../src/unit_blocks/adder_sub.sv
FLIST += ../src/unit_blocks/instr_assign_unit.sv
FLIST += ../src/unit_blocks/shift_stage.sv
FLIST += ../src/unit_blocks/shifter.sv
FLIST += ../src/unit_blocks/adder_sub.sv
FLIST += ../src/unit_blocks/alu.sv
FLIST += ../src/unit_blocks/instr_dec.sv
FLIST += ../src/unit_blocks/alu_dec.sv
FLIST += ../src/unit_blocks/control_unit.sv
FLIST += ../src/unit_blocks/extend_unit.sv
FLIST += ../src/unit_blocks/reg_file.sv
FLIST += ../src/unit_blocks/hazard_unit.sv
FLIST += ../src/fetch_stage_reg.sv
FLIST += ../src/fetch_stage.sv
FLIST += ../src/decode_stage_reg.sv
FLIST += ../src/execute_stage_reg.sv
FLIST += ../src/memory_stage_reg.sv
FLIST += ../src/writeback_stage.sv
FLIST += ../src/writeback_stage_reg.sv
FLIST += ../src/top.sv
#FLIST += tb_reg_file.sv
FLIST += tb_i_cache.sv
FLIST += tb_alu.sv
FLIST += tb_control_unit.sv
#FLIST += tb_decode_stage.sv
#FLIST += tb_execute_stage.sv
#FLIST += tb_instr_assign.sv
FLIST += tb_fetch_stage_reg.sv
FLIST += tb_d_cache.sv
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

clean:
	@rm -rf $(CT)
