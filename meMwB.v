`timescale 1ns / 1ps
module meMwB(
    input clk,reset,
    input memtoReg, regWrite,
    input [63:0] memResult,
    input [63:0] execResult,
    input [4:0] rd,
    
    output reg memtoRegDel, regWriteDel, 
    output reg [63:0] memResultDel,
    output reg [63:0] execResultDel,
    output reg [4:0] rdDel
    );
    
    
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            memtoRegDel = 0;  regWriteDel = 0; 
            memResultDel = 0; 
            execResultDel = 0; 
            rdDel = 0; 
        end else begin
            memtoRegDel = memtoReg;  regWriteDel = regWrite; 
            memResultDel = memResult; 
            execResultDel = execResult; 
            rdDel = rd; 
        end
    end
endmodule
