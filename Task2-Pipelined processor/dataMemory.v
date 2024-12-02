`timescale 1ns / 1ps
module dataMemory(
    input [63:0] memAddress,
    input [63:0] writeData,
    input clk,
    input memWrite,
    input memRead,
	output reg [63:0] readData,
	output reg [63:0] mem0,
	output reg [63:0] mem1,
	output reg [63:0] mem2,
	output reg [63:0] mem3);

reg [7:0] dataMemory [63:0];
integer i;
initial begin
    for(i=0; i<64; i=i+1) begin
        dataMemory[i] = 8'd0 + i;
    end
end
always @ (posedge clk) begin
    if (memWrite)
    begin
        dataMemory[memAddress] = writeData[7:0];
        dataMemory[memAddress+1] = writeData[15:8];
        dataMemory[memAddress+2] = writeData[23:16];
        dataMemory[memAddress+3] = writeData[31:24];
        dataMemory[memAddress+4] = writeData[39:32];
        dataMemory[memAddress+5] = writeData[47:40];
        dataMemory[memAddress+6] = writeData[55:48];
        dataMemory[memAddress+7] = writeData[63:56];
    end
end

always @ (*) begin
	if (memRead) begin
			readData = {dataMemory[memAddress+7],
			dataMemory[memAddress+6],
			dataMemory[memAddress+5],
			dataMemory[memAddress+4],
			dataMemory[memAddress+3],
			dataMemory[memAddress+2],
			dataMemory[memAddress+1],
			dataMemory[memAddress]};
	end else begin
	readData = 64'b0; end
		mem0 = {dataMemory[15], dataMemory[14], dataMemory[13], dataMemory[12], dataMemory[11], dataMemory[10],
	            dataMemory[9], dataMemory[8]};
	    mem1 = {dataMemory[23], dataMemory[22], dataMemory[21], dataMemory[20], dataMemory[19], dataMemory[18],
	            dataMemory[17], dataMemory[16]};
	    mem2 = {dataMemory[31], dataMemory[30], dataMemory[29], dataMemory[28], dataMemory[27], dataMemory[26],
	            dataMemory[25], dataMemory[24]};
	    mem3 = {dataMemory[39], dataMemory[38], dataMemory[37], dataMemory[36], dataMemory[35], dataMemory[34],
	            dataMemory[33], dataMemory[32]};
	end 
	

endmodule
