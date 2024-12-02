`timescale 1ns / 1ps

module controlUnit(
input [6:0] opcode,
output reg [1:0] ALUOp,
output reg branch,
output reg memRead,
output reg memtoReg,
output reg memWrite,
output reg ALUSrc,
output reg regWrite);

always @(opcode) begin
    case(opcode)
        7'b0110011: begin // r type
            branch = 1'b0; memRead = 1'b0; memtoReg = 1'b0; ALUOp = 2'b10;
            memWrite = 1'b0; ALUSrc = 1'b0; regWrite = 1'b1;
        end
        7'b0000011: begin // i type ld
            branch = 1'b0; memRead = 1'b1; memtoReg = 1'b1; ALUOp = 2'b00;
            memWrite = 1'b0; ALUSrc = 1'b1; regWrite = 1'b1;
        end
        7'b0010011: begin // i type addi
            branch = 1'b0; memRead = 1'b0; memtoReg = 1'b0; ALUOp = 2'b00;
            memWrite = 1'b0; ALUSrc = 1'b1; regWrite = 1'b1;
        end
//        7'b0010011: begin // i type slli
//            branch = 0; memRead = 1'b0; memtoReg = 1'b0; ALUOp = 2'b10;
//            memWrite = 1'b0; ALUSrc = 1'b1; regWrite = 1'b1;
//        end
        7'b0100011: begin // s type sd
            branch = 1'b0; memRead = 1'b0; memtoReg = 1'b0; ALUOp = 2'b00;
            memWrite = 1'b1; ALUSrc = 1'b1; regWrite = 1'b0;
        end
        7'b1100011: begin // sb
            branch = 1'b1; memRead = 1'b0; memtoReg = 1'b0; ALUOp = 2'b01;
            memWrite = 1'b0; ALUSrc = 1'b0; regWrite = 1'b0;
        end
        default: begin 
            branch = 1'b0; memRead = 1'b0; memtoReg = 1'b0; ALUOp = 2'b00;
            memWrite = 1'b0; ALUSrc = 1'b0; regWrite = 1'b0;
        end
    endcase 
end
endmodule
