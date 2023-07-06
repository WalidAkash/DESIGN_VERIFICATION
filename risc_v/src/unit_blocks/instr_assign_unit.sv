// Designer : Walid Akash
// Company : DSi

module instr_assign_unit
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    input logic [DPW-1:0] instrD,

    output instr_type_t           instr_type,
    output func_code_t            func_code,
    output logic                  funct7b5,
    output logic        [ADW-1:0] addr_1,
    output logic        [ADW-1:0] addr_2,
    output logic        [    4:0] RdD,
    output logic        [DPW-1:7] instr_ext
);

//-PROCEDURALS

  always_comb begin
    $cast(instr_type, instrD[6:0]);
    $cast(func_code, instrD[14:12]);
    funct7b5 = instrD[30];
    addr_1 = instrD[19:15];
    addr_2 = instrD[24:20];
    RdD = instrD[11:7];
    instr_ext = instrD[DPW-1:7];
  end

endmodule
