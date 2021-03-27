`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 07:10:57 AM
// Design Name: 
// Module Name: bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: binary to decimal conversion for sevenseg display for values 0 - 9
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module bcd(
    input clk,
    input [3:0] num,
    output [6:0] seg
    );
    
    reg [6:0] sseg = 0; 
    assign seg = sseg;
    
    always @(posedge clk) begin
        case(num)
        4'b0000: sseg <= 7'b1000_000;        //  0
        4'b0001: sseg <= 7'b1111_001;        //  1
        4'b0010: sseg <= 7'b0100_100;        //  2
        4'b0011: sseg <= 7'b0110_000;        //  3
        4'b0100: sseg <= 7'b0011_001;        //  4
        4'b0101: sseg <= 7'b0010_010;        //  5
        4'b0110: sseg <= 7'b0000_010;        //  6
        4'b0111: sseg <= 7'b1111_000;        //  7
        4'b1000: sseg <= 7'b0000_000;        //  8
        4'b1001: sseg <= 7'b0010_000;        //  9
        default: sseg <= 7'b1111111;
        endcase 
    end
    
endmodule
