//  ### Author : Walid Akash (walidakash070@gmail.com)

module xbar #(
    parameter int ElemWidth = 8,  // Width of each element
    parameter int NumElem   = 6   // Number of elements in the crossbar
) (
    input logic [NumElem-1:0][$clog2(NumElem)-1:0] select_i,
    input logic [NumElem-1:0][ElemWidth-1:0] inputs_i,
    output logic [NumElem-1:0][ElemWidth-1:0] outputs_o
);


  always_comb begin : assign_output
    for (int i = 0; i < NumElem; i++) begin
      outputs_o[i] = (select_i[i] < NumElem) ? inputs_i[select_i[i]] : inputs_i[select_i[i]-NumElem];
    end
  end
endmodule
