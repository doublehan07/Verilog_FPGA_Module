module display(
	out, 
	SW2, 
	led, hex3, hex2, hex1, hex0
);

input SW2;
input [15:0] out;
output [0:0] led;
output [6:0] hex3, hex2, hex1, hex0;

/* For testing */
//reg [15:0] out;
//always @ (*) begin
//	out[15:12] = 4'd8;
//	out[11:8] = 4'd9;
//	out[7:4] = 4'd6;
//	out[3:0] = 4'd7;
//end

assign led = SW2;
assign hex3 = (out[15:12]==4'd0) ? 7'b1000000 :
			  (out[15:12]==4'd1) ? 7'b1111001 :
			  (out[15:12]==4'd2) ? 7'b0100100 :
			  (out[15:12]==4'd3) ? 7'b0110000 :
			  (out[15:12]==4'd4) ? 7'b0011001 :
			  (out[15:12]==4'd5) ? 7'b0010010 :
			  (out[15:12]==4'd6) ? 7'b0000010 :
			  (out[15:12]==4'd7) ? 7'b1111000 :
			  (out[15:12]==4'd8) ? 7'b0000000 : 7'b0010000;

assign hex2 = (out[11:8]==4'd0) ? 7'b1000000 :
			  (out[11:8]==4'd1) ? 7'b1111001 :
			  (out[11:8]==4'd2) ? 7'b0100100 :
			  (out[11:8]==4'd3) ? 7'b0110000 :
			  (out[11:8]==4'd4) ? 7'b0011001 :
			  (out[11:8]==4'd5) ? 7'b0010010 :
			  (out[11:8]==4'd6) ? 7'b0000010 :
			  (out[11:8]==4'd7) ? 7'b1111000 :
			  (out[11:8]==4'd8) ? 7'b0000000 : 7'b0010000;

assign hex1 = (out[7:4]==4'd0) ? 7'b1000000 :
			  (out[7:4]==4'd1) ? 7'b1111001 :
			  (out[7:4]==4'd2) ? 7'b0100100 :
			  (out[7:4]==4'd3) ? 7'b0110000 :
			  (out[7:4]==4'd4) ? 7'b0011001 :
			  (out[7:4]==4'd5) ? 7'b0010010 :
			  (out[7:4]==4'd6) ? 7'b0000010 :
			  (out[7:4]==4'd7) ? 7'b1111000 :
			  (out[7:4]==4'd8) ? 7'b0000000 : 7'b0010000;

assign hex0 = (out[3:0]==4'd0) ? 7'b1000000 :
			  (out[3:0]==4'd1) ? 7'b1111001 :
			  (out[3:0]==4'd2) ? 7'b0100100 :
			  (out[3:0]==4'd3) ? 7'b0110000 :
			  (out[3:0]==4'd4) ? 7'b0011001 :
			  (out[3:0]==4'd5) ? 7'b0010010 :
			  (out[3:0]==4'd6) ? 7'b0000010 :
			  (out[3:0]==4'd7) ? 7'b1111000 :
			  (out[3:0]==4'd8) ? 7'b0000000 : 7'b0010000;
			  
endmodule
