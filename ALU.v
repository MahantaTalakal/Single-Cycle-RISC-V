`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 10:34:24
// Design Name: 
// Module Name: ALU
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


module ALU(
input wire[31:0] A,B,
input wire [3:0] ALU_ctr,
output Carry,OverFlow,Zero,Negetive,
output reg [31:0] result);

    wire[31:0] sum,AND,OR,SLT,SLL,SLTU,XOR,SRL,SRA;
    wire cout;
    assign {cout,sum} = ~ ALU_ctr[0] ? A+B : A+(~B+1);
    assign AND = A&B;
    assign OR = A|B;
    assign SLT = (A[31] == B[31]) ? (A < B) : A[31];
    assign SLL = A << B;
    assign XOR = A ^ B;
    assign SRL = A >> B;
    assign SRA = A >>> B;
    assign SLTU = A < B;
    
    always@(*) begin
        case(ALU_ctr)
            4'b0000 : result = sum;
            4'b0001 : result = sum;
            4'b0010 : result = AND;
            4'b0011 : result = OR;
            4'b0101 : result = SLT;
            4'b0100 : result = SLL;
            4'b0110 : result = SLTU;
            4'b0111 : result = XOR;
            4'b1000 : result = SRL;
            4'b1001 : result = SRA;
            default: result = {32{1'b0}};
        endcase
    end
    
    assign Carry = (~ALU_ctr[1] & cout);
    assign Negetive = result[31];
    assign Zero = ~| result;
    assign OverFlow = ((sum[31] ^ A[31]) & (~(ALU_ctr[0] ^ B[31] ^ A[31])) &(~ALU_ctr[1]));
    
endmodule
