`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 09:51:37 PM
// Design Name: 
// Module Name: test_sin_cos_theta
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


module test_sin_cos_theta();
    reg clk, rst;
    reg signed [15:0] angle_in;
    wire signed [15:0] sin_theta, cos_theta;
    
    rot_mode_top uut (
    .clk(clk), .rst(rst),
    .x_in(0_00), .y_in(1_00), .angle_in(angle_in),
    .x_out(sin_theta), .y_out(cos_theta)
    );
    
    always #5 clk=~clk;
    
    initial begin
        clk=0; rst=1;
        #3; rst=0;

        angle_in = 00_00; #10;
        angle_in = 30_00; #10;
        angle_in = 45_00; #10;
        angle_in = 60_00; #10;
        angle_in = 90_00; #200;
        $finish;
    end
endmodule
