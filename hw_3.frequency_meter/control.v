module control(
	clk, reset, 
	cnt_clean, cnt_en, lat_en
);

input clk, reset;
output cnt_clean, cnt_en, lat_en;

wire clk_cont;

div_50m sigcon(
	clk,
	clk_cont
);

reg [2:0] state;
initial state <= 3'b0;
always @ (posedge clk_cont or negedge reset) begin
	if(~reset) state <= 3'b0;
	else begin
		state <= state + 3'b1;
		if(state==3'd6) state <= 3'd2;
	end
end

assign cnt_en = (state<3'd2) ? 1'b1 : 1'b0;
assign cnt_clean = (state==3'd0) ? 1'b0 : 1'b1;
assign lat_en = ~cnt_en;

endmodule
