`timescale 1ns / 1ps


module iFiD(
    input reset,
    input clk,
    input stall,
    input [63:0] PCOut,
    input [31:0] instruction,
    output reg [63:0] PCOutDel,
    output reg [31:0] instructionDel
    );
    always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        instructionDel = 0; PCOutDel = 0;
    end
    else begin
        if (!stall) begin
            instructionDel = instruction; PCOutDel = PCOut;
       end 
//          else begin
//            instructionDel = 32'b0;
//        end
    end
end
    
endmodule
