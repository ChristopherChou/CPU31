`timescale 1ns / 1ps


module cpu(
    input clk_in,
    input reset,
    input [31:0]imem,//
    input [31:0] ram_out,
    output [31:0] Rt,
    output [31:0] alu_r,
    output [31:0] pc,
    output cs, //dmem control signal 
    output dm_w, //dmem write
    output dm_r//dmem read
    );
    
    wire [31:0]npc;
    wire M3,M3_2,M4,M4_2, M2,M5,M1,M1_2,M6,M7; //mux2
    wire ALUC3,ALUC2,ALUC1,ALUC0;
    wire RF_W; //regfiles write
    wire RL_CLK; //regfiles clk

    wire [3:0]ALUC;//alu control
    wire [31:0] PC;
    wire [31:0] mux_out_1;
    wire [31:0] mux_out_1_2;
    wire [31:0] mux_out_2;
    wire [31:0] mux_out_3;
    wire [31:0] mux_out_3_2;
    
    wire [31:0] mux_in_4;
    wire [31:0] mux_out_4;
    wire [31:0] mux_out_4_2;
    wire [31:0] mux_out_5;
    
    wire [31:0] Rs; //Rs

    wire [31:0] ext18_sign;
    wire [4:0] rdc;
    wire [4:0] rsc;
    wire [4:0] rtc;
    wire [31:0] ext16;
    wire [31:0] ext16_sign;
    wire ext16_sin_judge;
    
    
    wire zero;
    wire carry;
    wire negative;
    wire overflow;
    
    assign pc = PC;
    //assign RDC_T = rdc;
    assign  mux_out_2_T=mux_out_2;

 wire _add, _addu, _sub, _subu, _and, _or, _xor, _nor;
   wire _slt, _sltu, _sll, _srl, _sra, _sllv, _srlv, _srav, _jr;
   wire  _addi, _addiu, _andi, _ori, _xori, _lw, _sw;
   wire _beq, _bne, _slti, _sltiu, _lui, _j, _jal;
   
   //1~17
   assign _add = (imem[31:26]==6'b000000&&imem[5:0]==6'b100000)?1'b1:1'b0;
   assign _addu = (imem[31:26]==6'b000000&&imem[5:0]==6'b100001)?1'b1:1'b0;
   assign _sub = (imem[31:26]==6'b000000&&imem[5:0]==6'b100010)?1'b1:1'b0;
   assign _subu = (imem[31:26]==6'b000000&&imem[5:0]==6'b100011)?1'b1:1'b0;
   assign _and = (imem[31:26]==6'b000000&&imem[5:0]==6'b100100)?1'b1:1'b0;
   assign _or = (imem[31:26]==6'b000000&&imem[5:0]==6'b100101)?1'b1:1'b0;
   assign _xor = (imem[31:26]==6'b000000&&imem[5:0]==6'b100110)?1'b1:1'b0;
   assign _nor = (imem[31:26]==6'b000000&&imem[5:0]==6'b100111)?1'b1:1'b0;
   
   assign _slt = (imem[31:26]==6'b000000&&imem[5:0]==6'b101010)?1'b1:1'b0;
   assign _sltu = (imem[31:26]==6'b000000&&imem[5:0]==6'b101011)?1'b1:1'b0;
   assign _sll = (imem[31:26]==6'b000000&&imem[5:0]==6'b000000)?1'b1:1'b0;
   assign _srl = (imem[31:26]==6'b000000&&imem[5:0]==6'b000010)?1'b1:1'b0;
   assign _sra = (imem[31:26]==6'b000000&&imem[5:0]==6'b000011)?1'b1:1'b0;
   assign _sllv = (imem[31:26]==6'b000000&&imem[5:0]==6'b000100)?1'b1:1'b0;
   assign _srlv = (imem[31:26]==6'b000000&&imem[5:0]==6'b000110)?1'b1:1'b0;
   assign _srav = (imem[31:26]==6'b000000&&imem[5:0]==6'b000111)?1'b1:1'b0;
   assign _jr = (imem[31:26]==6'b000000&&imem[5:0]==6'b001000)?1'b1:1'b0;
   
   //18~29
   assign _addi = (imem[31:26]==6'b001000)?1'b1:1'b0;
   assign _addiu = (imem[31:26]==6'b001001)?1'b1:1'b0;
   assign _andi = (imem[31:26]==6'b001100)?1'b1:1'b0;
   assign _ori = (imem[31:26]==6'b001101)?1'b1:1'b0;
   assign _xori = (imem[31:26]==6'b001110)?1'b1:1'b0;
   assign _lw = (imem[31:26]==6'b100011)?1'b1:1'b0;
   assign _sw = (imem[31:26]==6'b101011)?1'b1:1'b0;
   assign _beq = (imem[31:26]==6'b000100)?1'b1:1'b0;
   assign _bne = (imem[31:26]==6'b000101)?1'b1:1'b0;
   assign _slti = (imem[31:26]==6'b001010)?1'b1:1'b0;
   assign _sltiu = (imem[31:26]==6'b001011)?1'b1:1'b0;
   assign _lui = (imem[31:26]==6'b001111)?1'b1:1'b0;
   
   //30 31
   assign _j = (imem[31:26]==6'b000010)?1'b1:1'b0;
   assign _jal = (imem[31:26]==6'b000011)?1'b1:1'b0;
   
   wire exception;
   wire [4:0] cause;
   wire wdata;
   assign wdata = Rt;
   wire [31:0] rdata; 
   wire [31:0] status;
   wire [31:0] exc_addr;  //un
   
   //Control signal expression
   assign M3 = _sll || _srl || _sra ;
   assign M3_2 = _jal ;
   assign M4 = _addi || _addiu || _andi || _ori || _xori || _slti || _sltiu || _lui || _lw || _sw ;
   assign M4_2 = _jal ;
   assign M6 =_addi||_addiu||_andi||_ori||_xori|||_slti||_sltiu||_lui||_lw;//||_mfc0;
   assign M7 =_jal;
   assign ALUC[3] = _slt || _sltu ||_sllv || _srlv || _srav || _sll || _srl || _sra || _slti || _sltiu || _lui ;
   assign ALUC[2] = _and || _or ||_xor || _nor || _sllv || _srlv || _srav || _sll || _srl || _sra || _andi || _ori || _xori ;
   assign ALUC[1] = _add || _sub ||_xor || _nor || _slt || _sltu || _sllv || _sll || _addi || _xori || _slti || _sltiu ;
   assign ALUC[0] = _sub || _subu ||_or || _nor || _slt || _srlv || _srl || _ori || _slti || _beq || _bne ;//||_teq;//cp0 teq
   assign M2 = !_lw;
   assign rdc = M6?imem[20:16]:(M7?5'd31:imem[15:11]);
   assign RF_W= (!_sw)&&(!_beq)&&(!_bne)&&(!_j)&&(!_jr);
   assign RL_CLK= ((!_sw)&&(!_beq)&&(!_bne)&&(!_j)&&(!_jal)&&(!_jr))&&clk_in;
   assign M5 = (_beq&&zero) || (_bne&&(!zero)) ;
   assign M1 = (!_j)&&(!_jal) ;
   assign M1_2 = _jr ;
   assign cs = _lw || _sw;
   assign dm_r = _lw;
   assign dm_w = _sw;
   assign ext16_sin_judge = _addi || _addiu || _slti||_sltiu || _lw; //sign_ext
   
    assign ext18_sign = {{14{imem[15]}},{imem[15:0],2'h0}};
    assign npc = PC + 4;
    assign ext16_sign = {{16{imem[15]}},imem[15:0]};//
    assign ext16 = {16'h0,imem[15:0]};
    assign mux_in_4 = ext16_sin_judge?ext16_sign:ext16;
    assign rsc = imem[25:21];
    assign rtc = imem[20:16];
    
assign mux_out_1=M1?mux_out_5:{PC[31:28],imem[25:0],2'b00};  //mux1
  
assign mux_out_1_2=M1_2?Rs:mux_out_1; //mux1_2

assign mux_out_2=M2?alu_r:ram_out; //mux2  

assign mux_out_3=M3?{27'b0,imem[10:6]}:Rs;

assign mux_out_3_2=M3_2?PC:mux_out_3;

assign mux_out_4=M4?mux_in_4:Rt;

assign mux_out_4_2=M4_2?32'd4:mux_out_4;

assign mux_out_5=M5?ext18_sign+npc:npc;

pcreg PCreg(
.clk(clk_in),
.rst(reset),
.ena(1),
//.wena(1),
.data_in(mux_out_1_2),
.data_out(PC)
);

regfile cpu_ref(
.clk(clk_in),
.rst(reset),
.ena(1),
.we(RF_W),
.raddr1(rsc), //rsc
.raddr2(rtc),//rtc
.waddr(rdc),  //rdc 5bits
.wdata(mux_out_2), //rd
.rdata1(Rs), //rs
.rdata2(Rt) //rt
        );
        
ALU alu(
.a(mux_out_3_2),
.b(mux_out_4_2),
.aluc(ALUC),
.r(alu_r),
.zero(zero),
.carry(carry),
.negative(negative),
.overflow(overflow)
            );

endmodule
