`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2021 03:47:24 PM
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

module ssd_digit(
//This module coverts the 7 bit binary value into what number it would display on the 7 segment display
    input enable,
    input [6:0] seg_lines,
    output reg [3:0] displayed_value
    );
    
    always@(*)
        if(enable) begin
            case (ssd)
            7'b1000000: value = 0;
            7'b1111001: value = 1;
            7'b0100100: value = 2;     
            7'b0110000: value = 3;
            7'b0011001: value = 4;
            7'b0010010: value = 5;
            7'b0000011: value = 6;
            7'b1111000: value = 7;
            7'b0000000: value = 8;
            7'b0011000: value = 9;
            7'b0001000: value = 10;
            7'b0000011: value = 11;
            7'b1000110: value = 12;
            7'b0100001: value = 13;
            7'b0000110: value = 14;
            7'b0001110: value = 15;
            default: value = 'bx;
            endcase
        end
endmodule


module top
    #(
    parameter ms_limit = 100000
    )
    (
    input clk,
    input [7:0] sw,
    output reg [6:0] seg,
    output reg dp,
    output reg [3:0] an
    );


//Create a reg called digit that holds the value to write to the 7 segment display
reg [3:0] digit;
always @(posedge clk)
begin
    case(ssd_select)
        0: digit <= sec_count[3:0];
        1: digit <= sec_count[7:4];
        2: digit <= sw[3:0];
        3: digit <= sw[7:4];
    endcase
 end
    
//assign digit = ssd_select ? sec_count[7:4] : sec_count[3:0];   //previously sw[]

//Write digit to the 7 segment display lines 
always @(posedge clk)
    begin
         case(digit)   
            0: seg <= 7'b1000000;
            1: seg <= 7'b1111001;
            2: seg <= 7'b0100100;      
            3: seg <= 7'b0110000;
            4: seg <= 7'b0011001;
            5: seg <= 7'b0010010;
            6: seg <= 7'b0000011;
            7: seg <= 7'b1111000;
            8: seg <= 7'b0000000;
            9: seg <= 7'b0011000;
            10: seg <= 7'b0001000;
            11: seg <= 7'b0000011;
            12: seg <= 7'b1000110;
            13: seg <= 7'b0100001;
            14: seg <= 7'b0000110;
            15: seg <= 7'b0001110;
         endcase
    end
    
    //Alternate the ssd_select line at a rate determined by ms_pulse.
reg [1:0] ssd_select = 0;    
always @(posedge clk)
begin
    if(ms_pulse) ssd_select <= ssd_select + 1;     
end

//Actually map the ssd_select register onto the module outputs that drive the 7 segment anodes.
always @(*)
begin
    case(ssd_select)
        0: an <= 4'b1110;
        1: an <= 4'b1101;
        2: an <= 4'b1011;
        3: an <= 4'b0111;
    endcase
end
    
    
integer count = 0;
reg ms_pulse = 0;

//Generates a pulse of 1 clock width every 100,000 clock cycles. For a 100M clock, this is a pulse every microsecond.
always @(posedge clk)
begin
    if (count == ms_limit-1) begin
        count <=0;
        ms_pulse <= 1;
    end 
    else begin
        count <= count+1;
        ms_pulse <=0;
    end
end    

//Generate sec_pulse signal that pulses every second
integer ms_count = 0;
reg sec_pulse = 0;
always@ (posedge clk)
    begin
        sec_pulse <=0;
        if (ms_pulse)
            if (ms_count  == 999)
                begin
                    ms_count <=0;
                    sec_pulse <=1;
                end
            else
                ms_count <= ms_count + 1;
    end

//Increment a counter for every second
reg [7:0] sec_count = 0;
always @(posedge sec_pulse) 
begin 
    sec_count = sec_count + 1; 
end

endmodule

