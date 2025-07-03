`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 09:12:57
// Design Name: 
// Module Name: Sign_Extend
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


module Sign_Extend(
    input[31:0]Immediate_in,
    input ImmSrc,
    output [31:0] Sign_ext_Immediate
    );
    
    wire funct7_5;
    wire[6:0] opcode;
    wire[2:0] funct3;
    
    assign opcode = Immediate_in[6:0];
    assign funct7_5 = Immediate_in[30];
    assign funct3 = Immediate_in[14:12];
    
    assign Sign_ext_Immediate = (ImmSrc == 1'b1) ? ({{20{Immediate_in[31]}},Immediate_in[31:25],Immediate_in[11:7]}):
                                                   ( funct7_5 == 1'b1 && opcode == 7'd19 && funct3 == 3'b101) ? {{25'b0},Immediate_in[24:20]}: 
                                                    {{20{Immediate_in[31]}},Immediate_in[31:20]};
    
endmodule
