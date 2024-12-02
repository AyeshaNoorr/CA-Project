`timescale 1ns / 1ps
module RISCV_processor(
    input reset,
    input clk,
    output wire [63:0] mem0,
	output wire [63:0] mem1,
	output wire [63:0] mem2,
	output wire [63:0] mem3,
    output wire [63:0] PCOut, seqOut, jumpOut, PCIn, imm, writeData, readData1, readData2, secondOperand, execResult, memResult,
    output wire [31:0] instruction,
    output wire [6:0] opcode, funct7,
    output wire [4:0] rs1, rs2, rd,
    output wire [2:0] funct3,
    output wire [1:0] ALUOp,
    output wire [3:0] operation, funct,
    output wire ZERO, lessThan, branchCheck, branch, memRead, memWrite, memtoReg, ALUSrc, regWrite
    
); 

programCounter PC (.clk(clk), .reset(reset), .PCIn(PCIn), .PCOut(PCOut));
instructionMemory imem (.instAddress(PCOut), .instruction(instruction));

insParser instructionParser (.instruction(instruction), .opcode(opcode), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7));
immGen immGenerator (.instruction(instruction), .imm(imm));

controlUnit control(.opcode(opcode), 
.ALUOp(ALUOp), .branch(branch), .memRead(memRead), .memtoReg(memtoReg), 
.memWrite(memWrite), .ALUSrc(ALUSrc), .regWrite(regWrite));

regFile RF (.writeData(writeData), .rs1(rs1), .rs2(rs2), .rd(rd), 
.regWrite(regWrite), .clk(clk), .reset(reset), 
.readData1(readData1), .readData2(readData2)
);

assign funct = {instruction[30], instruction[14:12]};

multiplexer m (.a(readData2), .b(imm), .s(ALUSrc), .out(secondOperand));
adder adderBranch(.a(PCOut), .b(imm*2), .out(jumpOut));
aluControl aluCtrl (.ALUOp(ALUOp), .funct(funct), .operation(operation));

alu64Bit alu (.a(readData1), .b(secondOperand), .ALUOp(operation), .result(execResult), .ZERO(ZERO), .lessThan(lessThan));

dataMemory dataMem (.memAddress(execResult), .writeData(readData2),
    .clk(clk), .memWrite(memWrite), .memRead(memRead), .readData(memResult), .mem0(mem0), .mem1(mem1), .mem2(mem2), .mem3(mem3));


multiplexer muxWriteBack (.a(execResult), .b(memResult), .s(memtoReg), .out(writeData));

adder adderSequential (.a(PCOut), .b(64'd4), .out(seqOut));
assign branchCheck = branch && ((ZERO && funct3==3'b000) || (lessThan && funct3==3'b100));
multiplexer muxBranch(.a(seqOut), .b(jumpOut), .s(branchCheck), .out(PCIn));



endmodule
