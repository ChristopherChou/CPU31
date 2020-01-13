`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 16:18:59
// Design Name: 
// Module Name: Asynchronous_D_FF
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


module Asynchronous_D_FF(CLK,D,RST_n,Q1 );
    input CLK;
    input D;
    input RST_n;
    output reg Q1;
   always@(posedge RST_n or negedge CLK)
   //always@(posedge RST_n or posedge CLK)
    begin
    if(RST_n==1)
    Q1<=0;
    else
    Q1<=D; 
    end
endmodule
