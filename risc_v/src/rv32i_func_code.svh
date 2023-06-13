typedef enum logic [2:0] {
    ADD_SUB = 3'b000,
    AND     = 3'b111,
    OR      = 3'b110,
    XOR     = 3'b100,
    //LS      = 3'b010,
    SLL     = 3'b001,
    SRL_A   = 3'b101
} func_code_t;
