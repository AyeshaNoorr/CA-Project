`timescale 1ns / 1ps


module iFiD(
    input reset,
    input clk,
    input stall,
    input branchCheck,
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
//        if (!stall) begin
//            if(branchCheck) begin instructionDel = 32'b0; 
//            end else begin
//            instructionDel = instruction; 
//            end 
//           if(!stall) begin
//            PCOutDel = PCOut;
//            end
            PCOutDel = PCOut;
            if(branchCheck) instructionDel = 32'b0; else 
            instructionDel = instruction; 
//       end 
//          else begin
//            instructionDel = 32'b0;
//        end
    end
end
    
endmodule
