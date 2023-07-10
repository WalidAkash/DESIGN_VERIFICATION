// Designer : Walid Akash
// Company : DSi
// Description : Top module for decode stage, Execute stage and Memory Stage

module top
  import rv32i_pkg::*;
#(
    parameter int ADW = 5
) (
    // Input Ports
    input  logic           clk,
    input  logic           flushF,
    input  logic           stallF,
    input  logic [DPW-1:0] PCNext,

    // Output Ports
    //-For test purpose ports
    output logic [DPW-1:0] PCF,
    output logic [DPW-1:0] instr,

    output logic [DPW-1:0] aluresultM,
    output logic [DPW-1:0] Rd2M,
    output logic           memwriteM,
    output logic [DPW-1:0] rd
    
);

  ///////////////////////////////////////////////////////////////////////////  ///////////////////////
  //-LOCALPARAMS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  localparam     int ElemWidth = 8;
  localparam     int Depth = 120;

  ///////////////////////////////////////////////////////////////////////////  ///////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////
 
    logic            stallD;
    logic            flushD;

    logic  [DPW-1:0] instrD;
    logic  [DPW-1:0] PCD;

    instr_type_t     instr_type;
    func_code_t      func_code;
    logic            funct7b5;
    logic  [ADW-1:0] addr_1;
    logic  [ADW-1:0] addr_2;
    logic      [4:0] RdD;
    logic  [DPW-1:7] instr_ext;

    logic            branchD;
    logic            resultsrcD;
    logic            memwriteD;
    logic            alusrcD;
    logic      [1:0] immsrcD;
    logic            regwriteD;
    alu_op_t         alu_ctrlD;

    logic  [DPW-1:0] rd_1;
    logic  [DPW-1:0] rd_2;
    /* logic  [ADW-1:0] addr_3;
    logic            we_3;      // write enable
    logic  [DPW-1:0] wd_3; */

    logic  [DPW-1:0] immextD;

    logic            flushE = 0;   // For test purpose

    logic            resultsrcE;
    logic            memwriteE;
    logic            branchE;
    logic            alusrcE;
    logic            regwriteE;
    alu_op_t         alu_ctrlE;
    logic  [DPW-1:0] srcA;
    logic  [DPW-1:0] Rd2E;
    logic  [ADW-1:0] RdE;
    logic  [DPW-1:0] immextE;
    logic  [DPW-1:0] PCE;
    logic  [DPW-1:0] srcB;
    logic  [DPW-1:0] aluresultE;

    logic            regwriteM;
    logic            resultsrcM;

    /* logic            memwriteM;
    logic  [DPW-1:0] aluresultM;
    logic  [DPW-1:0] Rd2M;
    logic      [4:0] Rd;

    logic  [DPW-1:0] rd; */

    logic            regwriteW;
    logic            resultsrcW;
    logic  [DPW-1:0] resultW;
    logic      [4:0] RdW;
  
  

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-DUT INSTANTIATIONS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // Fetch stage pipeline register

  fetch_stage_reg 
  u_fetch_stage_reg (
    .clk (clk ),
    .flushF (0 ),
    .stallF (0 ),
    .PCNext (PCNext ),
    .PCF  ( PCF)
  );

  // I-cache 

  i_cache #(
    .ElemWidth(ElemWidth ),
    .Depth (Depth )
  )
  i_cache_dut (
    .PCF (PCF ),
    .instr  ( instr)
  );



  // Decode stage pipeline reg DUT Instantiation
    decode_stage_reg 
    #(
    .DPW (
        DPW )
    )
    u_decode_stage_reg (
    .clk (clk ),
    .stallD (0 ),
    .flushD (0 ),
    .instr (instr ),
    .PCF (PCF ),
    .instrD (instrD ),
    .PCD  ( PCD)
    );

    // Instruction assign unit DUT Instantiation
    instr_assign_unit 
    #(
      .ADW (
          ADW )
    )
    u_instr_assign_unit (
      .instrD (instrD ),
      .instr_type (instr_type ),
      .func_code (func_code ),
      .funct7b5 (funct7b5 ),
      .addr_1 (addr_1 ),
      .addr_2 (addr_2 ),
      .RdD (RdD ),
      .instr_ext  ( instr_ext)
    );

    // Control Unit DUT Instantiation
    control_unit 
    u_control_unit (
      .instr_type (instr_type ),
      .func_code (func_code ),
      .funct7b5 (funct7b5 ),
      .branch (branchD ),
      .resultsrc (resultsrcD ),
      .memwrite (memwriteD ),
      .alusrc (alusrcD ),
      .immsrc (immsrcD ),
      .regwrite (regwriteD ),
      .alu_ctrl  ( alu_ctrlD)
    );
  
    // Reg File DUT Instantiation
    reg_file 
    #(
      .ADW(ADW ),
      .DPW (
          DPW )
    )
    u_reg_file (
      .clk (clk ),
      .addr_1 (addr_1 ),
      .addr_2 (addr_2 ),
      .addr_3 (RdW ),
      .we_3 (regwriteW ),
      .wd_3 (resultW ),
      .rd_1 (rd_1 ),
      .rd_2  ( rd_2)
    );

    // Extend Unit DUT Instantiation
    extend_unit 
    u_extend_unit (
      .instr_ext (instr_ext ),
      .immsrcD (immsrcD ),
      .immextD  ( immextD)
    );

    // Execute Stage Pipeline reg DUT Instantiation
    execute_stage_reg 
    #(
      .ADW (
          ADW )
    )
    u_execute_stage_reg (
      .clk (clk ),
      .resultsrcD (resultsrcD ),
      .memwriteD (memwriteD ),
      .branchD (branchD ),
      .alu_ctrlD (alu_ctrlD ),
      .alusrcD (alusrcD ),
      .regwriteD (regwriteD ),
      .rd_1 (rd_1 ),
      .rd_2 (rd_2 ),
      .RdD (RdD ),
      .immextD (immextD ),
      .PCD (PCD ),
      .flushE (0 ),
      .resultsrcE (resultsrcE ),
      .memwriteE (memwriteE ),
      .branchE (branchE ),
      .alusrcE (alusrcE ),
      .regwriteE (regwriteE ),
      .alu_ctrlE (alu_ctrlE ),
      .srcA (srcA ),
      .Rd2E (Rd2E ),
      .RdE (RdE ),
      .immextE (immextE ),
      .PCE  ( PCE)
    );

    // MUX DUT Instantiation
    mux2_1 
    u_mux2_1 (
      .d0_i (Rd2E),
      .d1_i (immextE ),
      .s_i  (alusrcE ),
      .y_o  (srcB)
    );
  
    // ALU DUT Instantiation
    alu 
    u_alu (
      .opr_a      (srcA ),
      .opr_b      (srcB ),
      .opcode     (alu_ctrlE ),
      .res        (aluresultE),
      .zero_flag  ( zero_flag)
    );

    branch_unit 
    u_branch_unit (
      .PCF       (PCE ),
      .immextE   (immextE ),
      .branchE   (branchE ),
      .zero_flag (zero_flag ),
      .PCNext    ( PCNext),
      .PCSrcE    (PCSrcE)
    );
  
  
    // Memory stage pipeline reg DUT Instantiation
    memory_stage_reg 
    u_memory_stage_reg (
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

    // D-cache 
    d_cacahe #(
      .ElemWidth(ElemWidth ),
      .Depth (Depth )
    )
    u_d_cacahe (
      .clk (clk ),
      .addr (aluresultM ),
      .wd (Rd2M ),
      .we (memwriteM ),
      .rd  ( rd)
    );

    writeback_stage_reg 
    u_writeback_stage_reg (
      .clk (clk ),
      .regwriteM (regwriteM ),
      .resultsrcM (resultsrcM ),
      .aluresultM (aluresultM ),
      .ReadDataM (rd ),
      .RdM (RdM ),
      .regwriteW (regwriteW ),
      .resultsrcW (resultsrcW ),
      .resultW (resultW ),
      .RdW  ( RdW)
    );
  
  

    // Hazard Unit DUT Instantiation
  /*   hazard_unit 
    u_hazard_unit (
      .clk (clk ),
      .regwriteE (regwriteE ),
      .Rs1D (addr_1 ),
      .Rs2D (addr_2 ),
      .RdE (RdE ),
      .RdM (RdM ),
      .PCSrcE (PCSrcE ),
      .stallF (stallF ),
      .flushF (flushF ),
      .stallD (stallD ),
      .flushD (flushD ),
      .flushE  ( flushE)
    );  
 */
endmodule
