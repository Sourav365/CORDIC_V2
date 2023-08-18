`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 04:48:01 PM
// Design Name: 
// Module Name: test_rot_mode
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


module test_rot_mode();

    reg clk, rst;
    reg signed [15:0] rotation_ang;
    reg signed [15:0] xi;
    reg signed [15:0] yi;
    wire signed [15:0] xf;
    wire signed [15:0] yf;

    rot_mode_top uut (
    .clk(clk), .rst(rst),
    .x_in(xi), .y_in(yi), .angle_in(rotation_ang),
    .x_out(xf), .y_out(yf)
    );
    
    always #5 clk <= ~clk;
    
    initial begin
        clk = 0; rst = 1;
        #3; rst = 0;
        xi = 3_00; yi = 4_00; rotation_ang = 53_00; #10;
        xi = 1_00; yi = 6_00; rotation_ang = 30_00; #10;
        xi = 2_00; yi = 1_00; rotation_ang = 1_00; #10;
        xi = 4_00; yi = 2_00; rotation_ang = 10_00; #200;
        $finish;
    end
endmodule
