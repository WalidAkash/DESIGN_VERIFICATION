#///////////////////////////////////////////////////////////////////////
#//
#// ### Author : Walid Akash
#//
#///////////////////////////////////////////////////////////////////////

INC_DIR = $(realpath ./../../include/)

FLIST += ../../demux/src/demux.sv
FLIST += ../src/decoder.sv
FLIST += decoder_tb.sv 

TOP = decoder_tb

CT += *.log
CT += *.pb
CT += *.jou
CT += *.vcd
CT += xsim.dir
CT += top.wdb

run: clean
	@xvlog -i $(INC_DIR) -sv $(FLIST)
	@xelab $(TOP) -s top
	@xsim top -runall

clean:
	@rm -rf $(CT)
