// Designer : Nakibur Rahman
// Company  : DSi

module instr_dec
  import rv32i_pkg::instr_type_t;
  import rv32i_pkg::R_TYPE;
  import rv32i_pkg::I_TYPE_LOAD;
  import rv32i_pkg::I_TYPE_ALU;
(
    input  instr_type_t       instr_type,
    output logic              resultsrc,
    output logic              memwrite,
    output logic              alusrc,
    output logic              immsrc,
    output logic        [1:0] op,
    output logic              regwrite
);

  // Generating the control signals

  always_comb begin
    immsrc = 0;
    case (instr_type)
      R_TYPE: begin
        resultsrc = 0;
        memwrite  = 0;
        alusrc    = 0;
        regwrite  = 1;
        op        = 2'b00;
      end

      I_TYPE_LOAD: begin
        resultsrc = 1;
        memwrite  = 0;
        alusrc    = 1;
        regwrite  = 1;
        op        = 2'b01;
      end

      I_TYPE_ALU: begin
        resultsrc = 0;
        memwrite  = 0;
        alusrc    = 1;
        regwrite  = 1;
        op        = 2'b10;
      end

      default: begin  // S type for store
        resultsrc = 0;
        memwrite  = 1;
        alusrc    = 1;
        regwrite  = 0;
        immsrc    = 1;
        op        = 2'b01;
      end
    endcase
  end
endmodule
