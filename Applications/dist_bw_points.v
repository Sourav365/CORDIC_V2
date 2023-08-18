`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 10:26:24 PM
// Design Name: 
// Module Name: test_dist_bw_points
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


module test_dist_bw_points();
    reg  clk, rst;
    reg  signed [15:0] x_in1, x_in2;
    reg  signed [15:0] y_in1, y_in2;
    wire signed [15:0] dist;
    
    
    vect_mode_top #(.Y_REF(0)) uut (
    .clk(clk), .rst(rst),
    .x_in(x_in2-x_in1), .y_in(y_in2-y_in1),
    .r_out(dist), .angle_out()
    );
    
    always #5 clk=~clk;
    
    initial begin
        clk=0; rst=1;
        #3; rst=0;
        x_in1=0_00; y_in1=0_00;
        x_in2=4_00; y_in2=3_00; #10;
             
        x_in1=0_00; y_in1=4_00;
        x_in2=10_00; y_in2=2_00; #10;
        
        x_in1=10_00; y_in1=5_00;
        x_in2=8_00; y_in2=2_00; #200;
        $finish;
    end
endmodule
