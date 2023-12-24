module controller(
    input  logic [ 6:0] funct7,
    input  logic [ 6:0] opcode,
    input  logic [ 2:0] funct3,
    input  logic        br_taken,
    input  logic [31:0] inst,
    output logic [ 3:0] aluop,
    output logic [ 1:0] wb_sel,
    output logic [ 2:0] mem_acc_mode,
    output logic [ 2:0] br_type,
    output logic        epc_taken,
    output logic        sel_a,
    output logic        sel_b,
    output logic        rd_en,
    output logic        wr_en,
    output logic        rf_en,  
    output logic        br_decision,
    output logic        check_mret,
    output logic        csr_reg_rd,
    output logic        csr_reg_wr
    
);

    always_comb
    begin
        case(opcode)
        // R- Type
            7'b0110011:
            begin
                sel_a        = 1'b1;
                sel_b        = 1'b0;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b0;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                mem_acc_mode = 3'b111;
                //check funct3 then funct7 to figure out operation
                case(funct3)
                    3'b000:
                    begin
                        case(funct7)
                            7'b0000000: aluop = 4'b0000;
                            7'b0100000: aluop = 4'b0001;
                        endcase
                    end
                    3'b001: aluop = 4'b0010;
                    3'b010: aluop = 4'b0011;
                    3'b011: aluop = 4'b0100;
                    3'b100: aluop = 4'b0101;
                    3'b101: 
                    begin
                        case(funct7)
                            7'b0000000: aluop = 4'b0110;
                            7'b0100000: aluop = 4'b0111;
                        endcase
                    end
                    3'b110: aluop = 4'b1000;
                    3'b111: aluop = 4'b1001;
                endcase
            end

        // I Type
            7'b0010011:
            begin
                sel_a        = 1'b1;
                sel_b        = 1'b1;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b0;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                mem_acc_mode = 3'b111;
                //check funct3 then funct7 to figure out operation
                case(funct3)
                    3'b000: aluop = 4'b0000;
                    3'b001: aluop = 4'b0010;
                    3'b010: aluop = 4'b0011;
                    3'b011: aluop = 4'b0100;
                    3'b101:
                    begin
                        case(funct7)
                            7'b0000000: aluop = 4'b0110;
                            7'b0100000: aluop = 4'b0111;
                        endcase
                    end
                    3'b100: aluop = 4'b0101;
                    3'b110: aluop = 4'b1000;
                    3'b111: aluop = 4'b1001;
                endcase
            end
        // I Type - Load
            7'b0000011:
            begin
                sel_a        = 1'b1;
                sel_b        = 1'b1;
                rf_en        = 1'b1;
                rd_en        = 1'b1;
                wr_en        = 1'b0;
                br_decision  = 1'b0;
                wb_sel       = 2'b10;
                br_type      = 3'b111;
                aluop        = 4'b0000;
                case(funct3)
                    3'b000: mem_acc_mode = 3'b000;
                    3'b001: mem_acc_mode = 3'b001;
                    3'b010: mem_acc_mode = 3'b010;
                    3'b100: mem_acc_mode = 3'b011;
                    3'b101: mem_acc_mode = 3'b100;
                endcase
            end
        // I Type (JALR - jump and link register)
            7'b1100111:
            begin
                sel_a        = 1'b1;
                sel_b        = 1'b1;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b1;
                wb_sel       = 2'b00;
                br_type      = 3'b111;
                aluop       = 4'b0000;
            end
        // U Type (Load upper immediate)
            7'b0110111:
            begin 
                sel_a        = 1'b0;
                sel_b        = 1'b1;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b0;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                aluop        = 4'b1010; 
            end
        // U Type (AUIPC)
            7'b0110111:
            begin 
                sel_a        = 1'b0;
                sel_b        = 1'b1;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b0;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                aluop        = 4'b0000; 
            end
        // S Type
            7'b0100011:
            begin 
                sel_a        = 1'b1;
                sel_b        = 1'b1;
                rf_en        = 1'b0;
                rd_en        = 1'b0;
                wr_en        = 1'b1;
                br_decision  = 1'b0;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                aluop        = 4'b0000;
                case(funct3)
                    3'b000: mem_acc_mode = 3'b000;
                    3'b001: mem_acc_mode = 3'b001;
                    3'b010: mem_acc_mode = 3'b010;
                endcase
            end
        // J Type (JAL)
            7'b1101111:
            begin 
                sel_a        = 1'b0;
                sel_b        = 1'b1;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b1;
                wb_sel       = 2'b00;
                br_type      = 3'b111;
                aluop        = 4'b0000;
            end
        // B Type
            7'b1100011:
            begin 
                sel_a        = 1'b0;
                sel_b        = 1'b1;
                rf_en        = 1'b0;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = br_taken;
                wb_sel       = 2'b01;
                br_type      = funct3;
                aluop        = 4'b0000;
            end
        // CSR (control and status register)
            7'b1110011:
            begin 
                begin
                    if(inst == 32'h30200073)
                        check_mret = 1'b1;
                        epc_taken  = 1'b1;
                end
                sel_a        = 1'b1;
                sel_b        = 1'b0;
                rf_en        = 1'b1;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b1;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                aluop        = 4'b0000;
                epc_taken    = 1'b0;
                case(funct3)
                    3'b001: csr_reg_rd = 1'b1;
                    3'b010: csr_reg_wr = 1'b1;
                endcase
            end
            default:
            begin
                sel_a        = 1'b1;
                sel_b        = 1'b0;
                rf_en        = 1'b0;
                rd_en        = 1'b0;
                wr_en        = 1'b0;
                br_decision  = 1'b0;
                wb_sel       = 2'b01;
                br_type      = 3'b111;
                mem_acc_mode = 3'b111;
            end
        endcase
    end

endmodule

// 4'b0000: opr_res = opr_a + opr_b;
// 4'b0001: opr_res = opr_a - opr_b;
// 4'b0010: opr_res = opr_a << opr_b;
// 4'b0011: opr_res = opr_a < opr_b;
// 4'b0100: opr_res = $unsigned(opr_a) < $unsigned(opr_b);
// 4'b0101: opr_res = opr_a ^ opr_b;
// 4'b0110: opr_res = opr_a >> opr_b;
// 4'b1000: opr_res = opr_a | opr_b;
// 4'b1001: opr_res = opr_a & opr_b;
// 4'b1010: opr_res = opr_b;

//I-Type 7'b0010011:
//I-Type (jump and link register inst JALR) 7'b1100111:
//U-Type 7'b0110111:
//S-Type 7'b0100011:
//J-Type (simple jump and link ) 7'b1101111:
//B-Type 7'b1100011:
 