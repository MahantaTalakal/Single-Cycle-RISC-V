`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.07.2025 11:37:58
// Design Name: 
// Module Name: ALU_tb
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


`timescale 1ns / 1ps

module ALU_tb;
    // Parameters
    parameter WIDTH = 32;
    parameter CTR_WIDTH = 3;

    // Inputs
    reg [WIDTH-1:0] A, B;
    reg [CTR_WIDTH-1:0] ALU_ctr;

    // Outputs
    wire [WIDTH-1:0] result;
    wire Carry, OverFlow, Zero, Negetive;

    // Instantiate the ALU
    ALU #(.WIDTH(WIDTH), .CTR_WIDTH(CTR_WIDTH)) uut (
        .A(A),
        .B(B),
        .ALU_ctr(ALU_ctr),
        .Carry(Carry),
        .OverFlow(OverFlow),
        .Zero(Zero),
        .Negetive(Negetive),
        .result(result)
    );

    // Task to display the result nicely
    task display_result;
        input [8*20-1:0] operation;
        begin
            $display("%s | A = %0d, B = %0d => result = %0d (0x%h), Carry = %b, Overflow = %b, Zero = %b, Negative = %b",
                     operation, A, B, result, result, Carry, OverFlow, Zero, Negetive);
        end
    endtask

    // Test sequence
    initial begin
        $display("===== ALU Testbench Started =====");

        // ADD: A = 15, B = 10
        A = 32'd15; B = 32'd10; ALU_ctr = 3'b000;
        #10 display_result("ADD");

        // SUB: A = 15, B = 10
        A = 32'd15; B = 32'd10; ALU_ctr = 3'b001;
        #10 display_result("SUB");

        // SUB with borrow: A = 10, B = 15
        A = 32'd10; B = 32'd15; ALU_ctr = 3'b001;
        #10 display_result("SUB with borrow");

        // AND
        A = 32'hF0F0F0F0; B = 32'h0FF00FF0; ALU_ctr = 3'b010;
        #10 display_result("AND");

        // OR
        A = 32'hF0F0F0F0; B = 32'h0FF00FF0; ALU_ctr = 3'b011;
        #10 display_result("OR");

        // SLT: A = 5, B = 10 (should be 1)
        A = 32'd5; B = 32'd10; ALU_ctr = 3'b001; #1; // preload subtraction
        ALU_ctr = 3'b101;
        #10 display_result("SLT A<B");

        // SLT: A = 15, B = 10 (should be 0)
        A = 32'd15; B = 32'd10; ALU_ctr = 3'b001; #1;
        ALU_ctr = 3'b101;
        #10 display_result("SLT A>=B");

        // ADD overflow: A = 2^31 - 1, B = 1
        A = 32'h7FFFFFFF; B = 32'd1; ALU_ctr = 3'b000;
        #10 display_result("ADD Overflow");

        // SUB overflow: A = -2^31, B = 1
        A = 32'h80000000; B = 32'd1; ALU_ctr = 3'b001;
        #10 display_result("SUB Overflow");

        // Zero result
        A = 32'd1234; B = 32'd1234; ALU_ctr = 3'b001;
        #10 display_result("SUB Zero");

        $display("===== ALU Testbench Finished =====");
        $finish;
    end

endmodule

