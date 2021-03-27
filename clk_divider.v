`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jaxon Coward
// 
// Create Date: 03/27/2021 04:6:16 PM
// Design Name: 
// Module Name: clk_divider
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

module clk_divider #(
    parameter COUNT = 5000000//50 ms period
    )(
    input clk,
    output reg slow_clk
    );

    integer counter = 0;

    initial begin
        slow_clk = 0;
    end

    always @(posedge clk) begin
        counter <= counter + 1;
        if(counter >= (COUNT/2)) begin
            slow_clk <= ~slow_clk;
            counter <= 0;
        end
    end

endmodule

