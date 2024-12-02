`timescale 1ns / 1ps

module multiplexer(
input [63:0] a,
input [63:0] b,
input s,
output [63:0] out);
    assign out = s ? b : a; // if s, out=b, else a
endmodule