`timescale 1ns / 1ps

module programCounter(
input clk,
input reset,
input [63:0] PCIn,
input stall,
output reg [63:0] PCOut);

initial PCOut = 64'd0;
always @ (posedge clk or posedge reset) begin
    if(reset) begin PCOut = 64'b0; end 
    else begin 
//        if(!stall) begin 
        PCOut = PCIn; 
//        end
    end
	end
endmodule