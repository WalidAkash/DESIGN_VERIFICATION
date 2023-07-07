// ### Author : Razu Ahamed(en.razu.ahamed@gmail.com)
// ### Company: DSi
module tb_fetch_stage;
import rv32i_pkg::*;
  logic           clk    ;
  logic           FlushF ;
  logic           stallF ;
  logic [DPW-1:0] PCNext ;
  logic [DPW-1:0] PCF    ;

  fetch_stage 
  u_fetch_stage (
    .clk    (clk ),
    .FlushF (FlushF ),
    .stallF (stallF ),
    .PCNext (PCNext ),
    .PCF    ( PCF)
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
    PCNext <= $urandom;
    FlushF <= 0;
    stallF <= 0;
    @(negedge clk);
    PCNext <= $urandom;
    FlushF <= 0;
    stallF <= 1;
    @(negedge clk);
    PCNext <= $urandom;
    FlushF <= 1;
    stallF <= 0;
    @(negedge clk);
    PCNext <= $urandom;
    FlushF <= 1;
    stallF <= 1;
    @(negedge clk);
    PCNext <= $urandom;
    FlushF <= 0;
    stallF <= 0;
    @(negedge clk);
    PCNext <= $urandom;
    FlushF <= 1;
    stallF <= 1;
    repeat(5) @(negedge clk);
    $finish;
  end


endmodule
