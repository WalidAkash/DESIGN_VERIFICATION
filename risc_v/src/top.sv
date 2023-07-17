// Designer : Walid Akash
// Company : DSi
// Description : Top module for decode stage, Execute stage and Memory Stage

module top
  import rv32i_pkg::*;
(
    // Input Ports
    input  logic           clk,
    input  logic           arst_n,

    // For store data into D_cache
    input  logic           data_en,
    input  logic [DPW-1:0] input_data,
    input  logic [DPW-1:0] input_addr,

    // Output Ports
    //-For test purpose ports
    output logic [DPW-1:0] PCF,
    output logic [DPW-1:0] instrD,

    output logic [DPW-1:0] aluresultM,
    output logic [DPW-1:0] Rd2M,
    output logic           memwriteM,
    output logic [DPW-1:0] rd

);

  ///////////////////////////////////////////////////////////////////////////  ///////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic                  flushF=0;
  logic                  stallF=0;

  logic                  stallD=0;
  logic                  flushD=0;
  logic        [DPW-1:0] PCD;

  logic                  flushE=0;  // For test purpose

  logic                  resultsrcE;
  logic                  memwriteE;
  logic                  branchE;
  logic                  alusrcE;
  logic                  regwriteE;
  alu_op_t               alu_ctrlE;
  logic        [DPW-1:0] srcA;
  logic        [DPW-1:0] Rd2E;
  logic        [ADW-1:0] RdE;
  logic        [DPW-1:0] immextE;
  logic        [DPW-1:0] PCE;

  logic                  regwriteM;
  logic                  resultsrcM;
  logic        [ADW-1:0] RdM;
  logic        [DPW-1:0] PCNext;

  /* logic            memwriteM;
    logic  [DPW-1:0] aluresultM;
    logic  [DPW-1:0] Rd2M;

    logic  [DPW-1:0] rd; */

  logic                  regwriteW;
  logic                  resultsrcW;
  logic        [DPW-1:0] resultW;
  logic        [ADW-1:0] RdW;
  logic        [DPW-1:0] ReadDataW;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-DUT INSTANTIATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Fetch stage DUT
  fetch_stage  fetch_stage_inst (
    .clk(clk),
    .resultsrcW(resultsrcW),
    .aluresultW(aluresultW),
    .ReadDataW(ReadDataW),
    .RdW(RdW),
    .flushF(flushF),
    .stallF(stallF),
    .PCNext(PCNext),
    .PCF(PCF),
    .resultW(resultW)
  );

  // Decode stage DUT
  decode_stage  decode_stage_inst (
    .clk(clk),
    .PCF(PCF),
    .flushD(flushD),
    .stallD(stallD),
    .instrD(instrD),
    .PCD(PCD)
  );

  // Execute stage DUT
  execute_stage  execute_stage_inst (
    .clk(clk),
    .instrD(instrD),
    .PCD(PCD),
    .arst_n(arst_n),
    .we_3(regwriteW),
    .addr_3(RdW),
    .wd_3(resultW),
    .flushE(flushE),
    .regwriteE(regwriteE),
    .resultsrcE(resultsrcE),
    .memwriteE(memwriteE),
    .branchE(branchE),
    .alusrcE(alusrcE),
    .alu_ctrlE(alu_ctrlE),
    .srcA(srcA),
    .Rd2E(Rd2E),
    .RdE(RdE),
    .immextE(immextE),
    .PCE(PCE)
  );

  // Memory stage DUT
  memory_stage  memory_stage_inst (
    .clk(clk),
    .arst_n(arst_n),
    .regwriteE(regwriteE),
    .resultsrcE(resultsrcE),
    .memwriteE(memwriteE),
    .branchE(branchE),
    .alusrcE(alusrcE),
    .alu_ctrlE(alu_ctrlE),
    .srcA(srcA),
    .Rd2E(Rd2E),
    .RdE(RdE),
    .immextE(immextE),
    .PCE(PCE),
    .regwriteM(regwriteM),
    .resultsrcM(resultsrcM),
    .memwriteM(memwriteM),
    .aluresultM(aluresultM),
    .Rd2M(Rd2M),
    .RdM(RdM),
    .PC_Next(PCNext)
  );

  // Write-Back stage DUT
  writeback_stage  writeback_stage_inst (
    .regwriteM(regwriteM),
    .resultsrcM(resultsrcM),
    .memwriteM(memwriteM),
    .aluresultM(aluresultM),
    .Rd2M(Rd2M),
    .RdM(RdM),
    .data_en(data_en),
    .input_data(input_data),
    .input_addr(input_addr),
    .regwriteW(regwriteW),
    .resultsrcW(resultsrcW),
    .aluresultW(aluresultW),
    .ReadDataW(ReadDataW),
    .RdW(RdW)
  );


  // Hazard Unit DUT Instantiation
  /*   hazard_unit 
    u_hazard_unit (
      .clk (clk ),
      .regwriteE (regwriteE ),
      .Rs1D (addr_1 ),
      .Rs2D (addr_2 ),
      .RdE (RdE ),
      .RdM (RdM ),
      .PCSrcE (PCSrcE ),
      .stallF (stallF ),
      .flushF (flushF ),
      .stallD (stallD ),
      .flushD (flushD ),
      .flushE  ( flushE)
    );  
 */
endmodule
