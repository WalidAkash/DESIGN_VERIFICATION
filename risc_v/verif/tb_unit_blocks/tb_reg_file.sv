// Designer : Walid Akash (walidakash070@gmail.com)
// Company : DSi

module tb_reg_file ();

	// bring in the testbench essentials functions and macros
	`include "../../include/tb_ess.sv"
	`include "../../src/unit_blocks/reg_file.sv"

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//-LOCALPARAMS
	localparam int ADW = 5 ;
	localparam int DPW = 32;

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//-SIGNALS

	// generates static task start_clk_i with tHigh:3 tLow:7
	`CREATE_CLK(clk, 2, 2)

	logic           arst_n;
	logic [ADW-1:0] addr_1;
	logic [ADW-1:0] addr_2;
	logic [ADW-1:0] addr_3;
	logic           we_3  ;
	logic [DPW-1:0] wd_3  ;
	logic [DPW-1:0] rd_1  ;
	logic [DPW-1:0] rd_2  ;

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//-VARIABLES

	logic [DPW-1:0] read_1;
	logic [DPW-1:0] read_2;
	logic [DPW-1:0] read_3;
	int             error ;

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//-RTLS

	reg_file #(
		.ADW(ADW),
		.DPW(DPW)
	) reg_file_inst (
		.clk   (clk   ),
		.arst_n(arst_n),
		.addr_1(addr_1),
		.addr_2(addr_2),
		.addr_3(addr_3),
		.we_3  (we_3  ),
		.wd_3  (wd_3  ),
		.rd_1  (rd_1  ),
		.rd_2  (rd_2  )
	);
	//////////////////////////////////////////////////////////////////////////////////////////////////
	//-PROCEDURALS

	initial
		begin
			$display("\033[7;38m####################### TEST STARTED #######################\033[0m");
			$dumpfile("raw.vcd");
			$dumpvars;
		end

	final
		begin
			$display("\033[7;38m######################## TEST ENDED ########################\033[0m");
		end

	initial begin
		start_clk();
		@(posedge clk);
		arst_n <= 0;
		repeat (3) @(posedge clk);
		arst_n <= 1;
		repeat (3) @(posedge clk);

		for (int i = 0; i < 10; i++) begin
			$display("Test- - - > %p", i);
/* 			addr_1 <= $urandom_range(0, 8);
			addr_2 <= $urandom_range(9, 15); */
			addr_3 <= $urandom_range(0, 15);
			we_3 <= $urandom_range(0, 1);

			@(posedge clk);

			$display("addr_1 = ", addr_1);
			$display("addr_2 = ", addr_2);
			$display("addr_3 = ", addr_3);

      wd_3 <= $urandom_range(0, 32'h88888887);

			// Write data to addr_3
			/* if (we_3) begin
				wd_3 <= $urandom_range(0, 32'h88888887);
			end */

			@(posedge clk);

			addr_1 <= addr_3;
			addr_2 <= addr_3;

			repeat (2) @(posedge clk);

			$display("addr_1_n = ", addr_1);
			$display("addr_2_n = ", addr_2);
			$display("addr_3_n = ", addr_3);

			$display("rd_1 = ", rd_1);
			$display("rd_2 = ", rd_2);
			$display("wd_3 = ", wd_3);

			/* if (we_3) begin
				if ((rd_1 == wd_3) && (rd_2 == wd_3)) begin
					error = error;
				end else begin
					error++;
				end
			end
			$display("Error = ", error); */
		end

		//result_print(error == 0, "Reg file verified");
		$finish;
	end

endmodule
