// Designer : Walid Akash (walidakash070@gmail.com)
// Company : DSi

module decode_stage
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
  import rv32i_pkg::ElemWidth;
  import rv32i_pkg::Depth;
(
    input  logic           clk,
    input  logic [DPW-1:0] PCF,
    input  logic           flushD,
    input  logic           stallD,
    output logic [DPW-1:0] instrD,
    output logic [DPW-1:0] PCD
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOGIC
  //////////////////////////////////////////////////////////////////////////////////////////////////

  logic [DPW-1:0] instr;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTL
  //////////////////////////////////////////////////////////////////////////////////////////////////

  i_cache u_i_cache (
      .PCF  (PCF),
      .instr(instr)
  );

  always_ff @(posedge clk) begin
    if (flushD) instrD <= 0;
    PCD <= 0;
    if (!stallD) instrD <= instr;
    PCD <= PCF;
  end

endmodule
