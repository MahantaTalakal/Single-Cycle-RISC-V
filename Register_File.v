`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 14:36:31
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input clk,rst,WE3,
    input [4:0]A1,A2,A3,
    input [31:0]WD3,
    output reg [31:0]RD1,RD2
    );
    
    reg [31:0] Reg_File [31:0];
        
    always@* begin
    
    RD1 =(~rst) ? 32'b0 : Reg_File[A1];
    RD2 =(~rst) ? 32'b0 : Reg_File[A2];  
    
    end
    
    always@(posedge clk) begin
        if (WE3) Reg_File[A3] <= WD3 ;
    end    
    
    initial begin
        Reg_File[0] = 32'd0;
    end
    
endmodule
