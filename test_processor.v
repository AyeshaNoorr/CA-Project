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
wire [63:0] reg4;
wire [63:0] reg5;
wire [63:0] PCOut, PCOutIFID, PCOutIDEX; 
wire [63:0] seqOut, 
jumpOut, jumpOutEXMEM, 
PCIn, 
imm, immIDEX, 
writeData, 
readData1, readData1IDEX,
readData2, readData2IDEX, readData2EXMEM, secondOperand, 
execResult, execResultEXMEM, execResultMEMWB,
memResult, memResultMEMWB;
wire [31:0] instruction, instructionIFID;
wire [6:0] opcode, funct7;
wire [4:0] rs1, rs1IDEX, rs2, rs2IDEX, rd, rdIDEX, rdEXMEM, rdMEMWB;
wire [2:0] funct3;
wire [1:0] ALUOp, ALUOpIDEX;
wire [3:0] operation, funct, functIDEX, functEXMEM;
wire ZERO, ZEROEXMEM, lessThan, lessThanEXMEM, branchCheck, 
branch, branchIDEX, branchEXMEM,
memRead, memReadIDEX, memReadEXMEM, 
memWrite,memWriteIDEX, memWriteEXMEM, 
memtoReg, memtoRegIDEX, memtoRegEXMEM, memtoRegMEMWB, 
ALUSrc, ALUSrcIDEX, 
regWrite, regWriteIDEX, regWriteEXMEM, regWriteMEMWB, 
stall;
wire [1:0] ForwardA, ForwardB;
wire [63:0] readData1FWD, readData2FWD;

RISCV_processor a1(reset, clk, mem0, mem1, mem2, mem3, 
reg4, reg5,
PCOut, PCOutIFID, PCOutIDEX, 
seqOut, jumpOut, jumpOutEXMEM, 
PCIn, 
imm, immIDEX, 
writeData, 
readData1, readData1IDEX,
readData2, readData2IDEX, readData2EXMEM, secondOperand, 
execResult, execResultEXMEM, execResultMEMWB,
memResult, memResultMEMWB,
instruction, instructionIFID,
opcode, funct7, rs1, rs1IDEX, rs2, rs2IDEX, rd, rdIDEX, rdEXMEM, rdMEMWB, funct3,
ALUOp, ALUOpIDEX,
operation, funct, functIDEX, functEXMEM,
ZERO, ZEROEXMEM, lessThan, lessThanEXMEM, branchCheck, 
branch, branchIDEX, branchEXMEM,
memRead, memReadIDEX, memReadEXMEM, 
memWrite,memWriteIDEX, memWriteEXMEM, 
memtoReg, memtoRegIDEX, memtoRegEXMEM, memtoRegMEMWB, 
ALUSrc, ALUSrcIDEX, 
regWrite, regWriteIDEX, regWriteEXMEM, regWriteMEMWB,
stall,
ForwardA, ForwardB,
readData1FWD, readData2FWD
); 



initial begin
clk = 1'b0; reset = 1'b1;
#10 reset = 1'b0;
end 
always #3
 clk=~clk;
 
 initial begin
    #2000;  // Run the simulation for 2000 ns
    $finish;  // Stop the simulation
end
endmodule
