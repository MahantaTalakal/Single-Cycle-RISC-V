`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 09:28:18
// Design Name: 
// Module Name: Control_Unit_Top
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


module Control_Unit_Top(
    input [6:0]Op,funct7,
    input [2:0]funct3,
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,
    output [1:0]ImmSrc,
    output [3:0]ALUControl

    );
    
    wire [1:0] ALUOp_Top;
    
    Main_Decoder main_decoder_inst (
    .Op(Op),             // Opcode input
    .RegWrite(RegWrite),// Register write enable output
    .ALUSrc(ALUSrc),    // ALU source select output
    .MemWrite(MemWrite),// Memory write enable output
    .ResultSrc(ResultSrc), // Result source select output
    .Branch(Branch),     // Branch output
    .ImmSrc(ImmSrc),    // Immediate source output
    .ALUOp(ALUOp_Top)       // ALU operation select output
    );
    
    ALU_Decoder alu_decoder_inst (
    .ALUOp(ALUOp_Top),      // ALU operation selector
    .funct3(funct3),     // funct3 field from instruction
    .funct7(funct7),     // funct7 field from instruction
    .op(Op),             // opcode field
    .ALU_Ctr(ALUControl)    // ALU control output
    );
endmodule
