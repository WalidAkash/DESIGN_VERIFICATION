// Designer : Walid Akash
// Company : DSi
// Description : Execute stage pipeline register

module execute_stage_reg
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    // Input ports
    input logic             clk,
    input logic             resultsrcD,
    input logic             memwriteD,
    input logic             branchD,
    input alu_op_t          alu_ctrlD,
    input logic             alusrcD,
    input logic             regwriteD,
    input logic   [DPW-1:0] rd_1,
    input logic   [DPW-1:0] rd_2,
    input logic   [    4:0] RdD,
    input logic   [DPW-1:0] immextD,
    input logic   [DPW-1:0] PCD,
    input logic             flushE,   // From Hazard Unit


    //Output ports
    output logic           resultsrcE,
    output logic           memwriteE,
    output logic           branchE,
    output logic           alusrcE,
    output logic           regwriteE,
    output alu_op_t        alu_ctrlE,
    output logic [DPW-1:0] srcA,
    output logic [DPW-1:0] Rd2E,
    output logic [ADW-1:0] RdE,
    output logic [DPW-1:0] immextE,
    output logic [DPW-1:0] PCE
);

  //-PROCEDURALS

  always_ff @(posedge clk) begin
    if (flushE) begin
        regwriteE <= 0;
        resultsrcE <= 0;
        memwriteE <= 0;
        branchE <= 0;
        $cast(alu_ctrlE, 0);
        alusrcE <= 0;
        srcA <= 0;
        Rd2E <= 0;
        RdE <= 0;
        immextE <= 0;
        PCE <= 0;
    end else begin
        regwriteE <= regwriteD;
        resultsrcE <= resultsrcD;
        memwriteE <= memwriteD;
        branchE <= branchD;
        alu_ctrlE <= alu_ctrlD;
        alusrcE <= alusrcD;
        srcA <= rd_1;
        Rd2E <= rd_2;
        RdE <= RdD;
        immextE <= immextD;
        PCE <= PCD;
    end
  end
endmodule
