// Designer : Walid Akash
// Company : DSi
// Description : Execute stage pipeline logicister testbench

module tb_execute_stage;

  //-IMPORTS

  import rv32i_pkg::*;

  `include "../include/tb_ess.sv"

  //-SIGNALS

  // generates static task start_clk_i with tHigh:3 tLow:7
  `CREATE_CLK(clk_i, 2, 2)

  logic regwriteE;
  logic resultsrcE;
  logic memwriteE;
  logic [DPW-1:0] aluresultE;
  logic [DPW-1:0] Rd2E;
  logic [4:0] RdE;
  logic regwriteM;
  logic resultsrcM;
  logic memwriteM;
  logic [DPW-1:0] aluresultM;
  logic [DPW-1:0] Rd2M;
  logic [4:0] RdM;

  //-VARIABLES

  int error;

  //-DUT INSTANTIATIONS

  execute_stage execute_stage_dut (
      .clk(clk_i),
      .regwriteE(regwriteE),
      .resultsrcE(resultsrcE),
      .memwriteE(memwriteE),
      .aluresultE(aluresultE),
      .Rd2E(Rd2E),
      .RdE(RdE),
      .regwriteM(regwriteM),
      .resultsrcM(resultsrcM),
      .memwriteM(memwriteM),
      .aluresultM(aluresultM),
      .Rd2M(Rd2M),
      .RdM(RdM)
  );

  initial begin
    start_clk_i();
    @(posedge clk_i);
    #10;

    if ((resultsrcE == resultsrcM) && (memwriteE==memwriteM)
    && (regwriteE==regwriteM) && (aluresultE == aluresultM)&& 
    (Rd2E==Rd2M)&&(RdE==RdM)) begin
      error++;
    end

    result_print((error == 0), "execute_stage verified");
    #10;
    $finish;
  end
endmodule
