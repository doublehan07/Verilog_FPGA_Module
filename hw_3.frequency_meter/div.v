module div(
	sigin, SW2,
	sigdin
);

input sigin, SW2;
output sigdin;

/*
reg cnt, sigdin; 
initial begin
	cnt <= 0;
	sigdin <= 0;
end

always @ (posedge sigin) begin
	if(SW2) begin
		cnt = cnt + 1;
		if(cnt==10) sigdin = 1;
		else if(cnt==20) begin
			sigdin = 0;
			cnt = 0;
		end
	end
	else assign sigdin = sigin;
end
*/

reg [3:0] state;
initial state <= 4'b0;

always @ (posedge sigin) begin
	state <= state + 4'b1;
	if(state==4'd9) state <= 4'b0;
end

assign sigdin=(SW2) ? ((state<4'd5) ? 1'b0 : 1'b1) : sigin;

endmodule
