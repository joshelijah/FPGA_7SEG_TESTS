`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 06:16:24 PM
// Design Name: 
// Module Name: test_bench
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

module test_bench(

    );
    
wire [3:0] hex_val_to_display;
reg [1:0] selected_digit = 0;
wire seg_lines = 7'b0000000;

reg clk = 1;
reg [7:0] sw;

ssd_digit digit0(
    .enable(selected_digit == 0),
    .seg_lines(seg_lines),
    .displayed_value(hex_val_to_display)
);

ssd_digit digit1(
    .enable(selected_digit == 1),
    .seg_lines(seg_lines),
    .displayed_value(hex_val_to_display)

);

ssd_digit digit2(
    .enable(selected_digit == 2),
    .seg_lines(seg_lines),
    .displayed_value(hex_val_to_display)

);

ssd_digit digit3(
    .enable(selected_digit == 3),
    .seg_lines(seg_lines),
    .displayed_value(hex_val_to_display)

);

top top_instance0(
    .clk(clk),
    .sw(sw),
    output reg [6:0] .seg(),
    output reg dp,
    output reg [3:0] an

);

endmodule
