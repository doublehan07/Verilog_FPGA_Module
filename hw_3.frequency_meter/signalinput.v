/*
sysclk : 	50MHzϵͳʱ��
resetb : 	�͵�ƽ��Ч�첽��λ�ź�
testmode :	00,01,10,11�ֱ���� 3125,6250,50,12500Hz,ʹ��SW1~SW0������
sigin :		����ʱ�����,Ƶ����testmodeѡ��
*/

module signalinput(
	sysclk,
	resetb,
	testmode,
	sigin
);

input sysclk;
input resetb;
input [1:0] testmode;
output sigin;
reg [20:0] divide;

always @(*) begin
	case(testmode)
	2'b00 : divide=21'd16000; //3125Hz
	2'b01 : divide=21'd8000; //6250Hz
	2'b10 : divide=21'd1000000; //50Hz
	2'b11 : divide=21'd4000; //12500Hz
	endcase
end

reg sigin;
reg [20:0] state;
always @(posedge sysclk or negedge resetb) begin
	if(~resetb) begin
		sigin <= 1'b0;
		state <= 21'd0;
	end
	else begin
		if(state==divide)
			state <= 21'd0;
		else
			state <= state + 21'd2;
		sigin <= (state==21'd0) ? ~sigin : sigin;
	end
end
endmodule
