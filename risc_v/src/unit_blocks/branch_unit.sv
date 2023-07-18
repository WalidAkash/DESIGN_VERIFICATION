// Designer : Walid Akash
// Company : DSi

module branch_unit
	import rv32i_pkg::*;
(
	input  logic [DPW-1:0] PCF      ,
	input  logic [DPW-1:0] immextE  ,
	input  logic           branchE  ,
	input  logic           zero_flag,
	output logic [DPW-1:0] PCNext
);

	//-SIGNALS

	logic [DPW-1:0] PCPlus4          ;
	logic [DPW-1:0] PCTarget         ;
	logic           PCSrcE           ;
	alu_op_t        opcode   = ADD_OP;

	//-ASSIGNMENTS

	assign PCSrcE = branchE & zero_flag;

	//-DUT INSTANTIATIONS

	adder_sub u_adder_sub_1 (
		.opr_a    (PCF      ),
		.opr_b    (32'd4    ),
		.opcode   (opcode   ),
		.res      (PCPlus4  ),
		.zero_flag(zero_flag)
	);

	adder_sub u_adder_sub_2 (
		.opr_a    (PCF      ),
		.opr_b    (immextE  ),
		.opcode   (opcode   ),
		.res      (PCTarget ),
		.zero_flag(zero_flag)
	);


	mux_1 u_mux_1 (
		.d0_i(PCPlus4 ),
		.d1_i(PCTarget),
		.s_i (PCSrcE  ),
		.y_o (PCNext  )
	);

endmodule
