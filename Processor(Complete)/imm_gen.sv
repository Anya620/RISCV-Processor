module imm_gen(
    input  logic [31:0] inst,
    output logic [31:0] imm_val

);
    // Analyzing the opcode to know what type of inst it is
    always_comb
    begin
        case(inst[6:0]) // first 7 bits(opcode)
        //I-Type
            7'b0010011:
                case(inst[14:12]) //check bits 12,11,14
                3'b011: imm_val = {20'b0, inst[31:20]};
                3'b101: imm_val = {{27{inst[24]}}, inst[24:20]}; //Sign extension
                default:
                begin
                    imm_val = {{20{inst[24]}}, inst[31:20]};

                end
                endcase

        //I-Type (jump and link register inst JALR)
            7'b1100111:
                imm_val = $signed(inst[31:20]);
        //U-Type
            7'b0110111:
                imm_val = {inst[31:12], 12'b0};
        //S-Type
            7'b0100011:
                imm_val = $signed({inst[31:25], inst[11:7]});
        //J-Type (simple jump and link )
            7'b1101111:
                imm_val = $signed({inst[31], inst[19:12], inst[20], inst[30:21], 1'b0});
        //B-Type
            7'b1100011:
                imm_val = $signed({inst[31], inst[7], inst[30:25], inst[11:8], 1'b0});
        endcase
    end
endmodule