`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 19:53:35
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input clk,rst,WE,
    input [31:0]A,WD,
    output [31:0]RD
    );
    
    reg [31:0] Data_Memory [1023:0];
    assign RD = (~rst) ? 32'b0 : Data_Memory[A];
    
    always@(posedge clk) if (WE) Data_Memory[A] <= WD ;
    
    initial begin
        Data_Memory[28] = 32'hffffffff;
    end
    
endmodule
