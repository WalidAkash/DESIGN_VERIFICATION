FLIST += fifo.sv
FLIST += fifo_test.sv
FLIST += tb_ns.sv

TOP = fifo_test

CT += *.log
CT += *.pb
CT += *.jou
CT += *.vcd
CT += xsim.dir

run: clean
	@xvlog -sv $(FLIST)
	@xelab $(TOP) -s top
	@xsim top -runall

clean:
	@rm -rf $(CT)
