`timescale 1ns / 1ps

module immGen(
input [32:0] instruction,
output reg [63:0] imm
);

wire [1:0] opcode;
assign opcode[0] = instruction[5];
assign opcode[1] = instruction[6];

reg [11:0] immLd;
reg [11:0] immSd;
reg [11:0] immRd;

always@(instruction) begin
    case(opcode)
        2'b11: begin
//            imm[3:0] = instruction[11:8];
//            imm[9:4] = instruction[30:25];
//            imm[10] = instruction[7];
//            imm[11] = instruction[31];
            immRd = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
			imm = {{52{instruction[31]}}, immRd};
		end
        2'b01: begin
            immSd = {instruction[31:25], instruction[11:7]};
			imm = {{52{instruction[31]}}, immSd};
		end  
		2'b00: begin
            immLd = {instruction[31:20]};
			imm = {{52{instruction[31]}}, immLd};
		end            
		default: imm = 64'h0000000000000000;
    endcase
end
    
endmodule