// Designer : Walid Akash
// Company : DSi
// Description : Memory stage pipeline register

module memory_stage_reg
  import rv32i_pkg::*;
(
    input logic clk,

    input logic             regwriteE,
    input logic             resultsrcE,
    input logic             memwriteE,
    input logic   [DPW-1:0] aluresultE,
    input logic   [DPW-1:0] Rd2E,
    input logic       [4:0] RdE,

    output logic            regwriteM,
    output logic            resultsrcM,
    output logic            memwriteM,
    output logic  [DPW-1:0] aluresultM,
    output logic  [DPW-1:0] Rd2M,
    output logic      [4:0] RdM
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
