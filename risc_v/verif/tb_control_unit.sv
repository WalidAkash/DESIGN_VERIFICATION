module tb_control_unit ();

  import rv32i_pkg::instr_type_t;
  import rv32i_pkg::func_code_t;
  import rv32i_pkg::alu_op_t;

  typedef struct packed {
    instr_type_t instr;
    func_code_t  func;
    logic        funct;
  } req_t;

  typedef struct packed {
    logic    resultsrc;
    logic    memwrite;
    logic    alusrc;
    logic    immsrc;
    logic    regwrite;
    alu_op_t alu_ctrl;
  } rsp_t;

  req_t req;
  rsp_t rsp;

  control_unit u_control_unit (
      .instr_type(req.instr),
      .func_code (req.func),
      .funct7b5  (req.funct),
      .resultsrc (rsp.resultsrc),
      .memwrite  (rsp.memwrite),
      .alusrc    (rsp.alusrc),
      .immsrc    (rsp.immsrc),
      .regwrite  (rsp.regwrite),
      .alu_ctrl  (rsp.alu_ctrl)
  );


  initial begin
    $dumpfile("tb_control_unit.vcd");
    $dumpvars(0, tb_control_unit);
    $display("test start");

    for (int i = 0; i < 10; i++) begin
      std::randomize(
          req.instr
      ) with {
        req.instr inside {3, 19, 35, 51};
      };
      std::randomize(
          req.func
      ) with {
        req.func inside {0, 1, 4, 5, 6, 7};
      };
      std::randomize(
          req.funct
      ) with {
        req.funct inside {0, 1};
      };
      #10;
    end
    $finish;
  end

endmodule

