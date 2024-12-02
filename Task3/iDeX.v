`timescale 1ns / 1ps

module iDeX(
    input clk, reset, branchCheck, stall,
    input regWrite, memtoReg,
    input branch, memRead, memWrite,
    input [1:0] ALUOp,
    input ALUSrc,
    input [63:0] PCOut, readData1, readData2, immData,
    input [4:0] rs1, rs2, rd,
    input [3:0] funct, // instruction[30], instrcution[14:12]
    
    output reg regWriteDel, memtoRegDel,
    output reg branchDel, memReadDel, memWriteDel,
    output reg [1:0] ALUOpDel,
    output reg ALUSrcDel,
    output reg [63:0] PCOutDel, readData1Del, readData2Del, immDataDel,
    output reg [4:0] rs1Del, rs2Del, rdDel,
    output reg [3:0] functDel
);


always@(posedge clk or posedge reset) begin
    if(reset || branchCheck || stall) begin
        regWriteDel = 0; memtoRegDel = 0;
        branchDel = 0; memReadDel = 0; memWriteDel = 0;
        ALUOpDel = 0;
        ALUSrcDel = 0;
        if(reset) begin PCOutDel = 0; end else begin PCOutDel = PCOut; end
        readData1Del = 0; readData2Del = 0; immDataDel = 0;
        rs1Del = 0; rs2Del = 0; rdDel = 0;
        functDel = 0;
    end else begin
        regWriteDel = regWrite; memtoRegDel = memtoReg;
        branchDel = branch; memReadDel = memRead; memWriteDel = memWrite;
        ALUOpDel = ALUOp;
        ALUSrcDel = ALUSrc;
        PCOutDel = PCOut; readData1Del = readData1; readData2Del = readData2; immDataDel = immData;
        rs1Del = rs1; rs2Del = rs2; rdDel = rd;
        functDel = funct;
    
    end

end
endmodule
