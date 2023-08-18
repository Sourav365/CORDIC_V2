`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 08:18:37 PM
// Design Name: 
// Module Name: test_vect_mode
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


module test_vect_mode();
    reg  clk, rst;
    reg  signed [15:0] x_in;
    reg  signed [15:0] y_in;
    wire signed [15:0] r_out;
    wire signed [15:0] angle_out;
    
    
    vect_mode_top uut (
    .clk(clk), .rst(rst),
    .x_in(x_in), .y_in(y_in),
    .r_out(r_out), .angle_out(angle_out)
    );
    
    always #5 clk=~clk;
    
    initial begin
        clk=0; rst=1;
        #3; rst=0;
        x_in=0_00; y_in=4_00; #10;
        x_in=1_00; y_in=3_00; #10;
        x_in=3_00; y_in=4_00; #10;
        x_in=6_00; y_in=8_00; #10;
        x_in=6_00; y_in=10_00; #600;
        //$finish;
    end
endmodule
