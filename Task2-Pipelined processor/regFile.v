`timescale 1ns / 1ps
module regFile(
input [63:0] writeData,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
input regWrite,
input clk,
input reset,
output reg [63:0] readData1,
output reg [63:0] readData2,
output reg [63:0] reg4,
output reg [63:0] reg5
    );
    
reg [63:0] registers [31:0];

integer i;

initial begin
    for(i = 0; i < 32; i=i+1) begin
        registers[i] = 64'd0 + i; 
    end 
end

always@(posedge clk) begin
    registers[rd] = regWrite ? writeData : registers[rd];
end

always@(*) begin
    if(reset) begin
        readData1 = 64'b0;
        readData2 = 64'b0;
    end else begin
        readData1 = (regWrite && (rs1 == rd)) ? writeData : registers[rs1];
        readData2 = (regWrite && (rs2 == rd)) ? writeData : registers[rs2];
    end
    reg4 = registers[4];
    reg5 = registers[5];
end
endmodule
