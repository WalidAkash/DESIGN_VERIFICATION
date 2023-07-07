// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module tb_writeback_stage_reg;
import rv32i_pkg::*;
  logic clk;
  logic regwriteM;
  logic resultsrcM;
  logic [DPW-1:0] aluresultM;
  logic [DPW-1:0]ReadDataM;
  logic [4:0] RdM;
  logic regwriteW;
  logic resultsrcW;
  logic [DPW-1:0]resultW;
  logic [4:0] RdW;

  writeback_stage_reg
  u_writeback_stage_reg
  (
    .clk         (clk),
    .regwriteM   (regwriteM),
    .resultsrcM  (resultsrcM),
    .aluresultM  (aluresultM),
    .ReadDataM   (ReadDataM),
    .RdM         (RdM),
    .regwriteW   (regwriteW),
    .resultsrcW  (resultsrcW),
    .resultW     (resultW),
    .RdW         (RdW)
);

  task start_tclk ();
  fork
      forever begin
          clk = 1; #5;
          clk = 0; #5;
      end
  join_none
  endtask
  
  initial begin
  $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
  $dumpfile("raw.vcd");
  $dumpvars;
  
  end
  
  final begin
  $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
  end
  
  initial 
  begin
    start_tclk ();
    @(negedge clk);
    regwriteM =$urandom;
    resultsrcM =$urandom;
    aluresultM =$urandom;
    ReadDataM =$urandom;
    RdM =$urandom;
    @(negedge clk);
    regwriteM =$urandom;
    resultsrcM =$urandom;
    aluresultM =$urandom;
    ReadDataM =$urandom;
    RdM =0;
    @(negedge clk);
    resultsrcM =1;
    aluresultM =5;
    ReadDataM =2;
    @(negedge clk);
    @(negedge clk);
    resultsrcM =0;
    aluresultM =5;
    ReadDataM =2;
  
    repeat(5) @(negedge clk);
    $finish;
  end
endmodule