// Designer : Walid Akash (walidakash070@gmail.com)
// Company : DSi

module execute_stage
  import rv32i_pkg::instr_type_t;
  import rv32i_pkg::func_code_t;
  import rv32i_pkg::alu_op_t;
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
(
    input  logic              clk,
    input  logic    [DPW-1:0] instrD,
    input  logic    [DPW-1:0] PCD,
    input  logic              arst_n,      // for reset
    input  logic              we_3,
    input  logic    [ADW-1:0] addr_3,
    input  logic    [DPW-1:0] wd_3,
    input  logic              flushE,
    output logic    [ADW-1:0] addr_1,
    output logic    [ADW-1:0] addr_2,
    output logic              regwriteE,
    output logic              resultsrcE,
    output logic              memwriteE,
    output logic              branchE,
    output logic              alusrcE,
    output alu_op_t           alu_ctrlE,
    output logic    [DPW-1:0] srcA,
    output logic    [DPW-1:0] Rd2E,
    output logic    [ADW-1:0] RdE,
    output logic    [DPW-1:0] immextE,
    output logic    [DPW-1:0] PCE
);

  //-SIGNALS

  instr_type_t           instr_type;
  func_code_t            func_code;
  logic                  funct7b5;
  logic        [    4:0] RdD;
  logic        [DPW-1:7] instr_ext;

  logic                  branchD;
  logic                  resultsrcD;
  logic                  memwriteD;
  logic                  alusrcD;
  logic        [    1:0] immsrcD;
  logic                  regwriteD;
  alu_op_t               alu_ctrlD;

  logic        [DPW-1:0] rd_1;
  logic        [DPW-1:0] rd_2;

  logic        [DPW-1:0] immextD;

  //-DUT INSTANTIATION

  // instr_assign_unit DUT
  instr_assign_unit u_instr_assign_unit (
      .instrD    (instrD),
      .instr_type(instr_type),
      .func_code (func_code),
      .funct7b5  (funct7b5),
      .addr_1    (addr_1),
      .addr_2    (addr_2),
      .RdD       (RdD),
      .instr_ext (instr_ext)
  );

  // control_unit DUT
  control_unit u_control_unit (
      .instr_type(instr_type),
      .func_code (func_code),
      .funct7b5  (funct7b5),
      .branch    (branchD),
      .resultsrc (resultsrcD),
      .memwrite  (memwriteD),
      .alusrc    (alusrcD),
      .immsrc    (immsrcD),
      .regwrite  (regwriteD),
      .alu_ctrl  (alu_ctrlD)
  );

  // Reg File DUT Instantiation
  reg_file u_reg_file (
      .clk   (clk   ),
      .arst_n(arst_n),
      .addr_1(addr_1),
      .addr_2(addr_2),
      .addr_3(addr_3),
      .we_3  (we_3  ),
      .wd_3  (wd_3  ),
      .rd_1  (rd_1  ),
      .rd_2  (rd_2  )
  );

  // Extend Unit DUT Instantiation
  extend_unit u_extend_unit (
      .clk(clk),
      .instr_ext(instr_ext),
      .immsrcD(immsrcD),
      .immextD(immextD)
  );

  //-PROCEDURALS

  always_ff @(posedge clk) begin
    if (flushE) begin
      regwriteE  <= 0;
      resultsrcE <= 0;
      memwriteE  <= 0;
      branchE    <= 0;
      $cast(alu_ctrlE, 0);
      alusrcE <= 0;
      srcA    <= 0;
      Rd2E    <= 0;
      RdE     <= 0;
      immextE <= 0;
      PCE     <= 0;
    end else begin
      regwriteE  <= regwriteD;
      resultsrcE <= resultsrcD;
      memwriteE  <= memwriteD;
      branchE    <= branchD;
      alu_ctrlE  <= alu_ctrlD;
      alusrcE    <= alusrcD;
      srcA       <= rd_1;
      Rd2E       <= rd_2;
      RdE        <= RdD;
      immextE    <= immextD;
      PCE        <= PCD;
    end
  end
endmodule
