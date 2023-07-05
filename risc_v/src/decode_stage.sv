// Designer : Walid Akash
// Company : DSi
// Description : decode stage pipeline register

module decode_stage
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    // Input ports
    input logic           clk,
    input logic [DPW-1:0] instrD,
    input logic [ADW-1:0] addr_3,
    input logic [DPW-1:0] wd_3,
    input logic           we,      // write enable
    input logic           flushE,

    //Output ports
    output logic resultsrcE,
    output logic memwriteE,
    output logic alusrcE,
    output logic regwriteE,
    output alu_op_t alu_ctrlE,
    output logic [DPW-1:0] srcA,
    output logic [DPW-1:0] Rd2E,
    output logic [4:0] RdE,
    output logic [DPW-1:0] immextE
);

  //-SIGNALS

  instr_type_t           instr_type;
  func_code_t            func_code;
  logic                  funct7b5;
  logic                  immsrcD;
  logic                  resultsrcD;
  logic                  memwriteD;
  logic                  alusrcD;
  logic                  regwriteD;
  alu_op_t               alu_ctrlD;
  logic        [ADW-1:0] addr_1;
  logic        [ADW-1:0] addr_2;
  logic        [DPW-1:0] rd_1;
  logic        [DPW-1:0] rd_2;
  logic        [    4:0] RdD;
  logic        [DPW-1:7] instr_ext;
  logic        [DPW-1:0] immextD;


  //-DUT INSTANTIATIONS

  // Instruction assignment Unit DUT Instantiation
  instr_assign_unit #(
      .ADW(ADW)
  ) u_instr_assign_unit (
      .instrD(instrD),
      .instr_type(instr_type),
      .func_code(func_code),
      .funct7b5(funct7b5),
      .addr_1(addr_1),
      .addr_2(addr_2),
      .RdD(RdD),
      .instr_ext(instr_ext)
  );

  // Control Unit DUT Instantiation
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

  // Control Unit DUT Instantiation
  reg_file #(
      .ADW(ADW),
      .DPW(DPW)
  ) u_reg_file (
      .clk(clk),
      .addr_1(addr_1),
      .addr_2(addr_2),
      .addr_3(addr_3),
      .we(we),
      .wd_3(wd_3),
      .rd_1(rd_1),
      .rd_2(rd_2)
  );

  // Extend Unit DUT Instantiation
  extend_unit u_extend_unit (
      .instr_ext(instr_ext),
      .immsrcD  (immsrcD),
      .immextD  (immextD)
  );


  //-PROCEDURALS

  always_ff @(posedge clk) begin
    if(flushE)
    begin
        resultsrcE    <= 0;
        memwriteE     <= 0;
        alusrcE       <= 0;
        regwriteE     <= 0;
        alu_ctrlE     <= 0;
        srcA          <= 0;
        Rd2E          <= 0;
        RdE           <= 0;
        immextE       <= 0;
    end
    else
    begin
        resultsrcE    <= resultsrcD;
        memwriteE     <= memwriteD;
        alusrcE       <= alusrcD;
        regwriteE     <= regwriteD;
        alu_ctrlE     <= alu_ctrlD;
        srcA          <= rd_1;
        Rd2E          <= rd_2;
        RdE           <= RdD;
        immextE       <= immextD;
    end
  end
endmodule
