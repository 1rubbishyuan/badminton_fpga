`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// RS-232 RX and TX module
// (c) fpga4fun.com & KNJN LLC - 2003 to 2016

// The RS-232 settings are fixed
// RX: 8-bit data, 1 stop, no-parity (the receiver can accept more stop bits of course)

////////////////////////////////////////////////////////

// �������źŵĽ��ղ�ͬ��ģ��
// �ο����ϣ�https://www.fpga4fun.com/SerialInterface.html

module async_receiver(
	input wire clk,
	input wire rst,
	input wire rxd,            // ���յ�����Ϣ
	output reg rxd_data_ready, // ͬ�������Ϣ�Ƿ�Ϸ�
	output reg [7:0] rxd_data  // ͬ�������Ϣ
);

parameter ClkFrequency = 25000000; // 25MHzʱ��
parameter Baud = 9600; // ������

parameter oversampling = 8;  // ����������
parameter oversampling_width = 3;  // ���������ʴ���

reg [3:0] rxd_state = 0;

// ���ȸ��ݲ�����������һ��������ʹ�õ�ʱ��
wire oversampling_tick;
BaudTickGen #(ClkFrequency, Baud, oversampling) tickgen(
	.clk(clk), 
	.enable(1'b1), 
	.tick(oversampling_tick)
);

// ������ͬ����ʱ����
reg [1:0] rxd_sync;
clk_sync clk_sync_inst(
	.clk_init(clk),
	.rst(rst),
	.clk_need(oversampling_tick),
	.rxd_init(rxd),
	.rxd_sync(rxd_sync)
);

// ��ë�̣���ֹ����
reg rxd_bit;
data_filter filter_inst(
	.clk(clk),
	.rst(rst),
	.oversampling_tick(oversampling_tick),
	.rxd_sync(rxd_sync),
	.rxd_bit(rxd_bit)
);

// ��������ʱ��
reg [oversampling_width - 1:0] oversampling_cnt = 0;
always_ff @(posedge clk) begin
	if(oversampling_tick) begin 
		oversampling_cnt <= (rxd_state == 0) ? 1'd0 : oversampling_cnt + 1'd1;
	end
end

wire sample_now = oversampling_tick && (oversampling_cnt == oversampling / 2 - 1);

// ����״̬��
always_ff @(posedge clk) begin
    case(rxd_state)
        4'b0000: if(~rxd_bit)  rxd_state <= 4'b0001;  // start bit found?
        4'b0001: if(sample_now) rxd_state <= 4'b1000;  // sync start bit to sample_now
        4'b1000: if(sample_now) rxd_state <= 4'b1001;  // bit 0
        4'b1001: if(sample_now) rxd_state <= 4'b1010;  // bit 1
        4'b1010: if(sample_now) rxd_state <= 4'b1011;  // bit 2
        4'b1011: if(sample_now) rxd_state <= 4'b1100;  // bit 3
        4'b1100: if(sample_now) rxd_state <= 4'b1101;  // bit 4
        4'b1101: if(sample_now) rxd_state <= 4'b1110;  // bit 5
        4'b1110: if(sample_now) rxd_state <= 4'b1111;  // bit 6
        4'b1111: if(sample_now) rxd_state <= 4'b0010;  // bit 7
        4'b0010: if(sample_now) rxd_state <= 4'b0000;  // stop bit
        default: rxd_state <= 4'b0000;
    endcase
end

// ȷ�������Ƿ���Ч���Ƿ񵽴�����ֹ״̬��
assign rxd_data_ready = (sample_now && rxd_state == 4'b0010 && rxd_bit);

// �ں��ʵ�ʱ���������ݶ���
always_ff @(posedge clk) begin
	if(sample_now && rxd_state[3]) begin
		rxd_data <= {rxd_bit, rxd_data[7:1]};
	end
end

endmodule