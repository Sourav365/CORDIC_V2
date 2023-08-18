`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2023 03:55:13 PM
// Design Name: 
// Module Name: rot_mode_top
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


module rot_mode_top #(parameter N = 16, STAGE = 16)(
    input  clk, rst,
    input  signed [N-1:0] x_in, y_in, angle_in,
    output signed [N-1:0] x_out, y_out
    );
    
    // Reg to store micro angles
    reg [N-1:0] micro_angle [0:STAGE-1];
    
    always @(rst) begin
        micro_angle[0] = 4500; micro_angle[1] = 2656; micro_angle[2] = 1403; micro_angle[3] = 0712; //3-digit decimal
        micro_angle[4] = 0357; micro_angle[5] = 0179; micro_angle[6] = 0089; micro_angle[7] = 0044;
        micro_angle[8] = 0022; micro_angle[9] = 0011; micro_angle[10]= 0005; micro_angle[11]= 0002;
        micro_angle[12]= 0001; micro_angle[13]= 0000; micro_angle[14]= 0000; micro_angle[15]= 0000;
    end
    
    //Internal variables
    wire [N-1:0] x_temp  [0:STAGE];
    wire [N-1:0] y_temp  [0:STAGE];
    wire [N-1:0] ang_diff[0:STAGE];
    
    //Input, Output assign
    assign x_temp[0] = x_in, 
           y_temp[0] = y_in,
           ang_diff[0] = angle_in;
    assign x_out = x_temp[STAGE] * 0.607,
           y_out = y_temp[STAGE] * 0.607;
    
    //All stages
    genvar i;
    
    generate
        for(i=0; i<STAGE; i=i+1)
            begin: rotation_single
            rot_single #(.SHIFT_AMNT(i)) u (
            .clk(clk), .rst(rst),
            .x_in(x_temp[i]), .y_in(y_temp[i]), .angle_diff_in(ang_diff[i]), .micro_angle(micro_angle[i]),
            .x_out(x_temp[i+1]), .y_out(y_temp[i+1]), .angle_diff_out(ang_diff[i+1])
            );
            end
    endgenerate
    
    /*rot_single #(.SHIFT_AMNT(0)) u0 (
    .clk(clk), .rst(rst),
    .x_in(x_temp[0]), .y_in(y_temp[0]), .angle_diff_in(ang_diff[0]), .micro_angle(micro_angle[0]),
    .x_out(x_temp[1]), .y_out(y_temp[1]), .angle_diff_out(ang_diff[1])
    );
    
    rot_single #(.SHIFT_AMNT(1)) u1 (
    .clk(clk), .rst(rst),
    .x_in(x_temp[1]), .y_in(y_temp[1]), .angle_diff_in(ang_diff[1]), .micro_angle(micro_angle[1]),
    .x_out(x_temp[2]), .y_out(y_temp[2]), .angle_diff_out(ang_diff[2])
    );
    
    rot_single #(.SHIFT_AMNT(2)) u2 (
    .clk(clk), .rst(rst),
    .x_in(x_temp[2]), .y_in(y_temp[2]), .angle_diff_in(ang_diff[2]), .micro_angle(micro_angle[2]),
    .x_out(x_temp[3]), .y_out(y_temp[3]), .angle_diff_out(ang_diff[3])
    );
    
    rot_single #(.SHIFT_AMNT(3)) u3 (
    .clk(clk), .rst(rst),
    .x_in(x_temp[3]), .y_in(y_temp[3]), .angle_diff_in(ang_diff[3]), .micro_angle(micro_angle[3]),
    .x_out(x_temp[4]), .y_out(y_temp[4]), .angle_diff_out(ang_diff[4])
    );*/
    
    
    
endmodule

/***********************Check If Angle Difference = 0*******************/
/****************Initial Angle = Angle_in, Final Angle = 0**************/
module rot_single #(parameter N = 16, SHIFT_AMNT = 0)(
    input  clk, rst,
    input  signed [N-1:0] x_in, y_in, angle_diff_in, micro_angle,
    output reg signed [N-1:0] x_out, y_out, angle_diff_out
    );
    
    always @(posedge clk) begin
        if(!rst) begin
            if(angle_diff_in > 0) begin //Rotate clkwise
                x_out <= x_in + (y_in >>> SHIFT_AMNT);
                y_out <= y_in - (x_in >>> SHIFT_AMNT);
                angle_diff_out <= angle_diff_in - micro_angle;
            end
            
            else begin
                x_out <= x_in - (y_in >>> SHIFT_AMNT);
                y_out <= y_in + (x_in >>> SHIFT_AMNT);
                angle_diff_out <= angle_diff_in + micro_angle;
            end
        end
    end
endmodule
