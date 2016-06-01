module sequence_b(
	result,
	register,
	clk,
	reset,
	data
);

input clk, reset, data;
output result;
output [5:0] register;
reg [5:0] register;

initial register <= 0;

always @(posedge clk or negedge reset) begin
	if(~reset) register <=0;
	else begin
		register = register << 1;
		if(data==1) register <= register | 6'b000001;
		//register <= {register[4:0], data}
	end
end

assign result = (register==6'b101011) ? 1'b1 : 1'b0;

endmodule
