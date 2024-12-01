`timescale 1ns / 1ps
module forwardingUnit(
    input [4:0] rs1IDEX,   // register 1 from ID/EX stage
    input [4:0] rs2IDEX,   // register 2 from ID/EX stage
    input [4:0] rdEXMEM,   // rd from EX/MEM stage
    input [4:0] rdMEMWB,   // rd from MEM/WB stage
    input regWriteEXMEM,   
    input regWriteMEMWB,   
    output reg [1:0] ForwardA, 
    output reg [1:0] ForwardB   
);

    always @(*) begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;
        if (regWriteMEMWB && (rdMEMWB != 0) && !(regWriteEXMEM && (rdEXMEM != 0) && (rdEXMEM == rs1IDEX))&& (rdMEMWB == rs1IDEX)) begin
            ForwardA = 2'b01; 
        end
        else if (regWriteEXMEM && (rdEXMEM != 0) && (rdEXMEM == rs1IDEX)) begin
            ForwardA = 2'b10;  
        end
        if (regWriteMEMWB && (rdMEMWB != 0) && !(regWriteEXMEM && (rdEXMEM != 0) && (rdEXMEM == rs2IDEX)) && (rdMEMWB == rs2IDEX)) begin
            ForwardB = 2'b01; 
        end else if (regWriteEXMEM && (rdEXMEM != 0) && (rdEXMEM == rs2IDEX)) begin
            ForwardB = 2'b10;  
        end
    end

endmodule