// Designer : Walid Akash
// Company : DSi
// Description : Execute stage pipeline register

module execute_stage
  import rv32i_pkg::*;
(
    input logic clk,

    input logic regwriteE,
    input logic resultsrcE,
    input logic memwriteE,
    input logic [DPW-1:0] aluresultE,
    input logic [DPW-1:0] Rd2E,
    input logic [4:0] RdE,

    output logic regwriteM,
    output logic resultsrcM,
    output logic memwriteM,
    output logic [DPW-1:0] aluresultM,
    output logic [DPW-1:0] Rd2M,
    output logic [4:0] RdM
);

  //-SIGNALS

  logic [DPW-1:0] srcA;
  logic [DPW-1:0] srcB;
  logic immextE;
  logic alusrcE;
  alu_op_t aluctrlE;

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
      .opcode(aluctrlE),
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