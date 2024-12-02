`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 11:20:16 PM
// Design Name: 
// Module Name: test_processor
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


module test_processor();
reg reset, clk;
wire [63:0] mem0;
wire [63:0] mem1;
wire [63:0] mem2;
wire [63:0] mem3;
wire [63:0] PCOut, seqOut, jumpOut, PCIn, imm, writeData, readData1, readData2, secondOperand, execResult, memResult;
wire [31:0] instruction;
wire [6:0] opcode, funct7;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [1:0] ALUOp;
wire [3:0] operation, funct;
wire ZERO, lessThan, branchCheck, branch, memRead, memWrite, memtoReg, ALUSrc, regWrite;
    

RISCV_processor a1(reset, clk, mem0, mem1, mem2, mem3, PCOut, seqOut, jumpOut, PCIn, imm, writeData, readData1, readData2, secondOperand, 
execResult, memResult, instruction, opcode, funct7, rs1, rs2, rd, funct3, ALUOp, operation, funct,
ZERO, lessThan, branchCheck, branch, memRead, memWrite, memtoReg, ALUSrc, regWrite
); 
initial begin
clk = 0; reset = 1;
#10 reset = 0;
end 
always #3
 clk=~clk;
 
 initial begin
    #2000;  // Run the simulation for 2000 ns
    $finish;  // Stop the simulation
end
endmodule
