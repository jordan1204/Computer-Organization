`timescale 1ns / 1ps


module top(
    input clk, 
	input rst,
	input[31:0] result1,
	input[31:0] result2,
	
    output a1,
    output b1,
    output c1,
    output d1,
    output e1,
    output f1,
    output g1,
    //output dp,
    output d01,
    output d11,
    output d21,
    output d31,
    output d41,
    output d51,
    output d61,
    output d71 
    );
//reg [5:0] first_number,second_number;
reg [20:0] counter;
reg [2:0] state;
reg [6:0] seg_number,seg_data;
reg [12:0] answer_number1, answer_number2;
reg [7:0] scan;


//wtite down your code here
always@(posedge clk)begin
	if(rst) begin
		answer_number1 <= 13'd0;
		answer_number2 <= 13'd0;
	end
	//second_number <= {sw5,sw4,sw3,sw2,sw1,sw0};
	//first_number <= {sw11,sw10,sw9,sw8,sw7,sw6};
	else begin
		  answer_number1 <= result1[12:0];
		  answer_number2 <= result2[12:0];
	end
end

//8??(d0~d7)7-segment(a~g)??? dp???k?U????.
assign {d71,d61,d51,d41,d31,d21,d11,d01} = scan; //?G???@??LED
//assign dp = ((state==1) || (state==3)) ? 0 : 1;  //1,3 light_on
always@(posedge clk) begin
  counter <=(counter<=100000) ? (counter +1) : 0;
  state <= (counter==100000) ? (state + 1) : state;

	case(state)
		0:begin
			//seg_number <= first_number/10;//6??switch???h??63,63/10=6,???b????
			seg_number <= answer_number1/1000;
			scan <= 8'b0111_1111;
		end
		1:begin
			//seg_number <= first_number%10;//63%10=3,???b?k??
			seg_number <= (answer_number1/100)%10;
			scan <= 8'b1011_1111;
		end
		2:begin
			//seg_number <= second_number/10;
			seg_number <= (answer_number1/10)%10;
			scan <= 8'b1101_1111;
		end
		3:begin
			//seg_number <= second_number%10;
			seg_number <= answer_number1%10;
			scan <= 8'b1110_1111;
		end
		4:begin
			//seg_number <= answer_number/1000;//63*63=3969,3969/1000=3
			seg_number <= answer_number2/1000;
			scan <= 8'b1111_0111;
		end
		5:begin
			//seg_number <= (answer_number%1000)/100;//3969%1000=969,969/1000=9
			seg_number <= (answer_number2/100)%10;
			scan <= 8'b1111_1011;
		end
		6:begin
			//seg_number <= (answer_number%100)/10;
			seg_number <= (answer_number2/10)%10;
			scan <= 8'b1111_1101;
		end
		7:begin
			//seg_number <= answer_number%10;
			seg_number <= answer_number2%10;
			scan <= 8'b1111_1110;
		end
		default: state <= state;
	endcase 
end  


assign {g1,f1,e1,d1,c1,b1,a1} = seg_data;
always@(posedge clk) begin  
  case(seg_number)
	16'd0:seg_data <= 7'b100_0000;
	16'd1:seg_data <= 7'b111_1001;
	16'd2:seg_data <= 7'b010_0100;
	16'd3:seg_data <= 7'b011_0000;
	16'd4:seg_data <= 7'b001_1001;
	16'd5:seg_data <= 7'b001_0010;
	16'd6:seg_data <= 7'b000_0010;
	16'd7:seg_data <= 7'b101_1000;
	16'd8:seg_data <= 7'b000_0000;
	16'd9:seg_data <= 7'b001_0000;
	default: seg_number <= seg_number;
  endcase
end 
endmodule
