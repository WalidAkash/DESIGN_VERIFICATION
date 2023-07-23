package rv32i_pkg;

  `include "rv32i_func_code.svh"

  localparam int DPW = 32;
  localparam int ADW = 5;
  localparam int ElemWidth = 8;
  localparam int Depth = 120;  // For number of instructions = 30. Depth = (30 X 32)/ElemWidth = 120

  typedef enum logic [6:0] {
    I_TYPE_LOAD = 7'b0000011,
    I_TYPE_ALU  = 7'b0010011,
    S_TYPE      = 7'b0100011,
    R_TYPE      = 7'b0110011,
    B_TYPE      = 7'b1100011
  } instr_type_t;

  typedef enum logic [3:0] {
    ADD_OP,
    SUB_OP,
    AND_OP,
    OR_OP,
    XOR_OP,
    SLL_OP,
    SRL_OP,
    SRA_OP,
    BEQ_OP
  } alu_op_t;

endpackage
