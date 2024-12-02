`timescale 1ns / 1ps

module aluControl(
input [1:0] ALUOp,
input [3:0] funct,
//input [6:0] opcode,
output reg [3:0] operation);

always @ (ALUOp or funct) begin
    case(ALUOp)
        2'b00: begin
        if (funct[2:0]==3'b001)
        begin operation = 4'b0100; end // slli type
        else begin
        operation = 4'b0010; // i type (ld, sd) 
        end
        end
        2'b01: operation = 4'b0110; // sb ype (beq)
        2'b10: // r Type 
        begin 
        case(funct)
            4'b0000: operation = 4'b0010;
            4'b1000: operation = 4'b0110;
            4'b0111: operation = 4'b0000;
            4'b0110: operation = 4'b0001;
            4'b0001:  operation = 4'b0100; // slli
        endcase
        end
    endcase
	end
endmodule
