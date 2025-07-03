`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 14:27:50
// Design Name: 
// Module Name: PC
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


module PC(
input [31:0] PC_Next,
input clk,rst,
output reg[31:0] PC
    );
    
    always@(posedge clk) begin
        if(~rst) PC <= 32'b0;
        else PC <= PC_Next;
        end
endmodule
