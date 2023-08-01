// Designer : Walid Akash
// Company : DSi
// Description : This module shifts the instruction by an appropriate amount

module extend_unit
  import rv32i_pkg::DPW;
(
    input  logic           clk,
    input  logic [DPW-1:7] instr_ext,
    input  logic [    1:0] immsrcD,
    output logic [DPW-1:0] immextD
);

  //-PROCEDURALS

  always_ff @(posedge clk) begin : extend
    case (immsrcD)
      2'b00: begin  // R-type, I-type ALU, I-type Load
        immextD <= {{20{instr_ext[31]}}, instr_ext[31:20]};
      end

      2'b01: begin  //S-type
        immextD <= {{20{instr_ext[31]}}, instr_ext[31:25], instr_ext[11:7]};
      end

      2'b10: begin  // B-type
        immextD <= {{20{instr_ext[31]}}, instr_ext[7], instr_ext[30:25], instr_ext[11:8], 1'b0};
      end

      default: begin  // Undefined
        immextD <= 32'hx;
      end
    endcase
  end

endmodule
