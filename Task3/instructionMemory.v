`timescale 1ns / 1ps
module instructionMemory(
    input [63:0] instAddress,
//    input stall,
	output reg [31:0] instruction);

reg [7:0] memory [123:0];
//reg [7:0] memory [27:0];
initial begin
    
    // beq x0, x0, OuterLoop # Repeat the outer loop
    memory[123] = 8'b11111010;
    memory[122] = 8'b00000000;
    memory[121] = 8'b00001100;
    memory[120] = 8'b11100011;
    // addi x6, x6, 1 # Move to the next element (increment outer loop index)
    memory[119] = 8'b00000000;
    memory[118] = 8'b00010011;
    memory[117] = 8'b00000011;
    memory[116] = 8'b00010011;
    // sd x8, 8(x11) # Insert key into arr[x9 + 1]
    memory[115] = 8'b00000000;
    memory[114] = 8'b10000101;
    memory[113] = 8'b10110100;
    memory[112] = 8'b00100011;
    // add x11, x11, x10 # x11 = address of arr[x9 + 1] (position to insert key)
    memory[111] = 8'b00000000;
    memory[110] = 8'b10100101;
    memory[109] = 8'b10000101;
    memory[108] = 8'b10110011;
    // slli x11, x9, 3 # x11 = x9 * 4 (byte offset for x9)
    memory[107] = 8'b00000000;
    memory[106] = 8'b00110100;
    memory[105] = 8'b10010101;
    memory[104] = 8'b10010011;
    // beq x0, x0, InnerLoop # Repeat the inner loop if x9 >= 0
    memory[103] = 8'b11111110;
    memory[102] = 8'b00000000;
    memory[101] = 8'b00000000;
    memory[100] = 8'b11100011;
    // addi x9, x9, -1 # Move to the previous index
    memory[99] = 8'b11111111;
    memory[98] = 8'b11110100;
    memory[97] = 8'b10000100;
    memory[96] = 8'b10010011;
    // sd x12, 8(x11) # Shift arr[x9] to arr[x9 + 1]
    memory[95] = 8'b00000000;
    memory[94] = 8'b11000101;
    memory[93] = 8'b10110100;
    memory[92] = 8'b00100011;
    // beq x12, x8, endInnerLoop # If arr[x9] == key, exit inner loop
    memory[91] = 8'b00000000;
    memory[90] = 8'b10000110;
    memory[89] = 8'b00001000;
    memory[88] = 8'b01100011;
    // blt x12, x8, endInnerLoop # If arr[x9] < key, exit inner loop
    memory[87] = 8'b00000000;
    memory[86] = 8'b10000110;
    memory[85] = 8'b01001010;
    memory[84] = 8'b01100011;
    // ld x12, 0(x11) # x12 = arr[x9] (current element to compare with key)
    memory[83] = 8'b00000000;
    memory[82] = 8'b00000101;
    memory[81] = 8'b10110110;
    memory[80] = 8'b00000011;
    // add x11, x11, x10 # x11 = address of arr[x9]
    memory[79] = 8'b00000000;
    memory[78] = 8'b10100101;
    memory[77] = 8'b10000101;
    memory[76] = 8'b10110011;
    // slli x11, x9, 3 # x11 = x9 * 4 (byte offset for x9)
    memory[75] = 8'b00000000;
    memory[74] = 8'b00110100;
    memory[73] = 8'b10010101;
    memory[72] = 8'b10010011;
    // blt x9, x0, endInnerLoop # If j < 0, end the inner loop
    memory[71] = 8'b00000010;
    memory[70] = 8'b00000100;
    memory[69] = 8'b11000010;
    memory[68] = 8'b01100011;
    // addi x9, x6, -1 # x9 = inner loop index (x6 - 1), for comparison with previous elements
    memory[67] = 8'b11111111;
    memory[66] = 8'b11110011;
    memory[65] = 8'b00000100;
    memory[64] = 8'b10010011;
    // ld x8, 0(x7) # x8 = key (current element to insert)
    memory[63] = 8'b00000000;
    memory[62] = 8'b00000011;
    memory[61] = 8'b10110100;
    memory[60] = 8'b00000011;
    // add x7, x7, x10 # x7 = address of arr[x6]
    memory[59] = 8'b00000000;
    memory[58] = 8'b10100011;
    memory[57] = 8'b10000011;
    memory[56] = 8'b10110011;
    // slli x7, x6, 3   # x7 = x6 * 4 (byte offset for x6)
    memory[55] = 8'b00000000;
    memory[54] = 8'b00110011;
    memory[53] = 8'b00010011;
    memory[52] = 8'b10010011;
    // beq x6, x5, Done     # If x6 == x5 (end of array), exit
    memory[51] = 8'b00000100;
    memory[50] = 8'b01010011;
    memory[49] = 8'b00000110;
    memory[48] = 8'b01100011;
    // addi x6, x0, 1          # x6 = outer loop index (start from 1)
    memory[47] = 8'b00000000;
    memory[46] = 8'b00010000;
    memory[45] = 8'b00000011;
    memory[44] = 8'b00010011;
    // beq x0, x0, Loop
    memory[43] = 8'b11111110;
    memory[42] = 8'b00000000;
    memory[41] = 8'b00000100;
    memory[40] = 8'b11100011;
    // addi x6, x6, 1
    memory[39] = 8'b0;
    memory[38] = 8'b00010011;
    memory[37] = 8'b00000011;
    memory[36] = 8'b00010011;
    // addi x13, x13, -2
    memory[35] = 8'b11111111;
    memory[34] = 8'b11100110;
    memory[33] = 8'b10000110;
    memory[32] = 8'b10010011;
    // sd x13, 0(x7)
    memory[31] = 8'b0;
    memory[30] = 8'b11010011;
    memory[29] = 8'b10110000;
    memory[28] = 8'b00100011;
    // add x7, x14, x10
    memory[27] = 8'b0;
    memory[26] = 8'b10100111;
    memory[25] = 8'b00000011;
    memory[24] = 8'b10110011;
    // slli x14, x6, 3 # byte offsets of a word
    memory[23] = 8'b00000000;
    memory[22] = 8'b00110011;
    memory[21] = 8'b00010111;
    memory[20] = 8'b00010011;
    // beq x6, x5, exit
    memory[19] = 8'b00000000;
    memory[18] = 8'b01010011;
    memory[17] = 8'b00001110;
    memory[16] = 8'b01100011;
    // addi x10, x0, 8 # base address
    memory[15] = 8'b00000000;
    memory[14] = 8'b10000000;
    memory[13] = 8'b00000101;
    memory[12] = 8'b00010011;
    // addi x13, x0, 10
    memory[11] = 8'b0;
    memory[10] = 8'b10100000;
    memory[9] = 8'b00000110;
    memory[8] = 8'b10010011;
    // addi x6, x0, 0
    memory[7] = 8'b0;
    memory[6] = 8'b00000000;
    memory[5] = 8'b00000011;
    memory[4] = 8'b00010011;
    // addi x5, x0, 4
    memory[3] = 8'b00000000;
    memory[2] = 8'b01000000;
    memory[1] = 8'b00000010;
    memory[0] = 8'b10010011;
      
      
      
//      //      //      0x00443423 sd x4, 8(x8)
////      memory[15] = 8'h00;
////      memory[14] = 8'h44;
////      memory[13] = 8'h34;
////      memory[12] = 8'h23;

//      //      0x000002b3 add x5, x0, x0
//      memory[27] = 8'h00;
//      memory[26] = 8'h00;
//      memory[25] = 8'h02;
//      memory[24] = 8'hb3;

//      //      0x000102b3 add x5, x2, x0
//      memory[23] = 8'h00;
//      memory[22] = 8'h01;
//      memory[21] = 8'h02;
//      memory[20] = 8'hb3;
      
//      //      0x00000463 beq x0, x0, exit
//      memory[19] = 8'h00;
//      memory[18] = 8'h00;
//      memory[17] = 8'h04;
//      memory[16] = 8'h63;

//      //      0x0043283 ld x5, 0(x8)
//      memory[15] = 8'h00;
//      memory[14] = 8'h04;
//      memory[13] = 8'h32;
//      memory[12] = 8'h83;
      
//      //      0x00343023 sd x3, 0(x8)
//      memory[11] = 8'h00;
//      memory[10] = 8'h34;
//      memory[9] = 8'h30;
//      memory[8] = 8'h23;
      
//      //      0x001202b3 add x5, x4, x1
//      memory[7] = 8'h00;
//      memory[6] = 8'h12;
//      memory[5] = 8'h02;
//      memory[4] = 8'hb3;
      
//////      0x004233A3 sd x4, 7(x4)
////      memory[7] = 8'h00;
////      memory[6] = 8'h42;
////      memory[5] = 8'h33;
////      memory[4] = 8'hA3;
////      0x00100213 addi x4, x0, 1
//      memory[3] = 8'h00;
//      memory[2] = 8'h10;
//      memory[1] = 8'h02;
//      memory[0] = 8'h13;
end
always @(*)
	begin
//	if(stall) instruction = 32'b0; else 
		instruction={memory[instAddress+3],memory[instAddress+2],memory[instAddress+1],memory[instAddress]};
	end
endmodule
