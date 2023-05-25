// ### Author : Walid Akash

module fifo #(
    parameter int Datawidth = 16,  // Width of Data
    parameter int Depth = 8  // Number of elements that can be stored in the fifo
) (
    input logic clk_i,
    input logic arst_ni,

    // write ports
    input logic [Datawidth-1:0] data_in_i,
    input logic data_in_valid_i,
    output logic data_in_ready_o,

    // read ports
    output logic [Datawidth-1:0] data_out_o,
    output logic data_out_valid_o,
    input logic data_out_ready_i
);

  //-SIGNALS

  logic [Datawidth-1:0] fifo_mem[Depth];  // Memory of the fifo
  logic [$clog2(Depth):0] wr_ptr;
  logic [$clog2(Depth):0] rd_ptr;

  logic [$clog2(Depth):0] wr_ptr_next;
  logic [$clog2(Depth):0] rd_ptr_next;

  logic [$clog2(Depth):0] str_count;  // Number of elements stored in the fifo currently

  logic data_in_hs;  // Input side handshake
  logic data_out_hs;  // Output side handshake

  //-ASSIGNMENTS

  assign data_in_hs = data_in_valid_i && data_in_ready_o;
  assign data_out_hs = data_out_valid_o && data_out_ready_i;

  assign data_in_ready_o = (str_count == Depth) ? data_out_ready_i : '1;
  assign data_out_valid_o = (str_count == 0) ? data_in_valid_i : '1;

  assign wr_ptr_next = ((wr_ptr + 1'b1) == Depth) ? '0 : wr_ptr + '1;
  assign rd_ptr_next = ((rd_ptr + 1'b1) == Depth) ? '0 : rd_ptr + '1;

  assign data_out_o = str_count ? fifo_mem[rd_ptr] : data_in_i;

  // Update memory pointers and ports

  always_ff @(posedge clk_i or negedge arst_ni) begin : main
    if (~arst_ni) begin : do_reset
      str_count <= '0;
      wr_ptr <= '0;
      rd_ptr <= '0;
    end else begin
      case ({
        data_in_hs, data_out_hs
      })
        2'b11: begin  // bothside handshake
          str_count <= str_count;
          rd_ptr <= rd_ptr_next;
          wr_ptr <= wr_ptr_next;
        end
        2'b10: begin  // Input side handshake
          str_count <= str_count + '1;
          wr_ptr <= wr_ptr_next;
          rd_ptr <= rd_ptr;
        end
        2'b01: begin  // Output side handshake
          str_count <= str_count - '1;
          wr_ptr <= wr_ptr;
          rd_ptr <= rd_ptr_next;
        end
        default: begin  // No handshake
          str_count <= str_count;
          rd_ptr <= rd_ptr;
          wr_ptr <= wr_ptr;
        end
      endcase
      if (data_in_hs) begin
        fifo_mem[wr_ptr] <= data_in_i;
      end
    end

  end

endmodule
