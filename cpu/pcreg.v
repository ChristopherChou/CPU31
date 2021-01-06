`timescale 1ns / 1ps


module pcreg(clk,rst,ena,data_in,data_out);
    input clk;
    input rst;
    input ena;
    input [31:0]data_in;
    output reg[31:0]data_out;
   wire [31:0]data;
   always@(*) 
   begin
   if(ena==1)
   data_out=data;
   else
   data_out=data_out;
   end
    Asynchronous_D_FF DFF0(.CLK(clk),.D(data_in[0]),.RST_n(rst),.Q1(data[0]));
    Asynchronous_D_FF DFF1(.CLK(clk),.D(data_in[1]),.RST_n(rst),.Q1(data[1]));
    Asynchronous_D_FF DFF2(.CLK(clk),.D(data_in[2]),.RST_n(rst),.Q1(data[2]));
    Asynchronous_D_FF DFF3(.CLK(clk),.D(data_in[3]),.RST_n(rst),.Q1(data[3]));
    Asynchronous_D_FF DFF4(.CLK(clk),.D(data_in[4]),.RST_n(rst),.Q1(data[4]));
    Asynchronous_D_FF DFF5(.CLK(clk),.D(data_in[5]),.RST_n(rst),.Q1(data[5]));
    Asynchronous_D_FF DFF6(.CLK(clk),.D(data_in[6]),.RST_n(rst),.Q1(data[6]));
    Asynchronous_D_FF DFF7(.CLK(clk),.D(data_in[7]),.RST_n(rst),.Q1(data[7]));
    Asynchronous_D_FF DFF8(.CLK(clk),.D(data_in[8]),.RST_n(rst),.Q1(data[8]));
    Asynchronous_D_FF DFF9(.CLK(clk),.D(data_in[9]),.RST_n(rst),.Q1(data[9]));
    Asynchronous_D_FF DFF10(.CLK(clk),.D(data_in[10]),.RST_n(rst),.Q1(data[10]));
    Asynchronous_D_FF DFF11(.CLK(clk),.D(data_in[11]),.RST_n(rst),.Q1(data[11]));
    Asynchronous_D_FF DFF12(.CLK(clk),.D(data_in[12]),.RST_n(rst),.Q1(data[12]));
    Asynchronous_D_FF DFF13(.CLK(clk),.D(data_in[13]),.RST_n(rst),.Q1(data[13]));
    Asynchronous_D_FF DFF14(.CLK(clk),.D(data_in[14]),.RST_n(rst),.Q1(data[14]));
    Asynchronous_D_FF DFF15(.CLK(clk),.D(data_in[15]),.RST_n(rst),.Q1(data[15]));
    Asynchronous_D_FF DFF16(.CLK(clk),.D(data_in[16]),.RST_n(rst),.Q1(data[16]));
    Asynchronous_D_FF DFF17(.CLK(clk),.D(data_in[17]),.RST_n(rst),.Q1(data[17]));
    Asynchronous_D_FF DFF18(.CLK(clk),.D(data_in[18]),.RST_n(rst),.Q1(data[18]));
    Asynchronous_D_FF DFF19(.CLK(clk),.D(data_in[19]),.RST_n(rst),.Q1(data[19]));
    Asynchronous_D_FF DFF20(.CLK(clk),.D(data_in[20]),.RST_n(rst),.Q1(data[20]));
    Asynchronous_D_FF DFF21(.CLK(clk),.D(data_in[21]),.RST_n(rst),.Q1(data[21]));
    Asynchronous_D_FF1 DFF22(.CLK(clk),.D(data_in[22]),.RST_n(rst),.Q1(data[22]));//reset==1
    Asynchronous_D_FF DFF23(.CLK(clk),.D(data_in[23]),.RST_n(rst),.Q1(data[23]));
    Asynchronous_D_FF DFF24(.CLK(clk),.D(data_in[24]),.RST_n(rst),.Q1(data[24]));
    Asynchronous_D_FF DFF25(.CLK(clk),.D(data_in[25]),.RST_n(rst),.Q1(data[25]));
    Asynchronous_D_FF DFF26(.CLK(clk),.D(data_in[26]),.RST_n(rst),.Q1(data[26]));
    Asynchronous_D_FF DFF27(.CLK(clk),.D(data_in[27]),.RST_n(rst),.Q1(data[27]));
    Asynchronous_D_FF DFF28(.CLK(clk),.D(data_in[28]),.RST_n(rst),.Q1(data[28]));
    Asynchronous_D_FF DFF29(.CLK(clk),.D(data_in[29]),.RST_n(rst),.Q1(data[29]));
    Asynchronous_D_FF DFF30(.CLK(clk),.D(data_in[30]),.RST_n(rst),.Q1(data[30]));
    Asynchronous_D_FF DFF31(.CLK(clk),.D(data_in[31]),.RST_n(rst),.Q1(data[31]));
    
endmodule
