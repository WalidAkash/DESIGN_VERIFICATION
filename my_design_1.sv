module fifo_mod #(DataWidth = 16, Depth = 8)
(
    input logic clk_i,
    input logic arst_ni,

    //write interface
    input logic [DataWidth-1:0] din_i,
    input logic din_val_i,
    output logic din_rdy_o,

    //read interface
    output logic [DataWidth-1:0] dout_o,
    output logic dout_val_o,
    input logic dout_rdy_i
);

logic [DataWidth-1:0] fifo_memory[Depth-1:0];

//extra bit to keep track of full/empty
logic [$clog2(Depth):0] wr_ptr, rd_ptr;
logic full, empty;
logic din_hs, dout_hs;

assign full = (wr_ptr[$clog2(Depth)] ^ rd_ptr[$clog2(Depth)]) && (wr_ptr[$clog2(Depth)-1:0] == rd_ptr[$clog2(Depth)-1:0]);

assign empty = (wr_ptr == rd_ptr);

//fifo full indicates din_rdy_o = 0
assign din_rdy_o= !full;

assign dout_val_o = !empty;


//handhsakes
//input side handshake
assign din_hs = din_val_i && din_rdy_o;  
//output side handshake   
assign dout_hs = dout_val_o && dout_rdy_i;
//input/output both side handshake
assign din_out_hs = din_val_i && din_rdy_o && dout_val_o && dout_rdy_i;
//No handshake
assign no_hs = din_val_i || din_rdy_o || dout_val_o || dout_rdy_i;



always_ff@(posedge clk_i, negedge arst_ni) begin
    if (!arst_ni) begin
        wr_ptr <= '0;
        for (int i = 1; i<Depth; i++) begin
            fifo_memory[i] <= '0;
        end
        rd_ptr <= '0;
    end
    //input side handshake operation
    else if (din_hs) begin
        fifo_memory[wr_ptr] <= din_i;
        wr_ptr <= wr_ptr + 1'b1;
    end
    //output side handshake operation
    else if (dout_hs) begin
        rd_ptr <= rd_ptr + 1'b1;
    end
    //input/output both side handshake operation
    else if (din_out_hs) begin
        fifo_memory[wr_ptr] <= din_i;
        wr_ptr <= wr_ptr + 1'b1;
        rd_ptr <= rd_ptr + 1'b1;
    end
    //No handshake operation
    else if (no_hs) begin
        wr_ptr <= wr_ptr;
        rd_ptr <= rd_ptr;
    end
end

//fall through reads, combinational reads
assign dout_o = fifo_memory[rd_ptr];

endmodule
