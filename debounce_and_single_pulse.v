`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jaxon Coward
// 
// Create Date: 03/28/2021 12:08:16 PM
// Design Name: 
// Module Name: meter
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


module debounce_and_single_pulse(
    input clk,
    input in,
    output out
    );

    reg Q0 = 0;
    reg Q1 = 0;
    wire slow_clk;

    assign out = Q0 & ~Q1;

    clk_divider slow_clk_mod (clk, slow_clk);

    always @(posedge slow_clk) begin
        Q0 <= in;
    end

    always @(posedge clk) begin
        Q1 <= Q0;
    end


endmodule
