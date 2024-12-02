`timescale 1ns / 1ps

module eXmeM(
    input clk, reset,
    input memtoReg, regWrite,
    input branch, memRead, memWrite,
    input [63:0] jumpOut,
    input ZERO,
    input lessThan,
    input [63:0] execResult,
    input [63:0] writeDataMem,
    input [4:0] rd,
    input [3:0] funct,
    
    output reg memtoRegDel, regWriteDel, // 2bits
    output reg branchDel, memReadDel, memWriteDel,
    output reg [63:0] jumpOutDel,
    output reg ZERODel,
    output reg lessThanDel,
    output reg [63:0] execResultDel,
    output reg [63:0] writeDataMemDel,
    output reg [4:0] rdDel, //5bits
    output reg [3:0] functDel
    );
    
    
    always@(posedge clk or posedge reset) begin
    if(reset) begin
        memtoRegDel = 0; regWriteDel = 0;
        branchDel = 0; memReadDel = 0; memWriteDel = 0;
        jumpOutDel = 0;
        ZERODel = 0;
        lessThanDel = 0;
        execResultDel = 0;
        writeDataMemDel = 0;
        rdDel = 0;
        functDel = 0;
    end else begin
        memtoRegDel = memtoReg; regWriteDel = regWrite;
        branchDel = branch; memReadDel = memRead; memWriteDel = memWrite;
        jumpOutDel = jumpOut;
        ZERODel = ZERO;
        lessThanDel = lessThan;
        execResultDel = execResult;
        writeDataMemDel = writeDataMem;
        rdDel = rd;
        functDel = funct;
     
    end
    end
endmodule


