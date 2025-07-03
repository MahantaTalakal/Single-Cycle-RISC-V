`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 12:13:25
// Design Name: 
// Module Name: ALU_Decoder
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

module ALU_Decoder(
    input wire [1:0] ALUOp,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [6:0] op,
    output reg [3:0] ALU_Ctr
);

always @(*) begin
    case (ALUOp)
        2'b00: ALU_Ctr = 4'b0000; // add   (lw, sw)
        2'b01: ALU_Ctr = 4'b0001; // sub   (beq)
        2'b10: begin 
            if (funct3 == 3'b000 && {op[5], funct7[5]} != 2'b11)
                ALU_Ctr = 4'b0000;
            else if (funct3 == 3'b101 && {op[5], funct7[5]} == 2'b11)
                ALU_Ctr = 4'b1001;
            else if (funct3 == 3'b000 && {op[5], funct7[5]} == 2'b11)
                ALU_Ctr = 4'b0001;
            else if (funct3 == 3'b010)
                ALU_Ctr = 4'b0101;
            else if (funct3 == 3'b110)
                ALU_Ctr = 4'b0011;
            else if (funct3 == 3'b111)
                ALU_Ctr = 4'b0010;
                
            else if (funct3 == 3'b001)
                ALU_Ctr = 4'b0100;
            else if (funct3 == 3'b011)
                ALU_Ctr = 4'b0110;
            else if (funct3 == 3'b100)
                ALU_Ctr = 4'b0111;
            else if (funct3 == 3'b101)
                ALU_Ctr = 4'b1000;
                
                
            else
                ALU_Ctr = 4'b0000;
        end
        default: ALU_Ctr = 4'b0000;    
    endcase
end

endmodule