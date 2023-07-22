// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module writeback_stage
  import rv32i_pkg::DPW;
  import rv32i_pkg::ADW;
(
    input  logic           clk,
    input  logic           regwriteM,
    input  logic           resultsrcM,
    input  logic           memwriteM,
    input  logic [DPW-1:0] aluresultM,
    input  logic [DPW-1:0] Rd2M,
    input  logic [ADW-1:0] RdM,
    input  logic           data_en,       //for writing inside d_cache
    input  logic [DPW-1:0] input_data,
    input  logic [DPW-1:0] input_addr,
    output logic [DPW-1:0] output_check,
    output logic           regwriteW,
    output logic           resultsrcW,
    output logic [DPW-1:0] aluresultW,
    output logic [DPW-1:0] ReadDataW,
    output logic [    4:0] RdW,
    output logic [DPW-1:0] rd
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PARAMETERS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  parameter int ElemWidth = 8;  //for d_cache
  parameter int Depth = 120;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  d_cache #(
      .ElemWidth(ElemWidth),
      .Depth    (Depth)
  ) u_d_cache (
      .clk (clk),
      .addr(aluresultM),
      .wd  (Rd2M),
      .we  (memwriteM),

      .data_en     (data_en),
      .input_data  (input_data),
      .input_addr  (input_addr),
      .output_check(output_check),
      .rd          (rd)
  );

  always @(posedge clk) begin
    regwriteW  <= regwriteM;
    resultsrcW <= resultsrcM;
    aluresultW <= aluresultM;
    ReadDataW  <= rd;
    RdW        <= RdM;

  end


endmodule
