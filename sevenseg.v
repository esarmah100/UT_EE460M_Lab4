`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 07:03:34 AM
// Design Name: 
// Module Name: sevenseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: provides time multiplexing for 4 sevenseg displays and modulo for upto 4 digit numbers 

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sevenseg(
  input clk,
  input [1:0] reset,
  input [15:0] current_count,
  output [3:0] an,
  output reg [6:0] seg
); 

wire half_second_clk, half_second;

clk_divider #(.COUNT(50000000)) half_second_clk_mod (clk, half_second_clk);
debounce_and_single_pulse half_second_pulse(clk, half_second_clk, half_second);

reg on0 = 1;

wire [6:0] out_count;

// BCD instantiation
reg [3:0] bcd_count = 0; // Input to BCD, output directly tied to seg
bcd counter (clk, bcd_count, out_count);

// Clock divider - Divide-by-2
reg [15:0] count = 0;
wire slow_clk = count[15];

// State register variables
reg [1:0] current = 0;
reg [1:0] next = 0;

// Sequential logic
always @(posedge slow_clk) current <= next;

// Combinational logic
reg [3:0] an_buf = 0;
assign an = an_buf;
always @(posedge clk) begin
    count <= count + 1;
    seg <= out_count;

    if(half_second) begin
        on0 <= on0 ^ 1;
    end

    if(reset) begin // Synchronous reset
        an_buf <= 4'b1110;
        next <= 0;// set next state
    end     
    else begin
        case(current)
        0: begin // state 0  
                if(!current_count) begin
                    if(on0)
                        an_buf <= 4'b1110; 
                    else
                        an_buf <= 4'b1111; 
                end
                else if(current_count < 200) begin 
                    if(current_count % 2 != 0)
                        an_buf <= 4'b1111;
                    else
                        an_buf <= 4'b1110;
                end 
                else begin
                    an_buf <= 4'b1110; 
                end

                //bcd input for count
                bcd_count <= ((current_count % 1000) % 100) % 10;
                next <= 1; // set next state
            end
        1: begin // state 1
                if(!current_count) begin
                    if(on0)
                        an_buf <= 4'b1101; 
                    else
                        an_buf <= 4'b1111; 
                end
                else if(current_count < 200) begin 
                    if(current_count % 2 != 0)
                        an_buf <= 4'b1111;
                    else
                        an_buf <= 4'b1101; 
                end 
                
                else begin        
                    an_buf <= 4'b1101;
                end

                //bcd input for count
                bcd_count <= ((current_count % 1000) % 100)/10;  
                next <= 2;
            end
        2:begin
                if(!current_count) begin
                    if(on0)
                        an_buf <= 4'b1011; 
                    else
                        an_buf <= 4'b1111; 
                end
                else if(current_count < 200) begin 
                    if(current_count % 2 != 0)
                        an_buf <= 4'b1111;
                    else
                        an_buf <= 4'b1011; 
                end 
                else begin
                    an_buf <= 4'b1011;
                end 

                //bcd input for count
                bcd_count <= (current_count % 1000)/100;
                next <= 3;
            end
        3:begin
            if(!current_count) begin
                if(on0)
                    an_buf <= 4'b0111; 
                else
                    an_buf <= 4'b1111; 
            end
            else if(current_count < 200) begin 
                if(current_count % 2 != 0)
                    an_buf <= 4'b1111;
                else
                    an_buf <= 4'b0111; 
            end 
            else begin
                an_buf <= 4'b0111;
            end

            //bcd input for count
            bcd_count <= (current_count % 10000)/1000;
            next <= 0;
        end
        default: begin
            //bcd input for step count
            bcd_count <= 4'd0000;
            an_buf <= 4'b1110;
            next <= 1;
            end
        endcase
    end
end

endmodule
