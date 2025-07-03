`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 09:18:07
// Design Name: 
// Module Name: tb_Sign_Extend
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

module tb_Sign_Extend;

    // Inputs
    reg [11:0] Immediate_in;
    // Outputs
    wire [31:0] Sign_ext_Immediate;

    // Instantiate the Unit Under Test (UUT)
    Sign_Extend uut (
        .Immediate_in(Immediate_in), 
        .Sign_ext_Immediate(Sign_ext_Immediate)
    );

    initial begin
        $display("Time\tImmediate_in\tSign_ext_Immediate");
        $monitor("%0t\t%h\t\t%h", $time, Immediate_in, Sign_ext_Immediate);

        // Test positive value (0x07F)
        Immediate_in = 12'h07F;    // 127
        #10;
        // Test negative value (0x800) (sign bit set)
        Immediate_in = 12'h800;    // -2048 in 12-bit 2's complement
        #10;
        // Test positive max (0x7FF)
        Immediate_in = 12'h7FF;    // 2047
        #10;
        // Test negative min (0xFFF)
        Immediate_in = 12'hFFF;    // -1 in 12-bit 2's complement
        #10;
        // Test zero
        Immediate_in = 12'h000;    // 0
        #10;
        // Test random value
        Immediate_in = 12'h123;    // 291
        #10;

        $finish;
    end

endmodule