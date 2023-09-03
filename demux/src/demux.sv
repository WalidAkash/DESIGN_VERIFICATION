// ### Author : Walid Akash (walidakash070@gmail.com)
/////////////////////////////////////////////////////////////////

module demux #(
  parameter int NUM_ELEM = 4
  ) (
  input logic [$clog2(NUM_ELEM)-1:0] s_i,  // Ouput select port
  input logic i_i,  // Input data port
  output logic [NUM_ELEM-1:0] o_o  // Array of Output
);

//-SIGNALS
////////////////////////////////////////////////////////////////

logic [$clog2(NUM_ELEM)-1:0] s_n;
logic [$clog2(NUM_ELEM):0] output_and_red[NUM_ELEM];

//-ASSIGNMENTS
///////////////////////////////////////////////////////////////

assign s_n = ~s_i;

always_comb begin : demux_comb
  for (bit [$clog2(NUM_ELEM):0] i = 0; i< NUM_ELEM; i++) begin
    for (int j = 0; j < $clog2(NUM_ELEM); j++) begin
      output_and_red[i][j] = i[j] ? s_i[j] : s_n[j];
    end
    output_and_red[i][$clog2(NUM_ELEM)] = i_i;
  end
end

for (genvar i = 0; i < NUM_ELEM; i++) begin
   assign o_o[i] = &output_and_red[i];
end
  
endmodule
