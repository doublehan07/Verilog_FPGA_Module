/*
	Design an asynchronous reset control - 4 bits synchronous up counter
*/
module counter_4sd(
	cnt,
	clk,
	reset
);

input clk, reset;
output [6:0] cnt;
reg [3:0] temp;

initial temp = 0;

always @ (posedge clk or negedge reset)
begin
	if(!reset) temp = 0;
	else
	begin
		if(temp==4'b0000) temp <= 4'b1111;
		else temp = temp - 4'b0001;
	end
end

assign	cnt=(temp==4'b0)?7'b1000000:
             (temp==4'b0001)?7'b1111001:
             (temp==4'b0010)?7'b0100100:
             (temp==4'b0011)?7'b0110000:
             (temp==4'b0100)?7'b0011001:
             (temp==4'b0101)?7'b0010010:
             (temp==4'b0110)?7'b0000010:
             (temp==4'b0111)?7'b1111000:
             (temp==4'b1000)?7'b0000000:
             (temp==4'b1001)?7'b0010000:
			 (temp==4'b1010)?7'b0001000:
			 (temp==4'b1011)?7'b0000011:
			 (temp==4'b1100)?7'b1000110:
			 (temp==4'b1101)?7'b0100001:
			 (temp==4'b1110)?7'b0000110:
			 (temp==4'b1111)?7'b0001110:7'b0;

endmodule
