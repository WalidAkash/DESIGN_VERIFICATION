module fetch_stage
import rv32i_pkg::DPW;
import rv32i_pkg::ADW;
import rv32i_pkg::ADD_OP;
( 
  input  logic            clk,
  input  logic            regwriteW,
  input  logic            resultsrcW,
  input  logic  [DPW-1:0] aluresultW,
  input  logic  [DPW-1:0] ReadDataW,
  input  logic  [ADW-1:0] RdW,
  input  logic            flushF,
  input  logic            stallF,
  input  logic            PCSrcE,
  input  logic  [DPW-1:0] PCTargetE,
  
  output logic  [DPW-1:0] PCF,
  output logic  [DPW-1:0] resultW

);
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  logic [DPW-1:0] PCNext;
  alu_op_t        opcode = ADD_OP;
  logic [DPW-1:0] PCPlus4;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTL
  //////////////////////////////////////////////////////////////////////////////////////////////////  

  mux2_1
   u1_mux2_1(
    .d0_i (aluresultW),
    .d1_i (ReadDataW),
    .s_i  (resultsrcW),
    .y_o  (resultW)
  );

  adder_sub u_adder_sub (
    .opr_a (PCF),
    .opr_b (32'd4),
    .opcode(opcode),
    .res   (PCPlus4)
  );
  mux2_1
  u2_mux2_1(
   .d0_i (PCPlus4),
   .d1_i (PCTargetE),
   .s_i  (PCSrcE),
   .y_o  (PCNext)
  );

  always_ff@(posedge clk) 
  begin
      if(flushF)
          PCF <= 0;
      else if(!stallF)
          PCF <= PCNext;
  end
endmodule