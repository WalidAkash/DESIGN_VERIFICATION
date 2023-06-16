// Designer : Walid Akash
// Company : DSi
// Description : decode stage pipeline register

module decode_stage
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    input logic clk,

    input logic    resultsrcD,
    input logic    memwriteD,
    input logic    alusrcD,
    input logic    regwriteD,
    input alu_op_t alu_ctrlD,
    input logic [DPW-1:0] rd_1,
    input logic [DPW-1:0] rd_2,
    input logic [4:0] RdD,
    input logic [31:0] immextD,

    output logic resultsrcE,
    output logic memwriteE,
    output logic alusrcE,
    output logic regwriteE,
    output alu_op_t alu_ctrlE,
    output logic [DPW-1:0] srcA,
    output logic [DPW-1:0] Rd2E,
    output logic [4:0] RdE,
    output logic [31:0] immextE
);

  //-SIGNALS

  instr_type_t           instr_type;
  func_code_t            func_code;
  logic                  funct7b5;
  logic                  immsrcD;

  logic                  clk_i;  // clock
  logic        [ADW-1:0] addr_1;
  logic        [ADW-1:0] addr_2;
  logic        [ADW-1:0] addr_3;
  logic                  we;  // write enable
  logic        [DPW-1:0] wd_3;  // write data


  //-INSTANTIATION

  control_unit u_control_unit (
      .instr_type(instr_type),
      .func_code (func_code),
      .funct7b5  (funct7b5),
      .resultsrc (resultsrcD),
      .memwrite  (memwriteD),
      .alusrc    (alusrcD),
      .immsrc    (immsrcD),
      .regwrite  (regwriteD),
      .alu_ctrl  (alu_ctrlD)
  );

  reg_file #(
      .ADW(ADW),
      .DPW(DPW)
  ) u_reg_file (
      .clk(clk_i),
      .addr_1(addr_1),
      .addr_2(addr_2),
      .addr_3(addr_3),
      .we(we),
      .wd_3(wd_3),
      .rd_1(rd_1),
      .rd_2(rd_2)
  );

  //-PROCEDURALS

  always_ff @(posedge clk) begin
    resultsrcE <= resultsrcD;
    memwriteE <= memwriteD;
    alusrcE <= alusrcD;
    regwriteE <= regwriteD;
    alu_ctrlE <= alu_ctrlD;
    srcA <= rd_1;
    Rd2E <= rd_2;
    RdE <= RdD;
    immextE <= immextD;
  end
endmodule
