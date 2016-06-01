module div_50m(
	clk,
	clk_div
);

input clk;
output clk_div;

reg [31:0] state;
initial state <= 32'b0;

always @ (posedge clk) begin
	state <= state + 32'b1;
	if(state==32'd49999999) state <= 32'b0;		
end

assign clk_div = (state<32'd25000000) ? 1'b1 : 1'b0;

endmodule
