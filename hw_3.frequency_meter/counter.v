/*
	dec counter
*/

module counter(
//	SW2,
	sigin, rst, cnt_clean, cnt_en, 
	cnt,
//	led, hex3, hex2, hex1, hex0
);

input sigin, rst, cnt_clean, cnt_en;
output [15:0] cnt;
reg [15:0] cnt;

//input SW2;
//output led;
//output [6:0] hex3, hex2, hex1, hex0;

always @ (negedge rst or negedge cnt_clean or posedge sigin) begin
	if(~rst) cnt <= 0;
	else if(~cnt_clean) cnt <= 0;
	else if(cnt_en) begin
		cnt[3:0] = cnt[3:0] + 4'd1;
		if(cnt[3:0]==10) begin
			cnt[3:0] = 0;
			cnt[7:4] = cnt[7:4] + 4'd1;
			if(cnt[7:4]==10) begin
				cnt[7:4] = 0;
				cnt[11:8] = cnt[11:8] + 4'd1;
				if(cnt[11:8]==10) begin
					cnt[11:8] = 0;
					cnt[15:12] = cnt[15:12] + 4'd1;
					if(cnt[15:12]==10) cnt[15:12] = 0;
				end
			end
		end
	end
end

//display dis_test(
//	cnt,
//	SW2,
//	led, hex3, hex2, hex1, hex0
//);

endmodule
