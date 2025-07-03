`timescale 1ns / 1ps

module tb_Register_File;

    // Inputs
    reg clk;
    reg rst;
    reg WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;

    // Outputs
    wire [31:0] RD1, RD2;

    // Instantiate the Unit Under Test (UUT)
    Register_File uut (
        .clk(clk),
        .rst(rst),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    initial begin
        // Initialize Inputs
        rst = 0; WE3 = 0; A1 = 0; A2 = 0; A3 = 0; WD3 = 0;

        // Reset test
        #3;
        rst = 0; // Assert reset
        #10;
        $display("After reset: RD1=%h, RD2=%h (should both be 0)", RD1, RD2);

        // Deassert reset and check initial value
        rst = 1;
        #10;
        A1 = 9; A2 = 9; // Check initial loaded value
        #10;
        $display("After deassert reset: Reg_File[9]=%h", RD1);

        // Write value to Reg_File[5]
        A3 = 5; WD3 = 32'hDEADBEEF; WE3 = 1;
        #10; // Wait for positive edge
        WE3 = 0;

        // Read back from Reg_File[5]
        A1 = 5; A2 = 0;
        #10;
        $display("After write: Reg_File[5]=%h", RD1);

        // Write value to Reg_File[10]
        A3 = 10; WD3 = 32'h12345678; WE3 = 1;
        #10;
        WE3 = 0;

        // Read back from Reg_File[10]
        A1 = 10; A2 = 0;
        #10;
        $display("After write: Reg_File[10]=%h", RD1);

        // Test reading two different registers
        A1 = 9; A2 = 10;
        #10;
        $display("Read Reg_File[9]=%h, Reg_File[10]=%h", RD1, RD2);

        // End simulation
        $finish;
    end

endmodule