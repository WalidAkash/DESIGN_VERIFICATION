#//////////////////////////////////////////////////////////////////////////////////////////////////
#//
#// Author Name : Walid Akash (walidakash070@gmail.com)
#// Description : Makefile for verif folder testbenches
#//
#//////////////////////////////////////////////////////////////////////////////////////////////////

FLIST += ../include/rv32i_func_code.svh
FLIST += ../include/rv32i_pkg.sv
FLIST += ../src/shift_stage.sv
FLIST += ../src/shifter.sv
FLIST += ../src/adder_sub.sv
FLIST += ../src/alu.sv
FLIST += ../src/instr_dec.sv
FLIST += ../src/alu_dec.sv
FLIST += ../src/control_unit.sv
FLIST += ../src/reg_file.sv
FLIST += ../src/decode_stage.sv
FLIST += tb_reg_file.sv
FLIST += tb_alu.sv
FLIST += tb_control_unit.sv
FLIST += tb_decode_stage.sv


#// Change the TOP module name as per as the testbench module 
TOP = tb_decode_stage

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