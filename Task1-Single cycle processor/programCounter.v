`timescale 1ns / 1ps

module programCounter(
input clk,
input reset,
input [63:0] PCIn,
output reg [63:0] PCOut);

initial PCOut = 64'd0;
always @ (posedge clk or posedge reset) begin
    PCOut = reset == 1'b1 ? 64'b0 : PCIn;
	end
endmodule