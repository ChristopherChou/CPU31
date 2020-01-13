`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 10:49:29
// Design Name: 
// Module Name: regfile
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


 module regfile(
 input clk,    
 input rst,
 input ena,    
 input we, 
 input [4:0] raddr1,  
 input [4:0] raddr2, 
 input [4:0] waddr,   
 input  [31:0] wdata, 
 output wire [31:0] rdata1,
 output wire [31:0] rdata2
);

reg [31:0]array_reg[31:0];
assign rdata1 = ena?array_reg[raddr1]:32'bz;
assign rdata2 = ena?array_reg[raddr2]:32'bz;
    always @(negedge clk or posedge rst)
    //always @(posedge clk or posedge rst)
        begin
        if (rst) begin
        array_reg[0] <= 32'h0;
        array_reg[1] <= 32'h0;
        array_reg[2] <= 32'h0;
        array_reg[3] <= 32'h0;
        array_reg[4] <= 32'h0;
        array_reg[5] <= 32'h0;
        array_reg[6] <= 32'h0;
        array_reg[7] <= 32'h0;
        array_reg[8] <= 32'h0;
        array_reg[9] <= 32'h0;
        array_reg[10] <= 32'h0;
        array_reg[11] <= 32'h0;
        array_reg[12] <= 32'h0;
        array_reg[13] <= 32'h0;
        array_reg[14] <= 32'h0;
        array_reg[15] <= 32'h0;
        array_reg[16] <= 32'h0;
        array_reg[17] <= 32'h0;
        array_reg[18] <= 32'h0;
        array_reg[19] <= 32'h0;
        array_reg[20] <= 32'h0;
        array_reg[21] <= 32'h0;
        array_reg[22] <= 32'h0;
        array_reg[23] <= 32'h0;
        array_reg[24] <= 32'h0;
        array_reg[25] <= 32'h0;
        array_reg[26] <= 32'h0;
        array_reg[27] <= 32'h0;
        array_reg[28] <= 32'h0;
        array_reg[29] <= 32'h0;
        array_reg[30] <= 32'h0;
        array_reg[31] <= 32'h0;
        end
        else if ((ena&we)&& (waddr != 0))
            array_reg[waddr] <= wdata;
    end
endmodule

