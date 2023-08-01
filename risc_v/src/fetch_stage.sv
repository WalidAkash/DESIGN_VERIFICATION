// Designer : Walid Akash (walidakash070@gmail.com)
// Company : DSi

module fetch_stage
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
  import rv32i_pkg::ADD_OP;
(
    input  logic           clk,
    input  logic           resultsrcW,
    input  logic [DPW-1:0] aluresultW,
    input  logic [DPW-1:0] ReadDataW,
    input  logic [ADW-1:0] RdW,
    input  logic           flushF,
    input  logic           stallF,
    input  logic [DPW-1:0] PCNext,
    output logic [DPW-1:0] PCF,
    output logic [DPW-1:0] resultW
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTL
  //////////////////////////////////////////////////////////////////////////////////////////////////

  mux_2 u1_mux_2 (
      .d0_i(aluresultW),
      .d1_i(ReadDataW),
      .s_i (resultsrcW),
      .y_o (resultW)
  );

  always_ff @(posedge clk) begin
    if (flushF) PCF <= 0;
    else if (!stallF) PCF <= PCNext;
  end
endmodule
