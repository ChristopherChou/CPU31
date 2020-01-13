`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 10:45:36
// Design Name: 
// Module Name: DMEM
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

module DMEM(
    input clk,
    input CS,  //enable control signal
    input DM_W, //write
    input DM_R, //read
    input [9:0] Addr,
    input [31:0] Data_in,
    output  [31:0] Data_out
    );
    
reg [31:0] num [0:31];   
    assign Data_out=CS? (DM_R? num[Addr]: 32'h00000000):32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
    always@(negedge clk or negedge CS)
    begin
    if(CS&&DM_W)num[Addr]<=Data_in;
    end
    endmodule

