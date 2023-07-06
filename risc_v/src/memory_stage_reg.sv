// Designer : Walid Akash
// Company : DSi
// Description : Memory stage pipeline register

module memory_stage_reg
  import rv32i_pkg::*;
(
    input logic clk,

    input logic regwriteE,
    input logic resultsrcE,
    input logic memwriteE,
    input alu_op_t alu_ctrlE,
    input logic alusrcE,
    input logic [DPW-1:0] srcA,
    input logic [DPW-1:0] Rd2E,
    input logic [4:0] RdE,
    input logic [DPW-1:0] immextE,

    output logic regwriteM,
    output logic resultsrcM,
    output logic memwriteM,
    output logic [DPW-1:0] aluresultM,
    output logic [DPW-1:0] Rd2M,
    output logic [4:0] RdM,

    output logic [DPW-1:0] srcB  // For test purpose only
);

  //-SIGNALS

  //logic [DPW-1:0] srcB;
  logic [DPW-1:0] aluresultE;

  //-INSTATIATIONS

  mux2_1 u_mux2_1 (
      .d0_i(Rd2E),
      .d1_i(immextE),
      .s_i (alusrcE),
      .y_o (srcB)
  );

  alu u_alu (
      .opr_a (srcA),
      .opr_b (srcB),
      .opcode(alu_ctrlE),
      .res   (aluresultE)
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
