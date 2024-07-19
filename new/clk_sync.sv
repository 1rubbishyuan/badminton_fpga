// ������ͬ��ʱ����ģ��

module clk_sync(
    input wire clk_init,
    input wire rst,
    input wire clk_need,
    input wire rxd_init, // ��ʼ����
    output reg [1:0] rxd_sync // ͬ������
);

always_ff @(posedge clk_init) begin
	if (rst) begin
		rxd_sync <= 2'b11;
	end 
	else if(clk_need) begin
		rxd_sync <= {rxd_sync[0], rxd_init}; // ��������ͬ��
	end
end

endmodule