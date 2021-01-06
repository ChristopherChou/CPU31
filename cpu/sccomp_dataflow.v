`timescale 1ns / 1ps


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc
    );
    wire [31:0] imm;
    wire [31:0] Rt;
    wire [31:0] alu_r;
    wire cs;
    wire dm_w;
    wire dm_r;
    wire [31:0] ram_out;
    assign inst=imm;

    imem imem(((pc- 32'h00400000)/4),imm);
    //imem im(pc,inst)
    //IMEM imem(1,((pc- 32'h00400000)/4),imm);

    cpu sccpu(clk_in,reset,imm,ram_out, //input
                Rt,alu_r,pc,cs,dm_w,dm_r); //output

    DMEM dram(
    .clk(clk_in),
    .CS(cs),  //enable control signal
    .DM_W(dm_w), //write
    .DM_R(dm_r), //read
    .Addr((alu_r[9:0]-32'h10010000)/4),
    .Data_in(Rt),
    .Data_out(ram_out)
     );   
    
endmodule

