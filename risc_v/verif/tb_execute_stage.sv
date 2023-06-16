// Designer : Walid Akash
// Company : DSi
// Description : Execute stage pipeline logicister testbench

module tb_execute_stage;

logic r_clk;
logic r_logicwriteE;
logic r_resultsrcE;
logic r_memwriteE;
logic [DPW-1:0] r_aluresultE;
logic [DPW-1:0] r_Rd2E;
logic [4:0] r_RdE;
logic r_logicwriteM;
logic r_resultsrcM;
logic r_memwriteM;
logic [DPW-1:0] r_aluresultM;
logic [DPW-1:0] r_Rd2M;
logic [4:0] r_RdM;


  execute_stage execute_stage_dut (
      .clk(clk),
      .logicwriteE(logicwriteE),
      .resultsrcE(resultsrcE),
      .memwriteE(memwriteE),
      .aluresultE(aluresultE),
      .Rd2E(Rd2E),
      .RdE(RdE),
      .logicwriteM(logicwriteM),
      .resultsrcM(resultsrcM),
      .memwriteM(memwriteM),
      .aluresultM(aluresultM),
      .Rd2M(Rd2M),
      .RdM(RdM)
  );

endmodule
