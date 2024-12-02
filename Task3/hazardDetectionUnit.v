`timescale 1ns / 1ps


module hazardDetectionUnit(
//    input [6:0] opcode,
//    input [2:0] funct,
    input [4:0] rs1, rs2,
    input [4:0] rdIDEX,
//    input [4:0] rdEXMEM,
//    input regWriteIDEX, regWriteEXMEM,
    input memReadIDEX,
    
    output reg stall
    );
    
    always @(*) begin
        stall = (memReadIDEX && ((rdIDEX == rs1) || (rdIDEX == rs2)));
        //          stall = 1'b0;
    end
//assign stall = 0;
endmodule
