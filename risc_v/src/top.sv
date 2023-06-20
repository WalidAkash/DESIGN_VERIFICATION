// Designer : Walid Akash
// Company : DSi
// Description : Top module for decode stage and Execute stage

module top
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    // Input Ports
    input logic           clk,     // clock
    input logic [DPW-1:0] instrD,
    input logic [ADW-1:0] addr_3,  // For test purpose only
    input logic [DPW-1:0] wd_3,    // For test purpose only
    input logic           we,      // For test purpose only

    // Output ports
    output logic regwriteM,
    output logic resultsrcM,
    output logic memwriteM,
    output logic [DPW-1:0] aluresultM,
    output logic [DPW-1:0] Rd2M,
    output logic [4:0] RdM,

    output logic [DPW-1:0] srcA,  // For test purpose only
    output logic [DPW-1:0] srcB   // For test purpose only
);

  //-SIGNALS

  logic resultsrcE;
  logic memwriteE;
  logic alusrcE;
  logic regwriteE;
  alu_op_t alu_ctrlE;
  //logic [DPW-1:0] srcA;   // For test purpose only
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
      .addr_3(addr_3),
      .wd_3(wd_3),
      .we(we),
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
      .alu_ctrlE(alu_ctrlE),
      .alusrcE(alusrcE),
      .srcA(srcA),
      .Rd2E(Rd2E),
      .RdE(RdE),
      .immextE(immextE),
      .regwriteM(regwriteM),
      .resultsrcM(resultsrcM),
      .memwriteM(memwriteM),
      .aluresultM(aluresultM),
      .Rd2M(Rd2M),
      .RdM(RdM),
      .srcB(srcB)
  );



endmodule
