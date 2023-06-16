// Designer : Walid Akash
// Company : DSi
// Description : Execute stage pipeline register testbench

module tb_execute_stage();

execute_stage 
execute_stage_dut (
  .clk (clk ),
  .regwriteE (regwriteE ),
  .resultsrcE (resultsrcE ),
  .memwriteE (memwriteE ),
  .aluresultE (aluresultE ),
  .Rd2E (Rd2E ),
  .RdE (RdE ),
  .regwriteM (regwriteM ),
  .resultsrcM (resultsrcM ),
  .memwriteM (memwriteM ),
  .aluresultM (aluresultM ),
  .Rd2M (Rd2M ),
  .RdM  ( RdM)
);
