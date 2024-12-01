`timescale 1ns / 1ps
module RISCV_processor(
    input reset,
    input clk,
    output wire [63:0] mem0,
	output wire [63:0] mem1,
	output wire [63:0] mem2,
	output wire [63:0] mem3,
	output wire [63:0] reg4,
	output wire [63:0] reg5,
	output wire [63:0] reg6,
    output wire [63:0] PCOut, PCOutIFID, PCOutIDEX, 
    output wire [63:0] seqOut, 
    jumpOut, jumpOutEXMEM, 
    PCIn, 
    imm, immIDEX, 
    writeData, 
    readData1, readData1IDEX,
    readData2, readData2IDEX, readData2EXMEM, secondOperand, 
    execResult, execResultEXMEM, execResultMEMWB,
    memResult, memResultMEMWB,
    output wire [31:0] instruction, instructionIFID,
    output wire [6:0] opcode, funct7,
    output wire [4:0] rs1, rs1IDEX, rs2, rs2IDEX, rd, rdIDEX, rdEXMEM, rdMEMWB,
    output wire [2:0] funct3,
    output wire [1:0] ALUOp, ALUOpIDEX,
    output wire [3:0] operation, funct, functIDEX, functEXMEM,
    output wire ZERO, ZEROEXMEM, lessThan, lessThanEXMEM, branchCheck, 
    branch, branchIDEX, branchEXMEM, 
    memRead, memReadIDEX, memReadEXMEM, 
    memWrite,memWriteIDEX, memWriteEXMEM, 
    memtoReg, memtoRegIDEX, memtoRegEXMEM, memtoRegMEMWB, 
    ALUSrc, ALUSrcIDEX, 
    regWrite, regWriteIDEX, regWriteEXMEM, regWriteMEMWB,
    stall,
    output wire [1:0] ForwardA, ForwardB,
    output wire [63:0] readData1FWD, readData2FWD
    
); 

hazardDetectionUnit hazard (.rs1(rs1), .rs2(rs2), .rdIDEX(rdIDEX),
.memReadIDEX(memReadIDEX), .stall(stall)); 

multiplexer muxBranch(.a(seqOut), .b(jumpOutEXMEM), .s(branchCheck), .out(PCIn));
programCounter PC (.clk(clk), .reset(reset), .PCIn(PCIn), .stall(stall), .PCOut(PCOut));
adder adderSequential (.a(PCOut), .b(64'd4), .shouldNotAdd(stall), .out(seqOut));
instructionMemory imem (.instAddress(PCOut), .instruction(instruction));

iFiD IFID (.reset(reset), .clk(clk), .stall(stall), .branchCheck(branchCheck), .PCOut(PCOut), .instruction(instruction), 
.PCOutDel(PCOutIFID), .instructionDel(instructionIFID));

insParser instructionParser (.instruction(instructionIFID), .opcode(opcode), 
.rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7));


immGen immGenerator (.instruction(instructionIFID), .imm(imm));

controlUnit control(.opcode(opcode),
.ALUOp(ALUOp), .branch(branch), .memRead(memRead), .memtoReg(memtoReg), 
.memWrite(memWrite), .ALUSrc(ALUSrc), .regWrite(regWrite));

regFile RF (.writeData(writeData), .rs1(rs1), .rs2(rs2), .rd(rdMEMWB), 
.regWrite(regWriteMEMWB), .clk(clk), .reset(reset), 
.readData1(readData1), .readData2(readData2), .reg4(reg4), .reg5(reg5), .reg6(reg6)
);

assign funct = {instructionIFID[30], instructionIFID[14:12]};

iDeX IDEX (.clk(clk), .reset(reset), .branchCheck(branchCheck), .stall(stall), .memtoReg(memtoReg), .regWrite(regWrite), 
.branch(branch), .memWrite(memWrite), .memRead(memRead), .ALUOp(ALUOp), .ALUSrc(ALUSrc), 
.PCOut(PCOutIFID), .readData1(readData1), .readData2(readData2), .immData(imm), .rs1(rs1), .rs2(rs2), .rd(rd),
.funct(funct),
.memtoRegDel(memtoRegIDEX), .regWriteDel(regWriteIDEX),
.branchDel(branchIDEX), .memWriteDel(memWriteIDEX), .memReadDel(memReadIDEX),
.ALUOpDel(ALUOpIDEX), .ALUSrcDel(ALUSrcIDEX),
.PCOutDel(PCOutIDEX), .readData1Del(readData1IDEX), .readData2Del(readData2IDEX), .immDataDel(immIDEX),
.rs1Del(rs1IDEX), .rs2Del(rs2IDEX), .rdDel(rdIDEX),
.functDel(functIDEX));


adder adderBranch(.a(PCOutIDEX), .b(immIDEX<<1), .shouldNotAdd(1'b0), .out(jumpOut));
forwardingUnit fwdUnit (.rs1IDEX(rs1IDEX), .rs2IDEX(rs2IDEX), .rdEXMEM(rdEXMEM), .rdMEMWB(rdMEMWB), 
.regWriteEXMEM(regWriteEXMEM), .regWriteMEMWB(regWriteMEMWB), .ForwardA(ForwardA), .ForwardB(ForwardB));


multiplexer3x1 mux3x1r1 (.a(readData1IDEX), .b(writeData), .c(execResultEXMEM), .s(ForwardA), .out(readData1FWD));
multiplexer3x1 mux3x1r2 (.a(readData2IDEX), .b(writeData), .c(execResultEXMEM), .s(ForwardB), .out(readData2FWD));

multiplexer m (.a(readData2FWD), .b(immIDEX), .s(ALUSrcIDEX), .out(secondOperand));
aluControl aluCtrl (.ALUOp(ALUOpIDEX), .funct(functIDEX), .operation(operation));

alu64Bit alu (.a(readData1FWD), .b(secondOperand), .ALUOp(operation), .result(execResult), .ZERO(ZERO), .lessThan(lessThan));



eXmeM EXMEM (.clk(clk), .reset(reset), .branchCheck(branchCheck), .memtoReg(memtoRegIDEX), .regWrite(regWriteIDEX),
    .branch(branchIDEX), .memRead(memReadIDEX), .memWrite(memWriteIDEX), 
    .jumpOut(jumpOut), .ZERO(ZERO), .lessThan(lessThan),
    .execResult(execResult), .writeDataMem(readData2IDEX), .rd(rdIDEX), .funct(functIDEX),
    .memtoRegDel(memtoRegEXMEM), .regWriteDel(regWriteEXMEM), 
    .branchDel(branchEXMEM), .memWriteDel(memWriteEXMEM), .memReadDel(memReadEXMEM), 
    .jumpOutDel(jumpOutEXMEM), .ZERODel(ZEROEXMEM), .lessThanDel(lessThanEXMEM),
    .execResultDel(execResultEXMEM), .writeDataMemDel(readData2EXMEM), .rdDel(rdEXMEM), .functDel(functEXMEM)
);
assign branchCheck = branchEXMEM && ((ZEROEXMEM && functEXMEM[2:0]==3'b000) || (lessThanEXMEM && functEXMEM[2:0]==3'b100));

//instFlush flush (.branchCheck(branchCheck), .instructionIFID(instructionIFID), .branchIDEX(branchIDEX), 
//.memtoRegIDEX(memtoRegIDEX), .ALUOpIDEX(ALUOpIDEX), .ALUSrcIDEX(ALUSrcIDEX), .memReadIDEX(memReadIDEX),
//.memWriteIDEX(memWriteIDEX), .regWriteIDEX(regWriteIDEX), 
//.instructionIFIDFlushed(instructionIFID), .branchIDEXFlushed(branchIDEX), .memtoRegIDEXFlushed(memtoRegIDEX), 
//.ALUOpIDEXFlushed(ALUOpIDEX), .ALUSrcIDEXFlushed(ALUSrcIDEX), .memReadIDEXFlushed(memReadIDEX),
//.memWriteIDEXFlushed(memWriteIDEX), .regWriteIDEXFlushed(regWriteIDEX));

dataMemory dataMem (.memAddress(execResultEXMEM), .writeData(readData2EXMEM),
    .clk(clk), .memWrite(memWriteEXMEM), .memRead(memReadEXMEM), .readData(memResult), 
    .mem0(mem0), .mem1(mem1), .mem2(mem2), .mem3(mem3));

meMwB MEMWB (.clk(clk), .reset(reset), .memtoReg(memtoRegEXMEM), .regWrite(regWriteEXMEM), .memResult(memResult), .execResult(execResultEXMEM), .rd(rdEXMEM),
.memtoRegDel(memtoRegMEMWB), .regWriteDel(regWriteMEMWB),  .memResultDel(memResultMEMWB), .execResultDel(execResultMEMWB), .rdDel(rdMEMWB));

multiplexer muxWriteBack (.a(execResultMEMWB), .b(memResultMEMWB), .s(memtoRegMEMWB), .out(writeData));





endmodule
