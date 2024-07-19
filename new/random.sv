`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/06 17:18:21
// Design Name: 
// Module Name: random
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module random (
    input logic clk,
    input logic reset,
    output logic [2:0] random_numbers[20:0]
);
    logic [2:0] lfsr_reg;
    logic feedback;
    
    parameter bling_count = 32'd0;
    reg [31:0] bling_record;
    // LFSR�߼�
    always_ff @(posedge clk) begin
        if (reset||lfsr_reg==0) begin
            lfsr_reg <= 3'b001; // ��ʼ��ֵ������Ϊ0��
            bling_record<=0;
        end else begin
            bling_record<=bling_record+1;
            if(bling_record>=bling_count)begin
                bling_record<=0;
                feedback = lfsr_reg[2] ^ lfsr_reg[1]; // ѡ���ʵ��ķ�������ʽ
                lfsr_reg <= {lfsr_reg[1:0], feedback};
            end
        end
    end

    // ����21�������
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 21; i++) begin
                random_numbers[i] <= 3'b000; // �������������
            end
        end else begin
            if(bling_record>=bling_count)begin
                for (int i = 20; i > 0; i--) begin
                    random_numbers[i] <= random_numbers[i-1]; // ������λ
                end
                random_numbers[0] <= lfsr_reg; // ����ǰLFSRֵ��������ĵ�һ��λ��
            end
        end
    end

endmodule



