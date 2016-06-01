/*
	Design an asynchronous reset controling 4 bits asynchronous up counter.
*/

module counter_4a(
	cnt,
	clk,
	reset
);

input clk, reset;
output [6:0] cnt;
reg [0:0] QD, QC, QB, QA, tempa, tempb, tempc;
reg [3:0] temp;

/*
initial begin
	temp <= 0;
	QA <= 1'b0;
	QB <= 1'b0;
	QC <= 1'b0;
	QD <= 1'b0;
	tempa <= 1'b0;
	tempb <= 1'b0;
	tempc <= 1'b0;
end

always @(negedge reset or posedge clk) begin
	if(!reset) begin
		temp <= 0;
		QA <= 1'b0;
		QB <= 1'b0;
		QC <= 1'b0;
		QD <= 1'b0;
		tempa <= 1'b0;
		tempb <= 1'b0;
		tempc <= 1'b0;
	end
	else begin
		tempa = QA;
		QA = ~QA;
		if(tempa == 1'b1 && QA == 0) begin
			tempb = QB;
			QB = ~QB;
			if(tempb == 1 && QB == 0) begin
				tempc = QC;
				QC = ~QC;
				if(tempc == 1 && QC == 0) QD = ~QD;
			end
		end
		temp <= {QD, QC, QB, QA};
	end
end
*/
initial temp <= 0;

always @(negedge clk or negedge reset) begin
	if(~reset) temp <= 0;
	else begin
		QA <= ~QA;
		temp <= {QD, QC, QB, QA};
	end
end
always @(negedge QA) QB <= ~QB;
always @(negedge QB) QC <= ~QC;
always @(negedge QC) QD <= ~QD;

assign	cnt = (temp==4'h0)?7'b1000000:
              (temp==4'h1)?7'b1111001:
              (temp==4'h2)?7'b0100100:
              (temp==4'h3)?7'b0110000:
              (temp==4'h4)?7'b0011001:
              (temp==4'h5)?7'b0010010:
              (temp==4'h6)?7'b0000010:
              (temp==4'h7)?7'b1111000:
              (temp==4'h8)?7'b0000000:
              (temp==4'h9)?7'b0010000:
			  (temp==4'hA)?7'b0001000:
			  (temp==4'hB)?7'b0000011:
			  (temp==4'hC)?7'b1000110:
			  (temp==4'hD)?7'b0100001:
			  (temp==4'hE)?7'b0000110:
			  (temp==4'hF)?7'b0001110:7'b0;

endmodule
