// Designer : Walid Akash
// Company : DSi
// Description : This module shifts the instruction by an appropriate amount

module extend_unit (
    input logic [31:7] instr,
    input logic immsrc,
    output logic [31:0] immext
);

  //-PROCEDURALS

  always_comb begin : extend
    if (!immsrc) begin  // R-type, I-type ALU, I-type Load
      immext = {{20{instr[31]}}, instr[31:20]};
    end else if (immsrc) begin  // S-type
      immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    end else begin  // Undefined
      immext = 32'hx;
    end
  end

endmodule
