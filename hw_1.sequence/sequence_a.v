module sequence_a(
	ledout,
	state,
	clk,
	reset,
	data
);

input clk, reset, data;
output [0:0] ledout;
output [2:0] state;
reg [0:0] input_data;
reg [2:0] current_state, next_state;


initial begin 
	input_data <= 1'b0;
	current_state <= 3'b0;
end

always @(posedge clk or negedge reset) begin
	if(~reset) begin
		input_data <= 1'b0;
		current_state = 3'b0;
	end
	else begin
		input_data <= data;
		current_state <= next_state;
	end
end

always @(*) begin
/*
	case(current_state)
	3'b000: begin
			if(input_data==1) next_state <= 3'b001;
			else next_data <= 3'b000;
			end
*/
	if(input_data==1) begin
		if(current_state==3'b0
		 ||current_state==3'b010
		 ||current_state==3'b100
		 ||current_state==3'b101)
			next_state <= current_state + 3'b001;
		else if(current_state==3'b001
			  ||current_state==3'b011)
			next_state <= 3'b001;
		else
			next_state <= 3'b0;
	end
	else begin
		if(current_state==3'b001
		 ||current_state==3'b011)
			next_state <= current_state + 3'b001;
		else if(current_state==3'b110)
			next_state <= 3'b010;
		else if(current_state==3'b101)
			next_state <= 3'b100;
		else
			next_state <= 3'b0;
	end
end

assign ledout = (next_state==3'b110)? 1'b1 : 1'b0;
assign state = next_state + 3'b001;

endmodule
