// ����������ģ��
// �ο����ϣ�https://wit-motion.yuque.com/wumwnr/ltst03/vl3tpy

module sensor_reader (
  input wire clk,
  input wire rst,
  input wire rxd, // ������Ϣ
  output reg[15:0] angular_v // ���ٶ�
);

  parameter HEADER = 8'h55;
  parameter DATA_LENGTH = 11;
  parameter ANGULAR_V = 8'h52;
  parameter TYPEB = 1;   // �����ֽ�
  parameter XDATALB = 2; // X���
  parameter XDATAHB = 3; // X���
  parameter YDATALB = 4; // Y���
  parameter YDATAHB = 5; // Y���
  parameter ZDATALB = 6; // Z���
  parameter ZDATAHB = 7; // Z���

  wire [7:0] data;
  wire next_byte;

  // ԭʼ��Ϣ����ģ��
  async_receiver async_receiver_inst (
    .clk(clk),
    .rst(rst),
    .rxd(rxd), 
    .rxd_data_ready(next_byte),
    .rxd_data(data)
  );

  reg [ 3:0] byte_index;  // index of the next byte to read
  reg [ 7:0] data_type;
  reg [ 7:0] checksum;
  reg [15:0] angular_v_tmp; // store data before checking checksum
  reg [15:0] angle_tmp;

  always_ff @(posedge clk) begin
    if(rst) begin
      byte_index <= 0;
      data_type <= 0;
      checksum <= 0;
      angle_tmp <= 0;
      angular_v_tmp <= 0;
      angular_v <= 0; 
    end
    else if(next_byte) begin
      if(byte_index == 0) begin // ͷ��
        if(data == HEADER) begin
            byte_index <= 1;
            checksum <= HEADER;
        end
        else begin
            byte_index <= 0;
            checksum <= 0;
        end
      end
      else if (byte_index < DATA_LENGTH - 1) begin // ���ݶ�
        byte_index <= byte_index + 1;
        checksum <= checksum + data;
        if(byte_index == TYPEB) begin
          data_type <= data;
        end
        else if (byte_index == ZDATALB) begin
        if(data_type == ANGULAR_V) begin
          angular_v_tmp[7:0] <= data;
        end
        end
        else if (byte_index == ZDATAHB) begin
          if(data_type == ANGULAR_V) begin
            angular_v_tmp[15:8] <= data;
          end
        end
      end
      else if (byte_index == DATA_LENGTH - 1) begin // �����
        if (checksum == data) begin
          if(data_type == ANGULAR_V) begin
            angular_v <= angular_v_tmp;
          end
        end
        byte_index <= 0;
        checksum <= 0;
      end
    end  
  end

endmodule
