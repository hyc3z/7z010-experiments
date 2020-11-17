`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/17 14:43:13
// Design Name: 
// Module Name: led_flash
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


module led_flash(
    input wire sys_clk,
    input wire rst_n,
    output reg [3:0] led
    );

reg [27:0] cnt;
wire add_cnt;
wire end_cnt;

always @(posedge sys_clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt<='d0;
    end
    else if(add_cnt)begin
         if(end_cnt)
            cnt<='d0;
         else
            cnt<=cnt+1'b1;
    end
end

assign add_cnt=1;
assign end_cnt=add_cnt&&cnt==10_000_000-1;

always @(posedge sys_clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        led<=4'b1110;
    end
    else if(end_cnt)begin
        led<={led[2:0],led[3]};
    end
    else begin
        led <= led;
    end
end

endmodule
