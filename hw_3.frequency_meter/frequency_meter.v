module frequency_meter(
	CLOCK_50, reset, testmode, SW2,
	led, hex3, hex2, hex1, hex0
);

input CLOCK_50, reset, SW2;
input [1:0] testmode;
output led;
output [6:0] hex3, hex2, hex1, hex0;

wire sigin, sigdin;
wire [15:0] cnt, out;
wire cnt_clean, cnt_en, lat_en;

control ctrl(
	CLOCK_50, reset,
	cnt_clean, cnt_en, lat_en
);

signalinput sig(
	CLOCK_50,
	reset,
	testmode,
	sigin
);

div divider(
	sigin, SW2,
	sigdin
);

counter cont(
	sigdin, reset, cnt_clean, cnt_en,
	cnt
);

mylatch lat(
	lat_en, cnt,
	out
);

display dis(
	cnt,
	SW2,
	led, hex3, hex2, hex1, hex0
);

endmodule
