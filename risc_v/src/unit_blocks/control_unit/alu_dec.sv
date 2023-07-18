// Designer : Nakibur Rahman
// Company  : DSi

module alu_dec
  import rv32i_pkg::func_code_t;
  import rv32i_pkg::alu_op_t;
  import rv32i_pkg::ADD_SUB_BEQ;
  import rv32i_pkg::AND;
  import rv32i_pkg::OR;
  import rv32i_pkg::XOR;
  import rv32i_pkg::SLL;
  import rv32i_pkg::ADD_OP;
  import rv32i_pkg::SUB_OP;
  import rv32i_pkg::AND_OP;
  import rv32i_pkg::OR_OP;
  import rv32i_pkg::XOR_OP;
  import rv32i_pkg::SLL_OP;
  import rv32i_pkg::SRA_OP;
  import rv32i_pkg::SRL_OP;
  import rv32i_pkg::BEQ_OP;
(
    input  func_code_t       func_code,
    input  logic             funct7b5,
    input  logic       [1:0] op,
    output alu_op_t          alu_ctrl
);

  // generating alu operation control
  always_comb begin
    if (op == 2'b01) begin
      alu_ctrl = ADD_OP;
    end else if (op == 2'b11) begin
      alu_ctrl = BEQ_OP;
    end else begin
      case (func_code)
        ADD_SUB_BEQ: begin
          if (funct7b5 && (op == 2'b00)) //check if it is R-type because I-type doesn't have sub
		    begin
            alu_ctrl = SUB_OP;
        end else begin
            alu_ctrl = ADD_OP;
          end
        end
        AND: begin
          alu_ctrl = AND_OP;
        end
        OR: begin
          alu_ctrl = OR_OP;
        end
        XOR: begin
          alu_ctrl = XOR_OP;
        end
        SLL: begin
          alu_ctrl = SLL_OP;
        end
        default: begin  // sra and srl type
          if (funct7b5) begin
            alu_ctrl = SRA_OP;
          end else begin
            alu_ctrl = SRL_OP;
          end
        end
      endcase
    end
  end
endmodule

