`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 20560
`timescale 1ns/1ps
`include "CPU.v"
//以0表示null
module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
		cpu.IF.instruction[ 0] = 32'b100011_00000_00001_00000_00000_000000;//lw 
		cpu.IF.instruction[ 1] = 32'b100011_00000_00010_00000_00000_000000;//lw 
		cpu.IF.instruction[ 2] = 32'b100011_00000_00011_00000_00000_000000;//lw 
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 4] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 6] = 32'b000100_00001_00110_00000_00001_110011;//beq x,1,one
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 8] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 10] = 32'b000100_00001_00100_00000_00001_111011;//beq x,2,two
		cpu.IF.instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 12] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 13] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 14] = 32'b000100_00001_01011_00000_00010_000011;//beq x,3,three
		cpu.IF.instruction[ 15] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 16] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 18] = 32'b000000_00000_00100_00101_00000_100000;//add $t2,$t2,2
		cpu.IF.instruction[ 19] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*while(--a)*/
		cpu.IF.instruction[ 20] = 32'b000000_00010_00110_00010_00000_100010;//--a
		cpu.IF.instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*trya*/
		cpu.IF.instruction[ 24] = 32'b000000_00000_00010_00111_00000_100000;//t1=a
		cpu.IF.instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*diva*/
		cpu.IF.instruction[ 28] = 32'b000000_00111_00101_00111_00000_100010;//t1=t1-t2
		cpu.IF.instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 32]=  32'b000000_00111_00000_01000_00000_101010;//slt $t4,$t1,$zero
		cpu.IF.instruction[ 33] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 36] = 32'b000100_01000_00110_00000_00000_001001;//beq $t4,1,Inca
		cpu.IF.instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 40] = 32'b000100_00111_00000_11111_11111_101011;//beq $t1,0,whilea
		cpu.IF.instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 42] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 44] = 32'b000010_00000_00000_00000_00000_011100;//j diva
		cpu.IF.instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 47] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*Inca*/
		cpu.IF.instruction[ 48] = 32'b000000_00101_00110_00101_00000_100000;//add $t2,$t2,1
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 51] = 32'b000000_00000_00000_00000_00000_100000;//NoP
		cpu.IF.instruction[ 52] = 32'b000100_00101_00010_00000_00000_001001;//beq $t2,a,Pa
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 54] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 56] = 32'b000010_00000_00000_00000_00000_011000;//j trya
		cpu.IF.instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 60] = 32'b000010_00000_00000_00000_00000_010100;//j whilea
		/*Pa*/
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 64] = 32'b101011_00000_00010_00000_00000_000001;//sw
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 68] = 32'b000000_00000_00100_00101_00000_100000;//add $t2,$t2,2
		cpu.IF.instruction[ 69] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*while(++b)*/
		cpu.IF.instruction[ 70] = 32'b000000_00011_00110_00011_00000_100000;//++b
		cpu.IF.instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 72] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*tryb*/
		cpu.IF.instruction[ 74] = 32'b000000_00000_00011_00111_00000_100000;//t1=b
		cpu.IF.instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 76] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 77] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*divb*/
		cpu.IF.instruction[ 78] = 32'b000000_00111_00101_00111_00000_100010;//t1=t1-t2
		cpu.IF.instruction[ 79] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 80] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 81] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 82]=  32'b000000_00111_00000_01000_00000_101010;//slt $t4,$t1,$zero
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 84] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 86] = 32'b000100_01000_00110_00000_00000_001001;//beq $t4,1,Incb
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 88] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 89] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 90] = 32'b000100_00111_00000_11111_11111_101011;//beq $t1,0,whileb
		cpu.IF.instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 92] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 94] = 32'b000010_00000_00000_00000_00001_001110;//j divb
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 96] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*Incb*/
		cpu.IF.instruction[ 98] = 32'b000000_00101_00110_00101_00000_100000;//add $t2,$t2,1
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 100] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 101] = 32'b000000_00000_00000_00000_00000_100000;//NoP
		cpu.IF.instruction[ 102] = 32'b000100_00101_00010_00000_00000_001001;//beq $t2,a,Pa
		cpu.IF.instruction[ 103] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 104] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 106] = 32'b000010_00000_00000_00000_00001_001010;//j tryb
		cpu.IF.instruction[ 107] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 108] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 109] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 110] = 32'b000010_00000_00000_00000_00001_000110;//j whileb
		/*Pb*/
		cpu.IF.instruction[ 111] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 112] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 113] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 114] = 32'b101011_00000_00011_00000_00000_000010;//sw
		cpu.IF.instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 116] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 117] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 118] = 32'b000010_00000_00000_00000_00010_011111;//jump 00
		cpu.IF.instruction[ 119] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 120] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 121] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		/*one*/
		cpu.IF.instruction[ 122] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 123] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 124] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 125] = 32'b000000_00000_00000_00010_00000_100000;//add a,0,0
		cpu.IF.instruction[ 126] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 127] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 128] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 129] = 32'b000000_00000_00100_00011_00000_100000;//add b,0,2
		cpu.IF.instruction[ 130] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 131] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 132] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 133] = 32'b000010_00000_00000_00000_00010_011101;//jump sw
		/*two*/
		cpu.IF.instruction[ 134] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 135] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 136] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 137] = 32'b000000_00000_00000_00010_00000_100000;//add a,0,0
		cpu.IF.instruction[ 138] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 139] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 140] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 141] = 32'b000000_00000_01011_00011_00000_100000;//add b,0,3
		cpu.IF.instruction[ 142] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 143] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 144] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 145] = 32'b000010_00000_00000_00000_00010_011101;//jump sw
		/*three*/
		cpu.IF.instruction[ 146] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 147] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 148] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[ 149] = 32'b000000_00000_00100_00010_00000_100000;//add a,0,2
		cpu.IF.instruction[ 150] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 151] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 152] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 153] = 32'b000000_00000_01100_00011_00000_100000;//add b,0,5
		cpu.IF.instruction[ 154] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 155] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 156] = 32'b000000_00000_00000_00000_00000_000000;
		cpu.IF.instruction[ 157] = 32'b101011_00000_00010_00000_00000_000001;//sw
		cpu.IF.instruction[ 158] = 32'b101011_00000_00011_00000_00000_000010;//sw
		for (i=159;i<200; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
	
end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd100;
	cpu.MEM.DM[1] = 32'd0;
	cpu.MEM.DM[2]=	32'd0;
	for (i=3; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	
	cpu.ID.REG[0] = 32'd0;//r0
	cpu.ID.REG[1] = 32'd0;//x
	cpu.ID.REG[2] = 32'd0;//a
	cpu.ID.REG[3] = 32'd0;//b
	cpu.ID.REG[4] = 32'd2;//2
	cpu.ID.REG[5] = 32'd0;//t2
	cpu.ID.REG[6] = 32'd1;//1
	cpu.ID.REG[7] = 32'd0;//t3
	cpu.ID.REG[8] = 32'd0;//t4
	cpu.ID.REG[9] = 32'd0;//t7
	cpu.ID.REG[10] = 32'd0;//t8
	cpu.ID.REG[11] = 32'd3;//3
	cpu.ID.REG[12] = 32'd5;//5
	for (i=13; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	//if (cycles == `INSTRUCTION_NUMBERS) $finish; // Finish when excute the 24-th instruction (End label).
	if (cycles == `INSTRUCTION_NUMBERS) $finish; 
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

