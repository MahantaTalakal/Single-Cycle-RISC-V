`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 08:55:49
// Design Name: 
// Module Name: Single_Cycle_Top
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


module Single_Cycle_Top(
    input clk,rst
    );
    
    wire [31:0] PC_Top, Instr_Top, Imm_Extend_Top, Src_A, Src_B;
    wire [3:0] ALU_Ctr_Top;
    wire [1:0] ImmSrc_Top;
    wire [31:0] ALU_Result, Read_Data,PC_Next;  
    wire RegWrite_Top,ALUSrc_Top,MemWrite_Top,ResultSrc_Top,Branch_Top;
    
    PC pc_inst (
    .PC_Next(PC_Next), // Connect your next PC value here
    .clk(clk),         // Clock signal
    .rst(rst),         // Reset signal
    .PC(PC_Top)            // Output: current PC value
    );
    
    PC_Adder pc_adder_inst (
    .PC(PC_Top),          // Current Program Counter input
    .PC_Next(PC_Next) // Next Program Counter output
    );
    
    Instruction_Memory instr_mem_inst (
    .PC(PC_Top),               // Connect your PC signal here
    .Rst(rst),             // Connect your reset signal here
    .Instruction(Instr_Top) // Output: fetched instruction
    );
    
    Register_File reg_file_inst (
    .clk(clk),      // Clock signal
    .rst(rst),      // Reset signal
    .WE3(RegWrite_Top),      // Write enable
    .A1(Instr_Top[19:15]),        // Read register 1 address
    .A2(Instr_Top[24:20]),        // Read register 2 address
    .A3(Instr_Top[11:7]),        // Write register address
    .WD3(ResultSrc_Top? Read_Data : ALU_Result),      // Write data
    .RD1(Src_A),      // Output: read data 1
    .RD2(Src_B)       // Output: read data 2
     );
     
     Sign_Extend sign_ext_inst (
    .Immediate_in(Instr_Top), 
    .ImmSrc(ImmSrc_Top[0]),        // 12-bit immediate input
    .Sign_ext_Immediate(Imm_Extend_Top) // 32-bit sign-extended output
     );
     
     ALU alu_inst (
    .A(Src_A),             // First operand
    .B(ALUSrc_Top ? Imm_Extend_Top : Src_B),             // Second operand
    .ALU_ctr(ALU_Ctr_Top), // ALU control input
    .Carry(),     // Carry output
    .OverFlow(),// Overflow output
    .Zero(),       // Zero output
    .Negetive(),// Negative output
    .result(ALU_Result)    // ALU result
    );
    
    Control_Unit_Top control_unit_top_inst (
    .Op(Instr_Top[6:0]),                // Opcode input
    .funct7(Instr_Top[31:25]),        // funct7 input
    .funct3(Instr_Top[14:12]),        // funct3 input
    .RegWrite(RegWrite_Top),   // Register write enable output
    .ALUSrc(ALUSrc_Top),       // ALU source select output
    .MemWrite(MemWrite_Top),   // Memory write enable output
    .ResultSrc(ResultSrc_Top), // Result source select output
    .Branch(Branch_Top),        // Branch output
    .ImmSrc(ImmSrc_Top),       // Immediate source output
    .ALUControl(ALU_Ctr_Top)// ALU control output
    );
    
    
    Data_Memory data_mem_inst (
    .clk(clk),     // Clock signal
    .rst(rst),     // Reset signal
    .WE(MemWrite_Top),       // Write Enable
    .A(ALU_Result),         // Address input
    .WD(Src_B),       // Write Data input
    .RD(Read_Data)        // Read Data output
    );
    
    
    
endmodule
