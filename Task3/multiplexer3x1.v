`timescale 1ns / 1ps

module multiplexer3x1(
    input [63:0] a,
    input [63:0] b,
    input [63:0] c,
    input [1:0] s,
    output [63:0] out
    );
    assign out = s==2'b00 ? a : (s==2'b01 ? b : c);
endmodule
