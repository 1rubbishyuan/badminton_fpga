// �������źŹ���ë��ģ��
// ��ֹ����

module data_filter(
    input wire clk,
    input wire rst,
    input wire oversampling_tick,
    input wire [1:0] rxd_sync,
    output reg rxd_bit
);

reg [1:0] filter_cnt = 2'b11; // ����������ֵ��������������ȼ���Ϊ�Ƕ���

always_ff @(posedge clk) begin
	if (rst) begin
		filter_cnt <= 2'b11;
		rxd_bit <= 1'b1;
	end
	else if(oversampling_tick) begin
		if(rxd_sync[1] == 1'b1 && filter_cnt != 2'b11) begin
			filter_cnt <= filter_cnt + 1'd1;
		end
		else if(rxd_sync[1] == 1'b0 && filter_cnt != 2'b00) begin
			filter_cnt <= filter_cnt - 1'd1;
		end
		if(filter_cnt == 2'b11) begin
			rxd_bit <= 1'b1;
		end
		else if(filter_cnt == 2'b00) begin
			rxd_bit <= 1'b0;
		end
	end
end

endmodule