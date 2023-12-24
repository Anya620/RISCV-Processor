module CSR
(
    input  logic        clk,
    input  logic [31:0] addr,
    input  logic [31:0] data,
    input  logic [31:0] pc,
    input  logic [31:0] inst,
    input  logic        csr_reg_wr,  // CSR write
    input  logic        csr_reg_rd,  // CSR read
    input  logic        check_mret,
    output logic [31:0] rdata,
    output logic [31:0] epc
);

    logic [31:0] csr_mem [5];
    //0 mie
    //1 mstatus
    //2 mip
    //3 mepc
    //4 mtvec
    
    //read
    always_comb 
    begin
        if (check_mret)
            case(inst[31:20])
                12'h341: rdata=csr_mem [3]; 
            endcase
        if( csr_reg_rd)
        case(inst[31:20])
            12'h304: rdata=csr_mem [0];
            12'h300: rdata=csr_mem [1];
            12'h344: rdata=csr_mem [2];
            12'h305: rdata=csr_mem [4]; 
        endcase
    end
    
    //write
    always_ff @(posedge clk) 
    begin
        if (check_mret)
            case(inst[31:20])
                12'h341: csr_mem [3] <= data;
            endcase
        if(csr_reg_wr)
        case(inst[31:20])
            12'h304: csr_mem [0] <= data;
            12'h300: csr_mem [1] <= data;
            12'h344: csr_mem [2] <= data;
            12'h305: csr_mem [4] <= data;
        endcase
    end

endmodule
