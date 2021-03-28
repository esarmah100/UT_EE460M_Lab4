`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2021 03:22:16 PM
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


module meter(
    input clk,
    input [3:0] buttons,//0-Up, 1-Left, 2-Right, 3-Down
    input [1:0] reset,
    
    output reg [15:0]count
    );

    wire up, left, right, down, second_clk;

    debounce_and_single_pulse up_button(clk, buttons[0], up);
    debounce_and_single_pulse left_button(clk, buttons[1], left);
    debounce_and_single_pulse right_button(clk, buttons[2], right);
    debounce_and_single_pulse down_button(clk, buttons[3], down);

    wire decrement;

    clk_divider #(.COUNT(100000000)) second_clk_mod (clk, second_clk);
    debounce_and_single_pulse second_pulse(clk, second_clk, decrement);

    initial begin
        count = 0;
    end

    always @(posedge clk) begin
        if(reset[0])begin
            count <= 10;
        end
        else if(reset[1])begin
            count <= 205;
        end
        else if(up)begin
            count <= count + 10;
        end
        else if(left)begin
            count <= count + 180;
        end
        else if(right)begin
            count <= count + 200;
        end
        else if(down)begin
            count <= count + 550;
        end
        else begin
            if(count > 0)begin
                count <= count - decrement;
            end
        end

        if(count > 9999)begin
            count <= 9999;
        end

    end

    
     
endmodule




