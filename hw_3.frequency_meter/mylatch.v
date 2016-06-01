module mylatch(
	lat_en, cnt, 
	out
);

input lat_en;
input [15:0] cnt;
output [15:0] out;

reg [15:0] save;

initial save <= 16'b0;

always @ (posedge lat_en) save = cnt;

assign out = (lat_en) ? save : cnt;

endmodule
