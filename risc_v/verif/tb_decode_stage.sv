// Designer : Walid Akash
// Company : DSi

module tb_decode_stage;
  import rv32i_pkg::*;

  `include "../include/tb_ess.sv"

  //-LOCALPARAMS

  localparam int ADW = 5;

  //-SIGNALS

  // generates static task start_clk_i with tHigh:3 tLow:7
  `CREATE_CLK(clk_i, 2, 2)

  logic    resultsrcD;
  logic    memwriteD;
  logic    alusrcD;
  logic    regwriteD;
  alu_op_t alu_ctrlD;
  logic [DPW-1:0] rd_1;
  logic [DPW-1:0] rd_2;
  logic [4:0] RdD;
  logic [31:0] immextD;

  logic resultsrcE;
  logic memwriteE;
  logic alusrcE;
  logic regwriteE;
  alu_op_t alu_ctrlE;
  logic [DPW-1:0] srcA;
  logic [DPW-1:0] Rd2E;
  logic [4:0] RdE;
  logic [31:0] immextE;

  //-VARIABLES

  int error;

  //-DUT INSTANTIATIONS

  decode_stage #(
      .ADW(ADW)
  ) decode_stage_dut (
      .clk(clk_i),
      .resultsrcD(resultsrcD),
      .memwriteD(memwriteD),
      .alusrcD(alusrcD),
      .regwriteD(regwriteD),
      .alu_ctrlD(alu_ctrlD),
      .rd_1(rd_1),
      .rd_2(rd_2),
      .RdD(RdD),
      .immextD(immextD),
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

  //-PROCEDURALS

  initial begin
    start_clk_i();
    @(posedge clk_i);
    #10;

    if ((resultsrcD == resultsrcE) && (memwriteD==memwriteE) && (alusrcD== alusrcE) 
    && (regwriteD==regwriteE) && (alu_ctrlD == alu_ctrlE) && (rd_1 == srcA) && 
    (rd_2==Rd2E) && (RdD == RdE)&&(immextD==immextE)) begin
      error++;
    end

    result_print((error == 0), "decode_stage verified");
    #10;
    $finish;
  end

endmodule
