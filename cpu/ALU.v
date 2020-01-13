`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 10:48:39
// Design Name: 
// Module Name: ALU
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

module ALU(
        input [31:0] a,        //OP1
        input [31:0] b,        //OP2
        input [3:0] aluc,    //controller
        output [31:0] r,    //result
        output zero,
        output carry,
        output negative,
        output overflow);
        
    parameter Addu    =    4'b0000;    //r=a+b unsigned
    parameter Add    =    4'b0010;    //r=a+b signed
    parameter Subu    =    4'b0001;    //r=a-b unsigned
    parameter Sub    =    4'b0011;    //r=a-b signed
    parameter And    =    4'b0100;    //r=a&b
    parameter Or    =    4'b0101;    //r=a|b
    parameter Xor    =    4'b0110;    //r=a^b
    parameter Nor    =    4'b0111;    //r=~(a|b)
    parameter Lui1    =    4'b1000;    //r={b[15:0],16'b0}
    parameter Lui2    =    4'b1001;    //r={b[15:0],16'b0}
    parameter Slt    =    4'b1011;    //r=(a-b<0)?1:0 signed
    parameter Sltu    =    4'b1010;    //r=(a-b<0)?1:0 unsigned
    parameter Sra    =    4'b1100;    //r=b>>>a 
    parameter Sll    =    4'b1110;    //r=b<<a
    parameter Srl    =    4'b1101;    //r=b>>a
    
    parameter bits=31;
    parameter ENABLE=1,DISABLE=0;
    
    reg [32:0] result;
    wire signed [31:0] sa=a,sb=b;
    
    always@(*)begin
        case(aluc)
            Addu: begin
                result=a+b;
            end
            Subu: begin
                result=a-b;
            end
            Add: begin
                result=sa+sb;
            end
            Sub: begin
                result=sa-sb;
            end
            Sra: begin
                if(a==0) {result[31:0],result[32]}={b,1'b0};
                else {result[31:0],result[32]}=sb>>>(a-1);
            end
            Srl: begin
                if(a==0) {result[31:0],result[32]}={b,1'b0};
                else {result[31:0],result[32]}=b>>(a-1);
            end
            Sll: begin
                result=b<<a;
            end
            And: begin
                result=a&b;
            end
            Or: begin
                result=a|b;
            end
            Xor: begin
                result=a^b;
            end
            Nor: begin
                result=~(a|b);
            end
            Sltu: begin
                result=a<b?1:0;
            end
            Slt: begin
                result=sa<sb?1:0;
            end
            Lui1,Lui2: result = {b[15:0], 16'b0};
            default:
                result=a+b;
        endcase
    end
    
    assign r=result[31:0];
    assign carry = result[32]; 
    assign zero=(r==32'b0)?1:0;
    assign negative=result[31];
    assign overflow=result[32];
endmodule
