// Designer : Walid Akash
// Company : DSi
// Description : Top module for decode stage and Execute stage

module top
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    // Input Ports
    input logic           clk,    // clock
    input logic [DPW-1:0] instrD,

    // Output ports
    output logic regwriteM,
    output logic resultsrcM,
    output logic memwriteM,
    output logic [DPW-1:0] aluresultM,
    output logic [DPW-1:0] Rd2M,
    output logic [4:0] RdM
);

  //-SIGNALS

  logic resultsrcD;
  logic memwriteD;
  logic alusrcD;
  logic immsrc;
  logic regwriteD;
  alu_op_t alu_ctrlD;
  logic [DPW-1:0] rd_1;
  logic [DPW-1:0] rd_2;
  logic [DPW-1:0] immextD;
  logic resultsrcE;
  logic memwriteE;
  logic alusrcE;
  logic regwriteE;
  alu_op_t alu_ctrlE;
  logic [DPW-1:0] srcA;
  logic [DPW-1:0] Rd2E;
  logic [4:0] RdE;
  logic [31:0] immextE;


  //-DUT INSTANTIATIONS

  // Control Unit DUT Instantiation
  decode_stage #(
      .ADW(ADW)
  ) u_decode_stage (
      .clk(clk),
      .instrD(instrD),
      .resultsrcE(resultsrcE),
      .memwriteE(memwriteE),
      .alusrcE(alusrcE),
      .regwriteE(regwriteE),
      .alu_ctrlE(alu_ctrlE),
      .srcA(srcA),
      .Rd2E(Rd2E),
      .RdE(RdE),
      .immextE(immextE)
  );


  // Execute Stage DUT Instantiation
  execute_stage u_execute_stage (
      .clk(clk),
      .regwriteE(regwriteE),
      .resultsrcE(resultsrcE),
      .memwriteE(memwriteE),
      .aluresultE(aluresultE),
      .Rd2E(Rd2E),
      .RdE(RdE),
      .immextE(immextE),
      .alusrcE(alusrcE),
      .alu_ctrlE(alu_ctrlE),
      .regwriteM(regwriteM),
      .resultsrcM(resultsrcM),
      .memwriteM(memwriteM),
      .aluresultM(aluresultM),
      .Rd2M(Rd2M),
      .RdM(RdM)
  );

endmodule
