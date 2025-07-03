`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 14:17:57
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
input[31:0] PC,
input Rst,
output reg [31:0] Instruction
    );
    
    reg [31:0] Instr_Mem [1023:0];
    
    always@(*) Instruction = ~Rst ? 0 : Instr_Mem[PC[31:2]];
    
    
    
  initial begin
    /* R-TYPE
    Instr_Mem[0] = 32'h00500093;
    Instr_Mem[1] = 32'h00A00113;
    Instr_Mem[2] = 32'h001101B3;
    Instr_Mem[3] = 32'h0020C233;
    Instr_Mem[4] = 32'h002092B3;
    Instr_Mem[5] = 32'h0020D333;
    Instr_Mem[6] = 32'h4020D3B3;
    Instr_Mem[7] = 32'h0060B433;
    Instr_Mem[8] = 32'h0060A4B3;
    Instr_Mem[9] = 32'h0030A523;
    Instr_Mem[10] =32'h00A0A503;*/
    
    /* I-TYPE
    Instr_Mem[0] = 32'hFFE00113;
    Instr_Mem[1] = 32'h00500093;
    Instr_Mem[2] = 32'h0070C213;
    Instr_Mem[3] = 32'h00221293;
    Instr_Mem[4] = 32'h0022D313;
    Instr_Mem[5] = 32'h4022D393;
    Instr_Mem[6] = 32'h0640B413;
    Instr_Mem[7] = 32'h0640A493;
    Instr_Mem[8] = 32'hFF610193;
    Instr_Mem[9] = 32'h0032A023;
    Instr_Mem[10] = 32'h0002A583;*/
    
        
  end
    
endmodule
