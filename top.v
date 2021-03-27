`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2021 03:22:35 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input [3:0] buttons,
    input [1:0] sw,
    
    output [3:0] an,
    output [6:0] seg
    );
    
    wire [15:0] count;
    
    meter m1(
        .clk        (clk),
        .buttons    (buttons),
        .reset      (sw),
        .count      (count)
    );

    sevenseg ss (
        .clk                (clk),
        .reset              (sw),
        .current_count      (count),
        .an                 (an),
        .seg                (seg)
    ); 
    
    
endmodule
