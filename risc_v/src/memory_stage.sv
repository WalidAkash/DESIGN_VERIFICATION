module memory_stage
  import rv32i_pkg::alu_op_t;
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
(
    input logic           clk,
    input logic           arst_n,
    input logic           regwriteE,
    input logic           resultsrcE,
    input logic           memwriteE,
    input logic           branchE,
    input logic           alusrcE,
    input alu_op_t        alu_ctrlE,
    input logic [DPW-1:0] srcA,
    input logic [DPW-1:0] Rd2E,
    input logic [ADW-1:0] RdE,
    input logic [DPW-1:0] immextE,
    input logic [DPW-1:0] PCE,

    output logic            regwriteM,
    output logic            resultsrcM,
    output logic            memwriteM,
    output logic  [DPW-1:0] aluresultM,
    output logic  [DPW-1:0] Rd2M,
    output logic      [4:0] RdM,
    output logic  [DPW-1:0] PC_Next
);

  //-SIGNALS

  logic        [DPW-1:0] srcB;
  logic        [DPW-1:0] aluresultE;
  logic                  zero_flag;

  //- DUT INSTANTIATIONS

  // MUX DUT Instantiation
  mux_1 u_mux_1 (
    .d0_i(Rd2E),
    .d1_i(immextE),
    .s_i (alusrcE),
    .y_o (srcB)
  );

  // ALU DUT Instantiation
  alu u_alu (
    .opr_a    (srcA),
    .opr_b    (srcB),
    .opcode   (alu_ctrlE),
    .res      (aluresultE),
    .zero_flag(zero_flag)
  );

  branch_unit u_branch_unit (
    .PCF      (PCE),
    .immextE  (immextE),
    .branchE  (branchE),
    .zero_flag(zero_flag),
    .PCNext   (PC_Next)
  );


  //-PROCEDURALS

  always_ff @(posedge clk) begin
    regwriteM <= regwriteE;
    resultsrcM <= resultsrcE;
    memwriteM <= memwriteE;
    aluresultM <= aluresultE;
    Rd2M <= Rd2E;
    RdM <= RdE;
  end
endmodule