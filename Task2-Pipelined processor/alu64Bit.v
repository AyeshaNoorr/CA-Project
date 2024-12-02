`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2024 01:43:09 PM
// Design Name: 
// Module Name: alu64Bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu64Bit(
input [63:0] a,
input [63:0] b,
input [3:0] ALUOp,
output reg [63:0] result,
output reg ZERO,
output reg lessThan);

always @(*) begin
    
    case (ALUOp)
            4'b0000: begin assign result = a & b; end
            4'b0001: begin assign result = a | b; end
            4'b0010: begin assign result = a + b; end
            4'b0110: begin assign result = a - b; end
            4'b1100: begin assign result = ~(a | b); end
            4'b0100: begin assign result = a * (2 ** b); end
    endcase
ZERO = result == 64'b0 ? 1'b1 : 1'b0;
lessThan = result[63] == 1'b1 ? 1'b1 : 1'b0;
end

endmodule
