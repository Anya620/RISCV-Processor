module inst_mem(
    input  logic [31:0] addr,
    output logic [31:0] data //this is inst which will be output

);

    logic [31:0] mem [100];

    //asynchrounos data read
    always_comb
    begin
        data = mem[addr[31:2]];
        
    end
endmodule