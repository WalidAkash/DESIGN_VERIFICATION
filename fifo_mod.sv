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
logic [2:0] sel;
integer count = 0;

assign full = (wr_ptr[$clog2(Depth)] ^ rd_ptr[$clog2(Depth)]) && (wr_ptr[$clog2(Depth)-1:0] == rd_ptr[$clog2(Depth)-1:0]);

assign empty = (wr_ptr == rd_ptr);

//fifo full indicates din_rdy_o = 0
assign din_rdy_o= !full;

assign dout_val_o = !empty;


always_ff@(posedge clk_i, negedge arst_ni) begin
    case (sel[2:0])
        3'b01:
            begin
                //count  <= (count - 1);
                wr_ptr <= wr_ptr;
                if ((rd_ptr+1)<Depth)
                    rd_ptr <= rd_ptr+1;
                else
                    rd_ptr <= '0;
            end
        3'b10:
            begin
                //count  <= (count +1);
                fifo_memory [wr_ptr] <= din_i;                    
                if ((wr_ptr+1)<Depth)
                    wr_ptr <= wr_ptr+1;
                else
                    wr_ptr <= '0;
                rd_ptr <= rd_ptr;
            end
        3'b11: begin
            //count  <= count;
            fifo_memory [wr_ptr] <= din_i;
            if ((wr_ptr+1)<Depth)
                wr_ptr <= wr_ptr+1;
            else
                wr_ptr <= '0;
            if ((rd_ptr+1)<Depth)
                rd_ptr <= rd_ptr+1;
            else
                rd_ptr <= '0;
            end
        default:
            begin
                //count  <= count;
                wr_ptr <= wr_ptr;
                rd_ptr <= rd_ptr;
            end
    endcase
end
//fall through reads, combinational reads
assign dout_o = fifo_memory[rd_ptr];

endmodule
