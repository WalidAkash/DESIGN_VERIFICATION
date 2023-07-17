// ### Author : Walid Akash (walidakash070@gmail.com)
// ### Company : DSi

module tb_control_unit ();

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS

  import rv32i_pkg::instr_type_t;
  import rv32i_pkg::func_code_t;
  import rv32i_pkg::alu_op_t;
  import rv32i_pkg::R_TYPE;
  import rv32i_pkg::I_TYPE_LOAD;
  import rv32i_pkg::I_TYPE_ALU;
  import rv32i_pkg::B_TYPE;
  import rv32i_pkg::ADD_SUB_BEQ;
  import rv32i_pkg::AND;
  import rv32i_pkg::OR;
  import rv32i_pkg::XOR;
  import rv32i_pkg::SLL;
  import rv32i_pkg::ADD_OP;
  import rv32i_pkg::SUB_OP;
  import rv32i_pkg::AND_OP;
  import rv32i_pkg::OR_OP;
  import rv32i_pkg::XOR_OP;
  import rv32i_pkg::SLL_OP;
  import rv32i_pkg::SRA_OP;
  import rv32i_pkg::SRL_OP;
  import rv32i_pkg::BEQ_OP;

  `include "../include/tb_ess.sv"

  typedef struct packed {
    instr_type_t instr;
    func_code_t  func;
    logic        funct;
  } req_t;

  typedef struct packed {
    logic          branch;
    logic          resultsrc;
    logic          memwrite;
    logic          alusrc;
    logic    [1:0] immsrc;
    logic          regwrite;
    alu_op_t       alu_ctrl;
  } rsp_t;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS

  req_t req;
  rsp_t rsp;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-VARIABLES

  int     error = 0;
  logic [1:0] op;


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS

  control_unit u_control_unit (
      .instr_type(req.instr),
      .func_code (req.func),
      .funct7b5  (req.funct),
      .branch    (rsp.branch),
      .resultsrc (rsp.resultsrc),
      .memwrite  (rsp.memwrite),
      .alusrc    (rsp.alusrc),
      .immsrc    (rsp.immsrc),
      .regwrite  (rsp.regwrite),
      .alu_ctrl  (rsp.alu_ctrl)
  );

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS

  initial begin

    for (int i = 0; i < 50; i++) begin
      std::randomize(
          req.instr
      ) with {
        req.instr inside {3, 19, 35, 51, 99};
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

      $display("Test-%p", i);
      $display("instr_type = %p", req.instr);
      $display("funct_code = %p", req.func);
      $display("funct7b5 = %p", req.funct);

      case (req.instr)  // Testing the instruction decoder
        R_TYPE: begin
          if ((rsp.immsrc == 2'b00) && (rsp.resultsrc == 0) && (rsp.memwrite == 0) && (rsp.alusrc == 0)
          && (rsp.regwrite == 1) && (rsp.branch == 0)) begin
            error = error;
          end else begin
            error++;
          end
          op = 2'b00;
        end

        I_TYPE_LOAD: begin
          if ((rsp.immsrc == 2'b00) &&(rsp.resultsrc == 1) && (rsp.memwrite == 0) && (rsp.alusrc == 1)
          && (rsp.regwrite == 1) && (rsp.branch == 0)) begin
            error = error;
          end else begin
            error++;
          end
          op = 2'b01;
        end

        I_TYPE_ALU: begin
          if ((rsp.immsrc == 2'b00) &&(rsp.resultsrc == 0) && (rsp.memwrite == 0) && (rsp.alusrc == 1)
          && (rsp.regwrite == 1) && (rsp.branch == 0)) begin
            error = error;
          end else begin
            error++;
          end
          op = 2'b10;
        end

        B_TYPE: begin
          if ((rsp.immsrc == 2'b10) &&(rsp.resultsrc == 0) && (rsp.memwrite == 0) && (rsp.alusrc == 0)
          && (rsp.regwrite == 0) && (rsp.branch == 1)) begin
            error = error;
          end else begin
            error++;
            $display("error B = %p", error);
            $display("immsrc = %p", rsp.immsrc);
            $display("resultsrc = %p", rsp.resultsrc);
            $display("memwrite = %p", rsp.memwrite);
            $display("alusrc = %p", rsp.alusrc);
            $display("regwrite = %p", rsp.regwrite);
          end
          op = 2'b11;
        end

        default: begin
          if ((rsp.immsrc == 2'b01) &&(rsp.resultsrc == 0) && (rsp.memwrite == 1) && (rsp.alusrc == 1)
          && (rsp.regwrite == 0) && (rsp.branch == 0)) begin
            error = error;
          end else begin
            error++;
          end
          op = 2'b01;
        end
      endcase

      $display("op = %b", op);
      // Testing ALU Decoder
      if ((op == 2'b01) && (rsp.alu_ctrl == ADD_OP)) begin
        error = error;
      end else if ((op == 2'b11) && (rsp.alu_ctrl == BEQ_OP)) begin
        error = error;
        $display("error BEQ = %p", error);
      end else begin
        case (req.func)
          ADD_SUB_BEQ: begin
            if (req.funct && (rsp.alu_ctrl == SUB_OP)) begin
              error = error;
              $display("error SUB = %p", error);
            end else if (rsp.alu_ctrl != ADD_OP) begin
              error++;
              $display("error ADD = %p", error);
            end
          end

          AND: begin
            if (rsp.alu_ctrl != AND_OP) begin
              error++;
              $display("error AND = %p", error);
            end
          end

          OR: begin
            if (rsp.alu_ctrl != OR_OP) begin
              error++;
              $display("error OR = %p", error);
            end
          end

          XOR: begin
            if (rsp.alu_ctrl != XOR_OP) begin
              error++;
              $display("error XOR = %p", error);
            end
          end

          SLL: begin
            if (rsp.alu_ctrl != SLL_OP) begin
              error++;
              $display("error SLL = %p", error);
            end
          end

          default: begin
            if ((req.funct == 1'b1) && (rsp.alu_ctrl == SRA_OP)) begin
              error = error;
            end else if (rsp.alu_ctrl == SRL_OP) begin
              error = error;
            end else begin
              error++;
            end
          end
        endcase
      end

      $display("alu_ctrl = %p", rsp.alu_ctrl);

      $display("error = %p \n", error);

    end

    result_print(error == 0, "Control Unit Verified");
    $finish;
  end

endmodule

