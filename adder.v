`timescale 1ns / 1ps
module adder(
input [63:0] a,
input [63:0] b,
input shouldNotAdd,
output reg [63:0] out);
always @(*)
    if(shouldNotAdd)
        out = a - b;
    else out = a + b;
endmodule
