module br_cond
(
    input  logic [31:0] rdata1,
    input  logic [31:0] rdata2,
    input  logic [ 2:0] br_type,
    output logic        br_taken
);

    parameter EQUAL            = 3'b000; // BEQ
    parameter NOT_EQUAL        = 3'b001; // BNE
    parameter LESS_THAN        = 3'b100; // BLT
    parameter GREATER_EQ       = 3'b101; // BGE
    parameter LESS_THAN_U      = 3'b110; // BLTU
    parameter GREATER_EQ_U     = 3'b111; // BGEU

    // Combinational logic to determine branch decision
    always_comb
    begin
        case (br_type)
            EQUAL: 
                br_taken = (rdata1 == rdata2) ? 1'b1 : 1'b0;
            NOT_EQUAL: 
                br_taken = (rdata1 != rdata2) ? 1'b1 : 1'b0;
            LESS_THAN: 
                br_taken = ($signed(rdata1) < $signed(rdata2)) ? 1'b1 : 1'b0;
            GREATER_EQ: 
                br_taken = ($signed(rdata1) >= $signed(rdata2)) ? 1'b1 : 1'b0;
            LESS_THAN_U: 
                br_taken = (rdata1 < rdata2) ? 1'b1 : 1'b0;
            GREATER_EQ_U: 
                br_taken = (rdata1 >= rdata2) ? 1'b1 : 1'b0;
            default: 
                br_taken = 1'b0;
        endcase
    end

endmodule
