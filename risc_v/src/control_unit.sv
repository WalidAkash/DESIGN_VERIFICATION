// Designer : Nakibur Rahman
// Company  : DSi

module control_unit
  import rv32i_pkg::instr_type_t;
  import rv32i_pkg::func_code_t;
  import rv32i_pkg::alu_op_t;
(
    input  instr_type_t instr_type,
    input  func_code_t  func_code,
    input  logic        funct7b5,
    output logic        branch,
    output logic        resultsrc,
    output logic        memwrite,
    output logic        alusrc,
    output logic  [1:0] immsrc,
    output logic        regwrite,
    output alu_op_t     alu_ctrl
);

  logic [1:0] op;  //indicates if it is R-type/I-type load or alu

  // instruction decoder instantiation

  instr_dec u_instr_dec (
      .instr_type(instr_type),
      .branch    (branch),
      .resultsrc (resultsrc),
      .memwrite  (memwrite),
      .alusrc    (alusrc),
      .immsrc    (immsrc),
      .op        (op),
      .regwrite  (regwrite)
  );

  // alu operation decoder

  alu_dec u_alu_dec (
      .func_code(func_code),
      .funct7b5 (funct7b5),
      .op       (op),
      .alu_ctrl (alu_ctrl)
  );
endmodule

