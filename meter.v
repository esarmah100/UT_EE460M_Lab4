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

    button_debounce up_button(clk, buttons[0], up);
    button_debounce left_button(clk, buttons[1], left);
    button_debounce right_button(clk, buttons[2], right);
    button_debounce down_button(clk, buttons[3], down);

    reg [15:0]new_count = 0;

    clk_divider #(.COUNT(100000000)) second_clk_mod (clk, second_clk);

    initial begin
        count = 0;
    end

    always @(posedge second_clk) begin
        if(new_count > 0)begin
            new_count <= new_count - 1;
        end
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
            count <= new_count;
        end

    end

    
     
endmodule

module button_debounce(
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


