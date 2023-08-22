`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2023 06:46:12 PM
// Design Name: 
// Module Name: vect_mode_x_ref
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


module vect_mode_x_ref #(parameter N = 16, STAGE = 16)(
    input  clk, rst,
    input  signed [N-1:0] x_in, y_in, X_REF,
    output signed [N-1:0] angle_out
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
    wire [N-1:0] x_temp     [0:STAGE];
    wire [N-1:0] y_temp     [0:STAGE];
    wire [N-1:0] ang_covered[0:STAGE];
    
    //Input, Output assign
    assign x_temp[0] = x_in, 
           y_temp[0] = y_in,
           ang_covered[0] = 0; // Initial angle = 0
    assign r_out     = x_temp[STAGE] * 0.607,
           angle_out = ang_covered[STAGE];
    
    //All stages
    genvar i;
    
    generate
        for(i=0; i<STAGE; i=i+1)
            begin: vectoring_single
            vec_single #(.SHIFT_AMNT(i)) u (
            .clk(clk), .rst(rst), .X_REF(X_REF),
            .x_in(x_temp[i]), .y_in(y_temp[i]), .ang_covered_in(ang_covered[i]), .micro_angle(micro_angle[i]),
            .x_out(x_temp[i+1]), .y_out(y_temp[i+1]), .ang_covered_out(ang_covered[i+1])
            );
            end
    endgenerate
 
    
endmodule

/*************************** Check If x == X_REF ***************************/
/**************** Initial Angle = 0, Final Angle = Angle_out **************/

module vec_single #(parameter N = 16, SHIFT_AMNT = 0)( //Y-axis as referance
    input  clk, rst,
    input  signed [N-1:0] x_in, y_in, ang_covered_in, micro_angle, X_REF,
    output reg signed [N-1:0] x_out, y_out, ang_covered_out
    );
    
    always @(posedge clk) begin
        if(!rst) begin
            if(x_in >= X_REF) begin //Rotate anti clkwise
                x_out <= x_in - (y_in >>> SHIFT_AMNT);
                y_out <= y_in + (x_in >>> SHIFT_AMNT);
                ang_covered_out <= ang_covered_in + micro_angle;
            end
            
            else begin //Rotate clkwise
                x_out <= x_in + (y_in >>> SHIFT_AMNT);
                y_out <= y_in - (x_in >>> SHIFT_AMNT);
                ang_covered_out <= ang_covered_in - micro_angle;
            end
        end
    end
endmodule
