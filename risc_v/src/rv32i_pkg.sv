package rv32i_pkg;

  `include "rv32i_func_code.svh"

  localparam DPW = 32;

  typedef enum logic [6:0] {
    I_TYPE_LOAD = 7'b0000011,
    I_TYPE_ALU  = 7'b0010011,
    S_TYPE      = 7'b0100011,
    R_TYPE      = 7'b0110011
  } instr_type_t;

  typedef enum logic [3:0] {
    ADD_OP,
    SUB_OP,
    AND_OP,
    OR_OP,
    XOR_OP,
    SLL_OP,
    SRL_OP,
    SRA_OP
  } alu_op_t;

endpackage
