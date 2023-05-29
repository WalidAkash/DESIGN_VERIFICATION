FLIST += xbar.sv
FLIST += xbar_tb.sv

TOP = xbar_tb

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