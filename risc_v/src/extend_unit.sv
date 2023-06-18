// Designer : Walid Akash
// Company : DSi
// Description : This module shifts the instruction by an appropriate amount

module extend_unit
  import rv32i_pkg::*;
(
    input logic [DPW-1:7] instr_ext,
    input logic immsrcD,
    output logic [DPW-1:0] immextD
);

  //-PROCEDURALS

  always_comb begin : extend
    if (!immsrcD) begin  // R-type, I-type ALU, I-type Load
      immextD = {{20{instr_ext[31]}}, instr_ext[31:20]};
    end else if (immsrcD) begin  // S-type
      immextD = {{20{instr_ext[31]}}, instr_ext[31:25], instr_ext[11:7]};
    end else begin  // Undefined
      immextD = 32'hx;
    end
  end

endmodule
