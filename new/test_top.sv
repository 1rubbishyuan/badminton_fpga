////`timescale 1ns / 1ps
//package main_package;

//    typedef enum {
//        PlayerA,
//        PlayerB,
//        Zero,
//        One,
//        Two,
//        Three,
//        Four,
//        Five,
//        Six,
//        Seven,
//        Eight,
//        Nine,
//        Net,
//        PlayerA_move1,
//        PlayerA_move2,
//        PlayerA_move3,
//        PlayerA_move4,
//        PlayerB_move1,
//        PlayerB_move2,
//        PlayerB_move3,
//        PlayerB_move4,
//        Ball_0,
//        Ball_2,
//        Ball_4,
//        Ball_6,
//        Ball_8,
//        Ball_10,
//        Ball_12,
//        Ball_14,
//        Ball_16,
//        Ball_18,
//        Ball_20,
//        Ball_22,
//        Ball_24,
//        Ball_26,
//        Ball_28,
//        Ball_30,
//        Ball_32,
//        Ball_34,
//        Pat_0,
//        Pat_2,
//        Pat_4,
//        Pat_6,
//        Pat_8,
//        Pat_10,
//        Pat_12,
//        Pat_14,
//        Pat_16,
//        Pat_18,
//        Pat_20,
//        Pat_22,
//        Pat_24,
//        Pat_26,
//        Pat_28,
//        Pat_30,
//        Pat_32,
//        Pat_34,
//        PlayerA_win,
//        PlayerB_win
//    } sprites;
    
////    typedef struct packed{
////        reg [11:0] x;   // ֻ��x��y����Ҫ���߼������??????(��ʵ�ϣ�������ë���Ƿ��漰���Ƕȵ�����)
////        reg [11:0] y;
////        reg [11:0] width; // �����ĸ������ǲ�����
////        reg [11:0] height;
////        reg [11:0] rom_x;
////        reg [11:0] rom_y;
////    } element_pos_size_rom;
    
//    parameter Sprite_types = 59 ;
//    parameter Rend_number = 11;
//    parameter int enum_to_index[Sprite_types]='{
//        PlayerA:0,
//        PlayerB:1,
//        Zero:2,
//        One:3,
//        Two:4,
//        Three:5,
//        Four:6,
//        Five:7,
//        Six:8,
//        Seven:9,
//        Eight:10,
//        Nine:11,
//        Net:12,
//        PlayerA_move1:13,
//        PlayerA_move2:14,
//        PlayerA_move3:15,
//        PlayerA_move4:16,
//        PlayerB_move1:17,
//        PlayerB_move2:18,
//        PlayerB_move3:19,
//        PlayerB_move4:20,
//        Ball_0:21,
//        Ball_2:22,
//        Ball_4:23,
//        Ball_6:24,
//        Ball_8:25,
//        Ball_10:26,
//        Ball_12:27,
//        Ball_14:28,
//        Ball_16:29,
//        Ball_18:30,
//        Ball_20:31,
//        Ball_22:32,
//        Ball_24:33,
//        Ball_26:34,
//        Ball_28:35,
//        Ball_30:36,
//        Ball_32:37,
//        Ball_34:38,
//        Pat_0:39,
//        Pat_2:40,
//        Pat_4:41,
//        Pat_6:42,
//        Pat_8:43,
//        Pat_10:44,
//        Pat_12:45,
//        Pat_14:46,
//        Pat_16:47,
//        Pat_18:48,
//        Pat_20:49,
//        Pat_22:50,
//        Pat_24:51,
//        Pat_26:52,
//        Pat_28:53,
//        Pat_30:54,
//        Pat_32:55,
//        Pat_34:56,
//        PlayerA_win:57,
//        PlayerB_win:58
//    };
//    parameter int pos_in_rom[Sprite_types][2] = '{
//        PlayerA:'{5,50},
//        PlayerB:'{5,160},
//        Zero:'{0,5},
//        One:'{20,5},
//        Two:'{40,5},
//        Three:'{60,5},
//        Four:'{80,5},
//        Five:'{100,5},
//        Six:'{120,5},
//        Seven:'{140,5},
//        Eight:'{160,5},
//        Nine:'{180,5},
//        Net:'{335,70},
//        PlayerA_move1:'{70,50},
//        PlayerA_move2:'{135,50},
//        PlayerA_move3:'{200,50},
//        PlayerA_move4:'{265,50},
//        PlayerB_move1:'{72,160},
//        PlayerB_move2:'{137,160},
//        PlayerB_move3:'{202,160},
//        PlayerB_move4:'{267,160},
//        Ball_0:'{5,290},
//        Ball_2:'{35,291},
//        Ball_4:'{65,290},
//        Ball_6:'{95,290},
//        Ball_8:'{125,290},
//        Ball_10:'{155,290},
//        Ball_12:'{185,290},
//        Ball_14:'{215,290},
//        Ball_16:'{245,290},
//        Ball_18:'{5,320},
//        Ball_20:'{35,320},
//        Ball_22:'{65,320},
//        Ball_24:'{95,320},
//        Ball_26:'{125,320},
//        Ball_28:'{155,320},
//        Ball_30:'{185,320},
//        Ball_32:'{215,320},
//        Ball_34:'{245,320},
//        Pat_0:'{5,350},
//        Pat_2:'{24,350},
//        Pat_4:'{60,350},
//        Pat_6:'{120,345},
//        Pat_8:'{120,400},
//        Pat_10:'{210,345},
//        Pat_12:'{210,375},
//        Pat_14:'{300,290},
//        Pat_16:'{5,445},
//        Pat_18:'{45,440},
//        Pat_20:'{65,445},
//        Pat_22:'{105,430},
//        Pat_24:'{295,380},
//        Pat_26:'{105,505},
//        Pat_28:'{205,429},
//        Pat_30:'{210,460},
//        Pat_32:'{300,440},
//        Pat_34:'{350,430},
//        PlayerA_win:{0,0},
//        PlayerB_win:{0,0}
//    };
    
//    parameter int sprite_size[Sprite_types][2]='{
//        PlayerA:'{52,100},
//        PlayerB:'{54,120},
//        Zero:'{17,27},
//        One:'{4,27},
//        Two:'{17,27},
//        Three:'{17,27},
//        Four:'{17,27},
//        Five:'{17,27},
//        Six:'{17,27},
//        Seven:'{18,27},
//        Eight:'{17,27},
//        Nine:'{17,27},
//        Net:'{33,165},
//        PlayerA_move1:'{58,100},
//        PlayerA_move2:'{38,100},
//        PlayerA_move3:'{42,100},
//        PlayerA_move4:'{46,100},
//        PlayerB_move1:'{52,120},
//        PlayerB_move2:'{52,120},
//        PlayerB_move3:'{52,120},
//        PlayerB_move4:'{52,120},
//        Ball_0:'{20,22},
//        Ball_2:'{20,19},
//        Ball_4:'{20,20},
//        Ball_6:'{20,22},
//        Ball_8:'{20,20},
//        Ball_10:'{20,20},
//        Ball_12:'{20,19},
//        Ball_14:'{20,22},
//        Ball_16:'{20,20},
//        Ball_18:'{20,20},
//        Ball_20:'{20,20},
//        Ball_22:'{20,20},
//        Ball_24:'{22,20},
//        Ball_26:'{22,20},
//        Ball_28:'{20,20},
//        Ball_30:'{24,20},
//        Ball_32:'{20,20},
//        Ball_34:'{20,20},
//        Pat_0:'{16,91},
//        Pat_2:'{37,86},
//        Pat_4:'{61,71},
//        Pat_6:'{79,49},
//        Pat_8:'{90,24},
//        Pat_10:'{90,25},
//        Pat_12:'{80,50},
//        Pat_14:'{61,71},
//        Pat_16:'{37,85},
//        Pat_18:'{16,91},
//        Pat_20:'{38,86},
//        Pat_22:'{61,72},
//        Pat_24:'{80,49},
//        Pat_26:'{89,23},
//        Pat_28:'{90,25},
//        Pat_30:'{80,50},
//        Pat_32:'{60,72},
//        Pat_34:'{36,86},
//        PlayerA_win:{30,30},
//        PlayerB_win:{40,40}
//    };
//endpackage
//module test_top(
//    // ʱ��
//    input  wire clk_100m,           // 100M ����ʱ��

////    // ����
////    input  wire btn_clk,            // ���΢�����أ�CLK�����Ƽ���Ϊ�ֶ�ʱ�ӣ���������·������ʱΪ 1
////    input  wire btn_rst,            // �Ҳ�΢�����أ�RST�����Ƽ���Ϊ�ֶ���λ����������·������ʱΪ 1
////    input  wire [3:0]  btn_push,    // �ĸ���ť���أ�KEY1-4��������ʱΪ 1
////    input  wire [15:0] dip_sw,      // 16 λ���뿪�أ����� ��ON�� ʱΪ 0

////    // 32 λ LED �ƣ����???? led_scan ģ��ʹ��
////    output wire [7:0] led_bit,      // 8 λ LED �ź�
////    output wire [3:0] led_com,      // LED ɨ���źţ�ÿһλ��Ӧ 8 λ�� LED �ź�

////    // ����ܣ���� dpy_scan ģ��ʹ��
////    output wire [7:0] dpy_digit,   // �߶�����ܱʶ��ź�????
////    output wire [7:0] dpy_segment, // �߶������λɨ���ź�????

////    // ������һЩ��ע�͵�������ӿ�????
////    // ��Ҫʹ�ã���Ҫ����ȥ�� io.xdc �ж�Ӧ�е�ע��

////    // PS/2 ����
////     input  wire        ps2_keyboard_clk,     // PS/2 ����ʱ���ź�
////     input  wire        ps2_keyboard_data,    // PS/2 ���������ź�

////    // PS/2 ���????
////     inout  wire       ps2_mouse_clk,     // PS/2 ʱ���ź�
////     inout  wire       ps2_mouse_data,    // PS/2 �����ź�
    
////     input  wire       wireless_tx,
    
////    // SD ����SPI ģʽ��
////    // output wire        sd_sclk,     // SPI ʱ��
////    // output wire        sd_mosi,     // �������????
////    // input  wire        sd_miso,     // ��������
////    // output wire        sd_cs,       // SPI Ƭѡ������Ч
////    // input  wire        sd_cd,       // �������⣬0 ��ʾ�п�����
////    // input  wire        sd_wp,       // д�������????0 ��ʾд����״̬

////    // RGMII ��̫���ӿ�
////    // output wire        rgmii_clk125,
////    // input  wire        rgmii_rx_clk,
////    // input  wire        rgmii_rx_ctl,
////    // input  wire [3: 0] rgmii_rx_data,
////    // output wire        rgmii_tx_clk,
////    // output wire        rgmii_tx_ctl,
////    // output wire [3: 0] rgmii_tx_data,

////    // 4MB SRAM �ڴ�
////    // inout  wire [31:0] base_ram_data,   // SRAM ����
////    // output wire [19:0] base_ram_addr,   // SRAM ��ַ
////    // output wire [3: 0] base_ram_be_n,   // SRAM �ֽ�ʹ�ܣ�����Ч�������ʹ���ֽ�ʹ�ܣ��뱣���?0
////    // output wire        base_ram_ce_n,   // SRAM Ƭѡ������Ч
////    // output wire        base_ram_oe_n,   // SRAM ��ʹ�ܣ�����Ч
////    // output wire        base_ram_we_n,   // SRAM дʹ�ܣ�����Ч

////    // HDMI ͼ�����????
////    output wire [2:0] hdmi_tmds_n,    // HDMI TMDS �����ź�
////    output wire [2:0] hdmi_tmds_p,    // HDMI TMDS �����ź�
////    output wire       hdmi_tmds_c_n,  // HDMI TMDS ʱ���ź�
////    output wire       hdmi_tmds_c_p   // HDMI TMDS ʱ���ź�
////    );
////    import main_package::element_pos_size_rom;
////    import main_package::Rend_number;
////    // ʹ�� 100MHz ʱ����Ϊ�����߼���ʱ��
////    wire clk_in = clk_100m;

////    // PLL ��Ƶ��ʾ�������������ͬƵ�ʵ�ʱ��????
////    wire clk_hdmi;
////    wire clk_locked;
////    ip_pll u_ip_pll(
////        .clk_in1  (clk_in    ),  // ���� 100MHz ʱ��
////        .reset    (btn_rst   ),  // ��λ�źţ�����Ч
////        .clk_out1 (clk_hdmi  ),  // 50MHz ����ʱ��
////        .locked   (clk_locked)   // �߱�ʾ 50MHz ʱ���Ѿ��ȶ����????
////    );

////    // �߶������ɨ�����?
////    reg [31:0] number;
////    dpy_scan  u_dpy_scan (
////        .clk     (clk_in      ),
////        .number  (number      ),
////        .dp      (8'b0        ),

////        .digit   (dpy_digit   ),
////        .segment (dpy_segment )
////    );
    
////    reg [3:0][5:0] input_signal;
////    reg [31:0] dpy_input_signal;
////    wire [7:0] scancode;

////    // �������봦��
////    wire scancode_valid;
////    ps2_keyboard u_ps2_keyboard (
////        .clock     (clk_in           ),
////        .reset     (btn_rst          ),
////        .ps2_clock (ps2_keyboard_clk ),
////        .ps2_data  (ps2_keyboard_data),
////        .scancode  (scancode         ),
////        .valid     (scancode_valid   )
////    );
    
////    wire [2:0] btn_click;
////    wire [11:0] mouse_x;
////    wire [11:0] mouse_y;

////    // ������봦��????

////    // ��̬��
////    wire ps2_mouse_clk_i;
////    wire ps2_mouse_clk_o;
////    wire ps2_mouse_clk_t;
////    assign ps2_mouse_clk = ps2_mouse_clk_t ? 1'bz : ps2_mouse_clk_o;
////    assign ps2_mouse_clk_i = ps2_mouse_clk;

////    wire ps2_mouse_data_i;
////    wire ps2_mouse_data_o;
////    wire ps2_mouse_data_t;
////    assign ps2_mouse_data = ps2_mouse_data_t ? 1'bz : ps2_mouse_data_o;
////    assign ps2_mouse_data_i = ps2_mouse_data;

////    // PS/2 IP ������ʱ���� 50MHz�����������???? VGA/HDMI ������ʱ��
////    ps2_mouse u_ps2_mouse (
////        .clock(clk_hdmi),
////        .reset(!clk_locked),

////        .ps2_clock_i(ps2_mouse_clk_i),
////        .ps2_clock_o(ps2_mouse_clk_o),
////        .ps2_clock_t(ps2_mouse_clk_t),
////        .ps2_data_i(ps2_mouse_data_i),
////        .ps2_data_o(ps2_mouse_data_o),
////        .ps2_data_t(ps2_mouse_data_t),

////        .mouse_x(mouse_x),
////        .mouse_y(mouse_y),
////        .btn_click(btn_click)
////    );

////    // ���???? �������봦��
////    ps2_decoder u_ps2_decoder (
////        .clk(clk_in),
////        .rst(btn_rst),
        
////        .mouse_click(btn_click),
        
////        .scancode_valid(scancode_valid),
////        .in_number(number),
////        .scancode(scancode),
////        .out_number(number),
        
////        .api(input_signal)
////    );

////    // ������ ���봦��
////    wire [7:0] raw;
////    wire [15:0] angle;
////    wire [15:0] angular_v;
    
////    reset_filter resetter_uart (
////        .clk(clk_uart),
////        .rst_in(btn_rst),
////        .rst_out(reset_uart)
////    );

////    sensor_decoder sensor_decoder_inst (
////      .clk(clk_uart),
////      .rst(reset_uart),
////      .rxd(wireless_tx),
////      .raw,
////      .angle(angle),
////      .angular_v(angular_v)
////    );

////    // ������������������������?
//////    reg [31:0] counter;
//////    always @(posedge clk_in) begin
//////        if (btn_rst) begin
//////            counter <= 32'b0;
//////            number <= 32'b0;
//////        end else begin
//////            counter <= counter + 32'b1;
//////            if (counter == 32'd25_000_000) begin
//////                counter <= 32'b0;
//////                number <= number + 32'b1;
//////            end
//////        end
//////    end

////    // LED ��ʾ
////    wire [31:0] leds;
////    assign leds[15:0] = number[15:0];
////    assign leds[31:16] = ~(dip_sw) ^ btn_push;
////    led_scan u_led_scan (
////        .clk     (clk_in      ),
////        .leds    (leds        ),

////        .led_bit (led_bit     ),
////        .led_com (led_com     )
////    );

////    // ͼ�������ʾ���ֱ���???? 800x600@72Hz������ʱ��Ϊ 50MHz����ʾ����ɫ����
////    wire [11:0] hdata;  // ��ǰ������
////    wire [11:0] vdata;  // ��ǰ������
////    wire [7:0] video_red; // ��ɫ����
////    wire [7:0] video_green; // ��ɫ����
////    wire [7:0] video_blue; // ��ɫ����
////    wire video_clk; // ����ʱ��
////    wire video_hsync;
////    wire video_vsync;
//////    wire [15:0] pixel_data;
////    // ���ɲ������ݣ��ֱ�ȡ�����λ���? RGB ֵ
////    // ���棺��ͼ�����ɷ�ʽ������ʾ������ʹ�ú����������������߼�����
////    assign video_red = vdata < 200 ? hdata[8:1] : 8'b0;
////    assign video_green = vdata >= 200 && vdata < 400 ? hdata[8:1] : 8'b0;
////    assign video_blue = vdata >= 400 ? hdata[8:1] : 8'b0;
 
////    assign video_clk = clk_hdmi;
////    reg [11:0] pixel_data;
    
//    video #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) u_video800x600at72 (
//        .clk(video_clk), 
//        .rst_n(btn_rst),
//        .hdata(hdata), //������
//        .vdata(vdata), //������
//        .hsync(video_hsync),
//        .vsync(video_vsync)
////        .data_enable(video_de)
//    );

////    wire clk_33;
////    wire clk_33_locked;
////    pll_33(
////        .clk_in1(clk_in),
////        .reset(btn_rst),
////        .clk_out1(clk_33),
////        .locked(clk_33_locked)
////    );
    
////    reg [11:0] pos_x;
////    reg [11:0] pos_y;
////    wire [11:0] write_x,write_y;
////    wire finished;
////    element_pos_size_rom elements_all[Rend_number];
////    main_logic main(
////        .clk_33(clk_33),
////        .rst_n(btn_rst),
////        .write_finished(finished),
////        .input_signal(input_signal),
////        .elements_all(elements_all)
//////        .output_player_x(pos_x),
//////        .output_player_y(pos_y)
////    );
    
////    all_painter top_painter(
////        .clk(clk_33),
////        .rst_n(btn_rst),
////        .elements_all(elements_all),
//////        .x_pixel(pos_x),
//////        .y_pixel(pos_y),
////        .pixel_data(pixel_data),
////        .write_x(write_x),
////        .write_y(write_y),
////        .finished(finished)
////    );
//////    element_painter top_painter (
//////        .clk(clk_33),
//////        .rst_n(btn_rst),
//////        .ena(1'b1),
//////        .sprite_x(12'b0),
//////        .sprite_y(12'b0),
//////        .x_pixel(pos_x),
//////        .y_pixel(pos_y),
//////        .width(12'd96),
//////        .height(12'd94),
//////        .write_x(write_x),
//////        .write_y(write_y),
//////        .pixel_data(pixel_data),
//////        .write_finished(finished)
//////    );
////    //   background_painter b(
////    //       .clk(clk_33),
////    //       .rst_n(rst_n),
////    //       .pixel_data(pixel_data),
////    //       .write_x(write_x),
////    //       .write_y(write_y),
////    //       .finished(finished)
////    //   );
//////    reg [23:0]out;
//////    always_comb begin
//////        if (hdata==write_x&&vdata==write_y) out = {video_red,video_green,video_blue};
//////        else out = 24'b000000001111111100000000;
//////    end
////    wire ram_valid;
////    reg [11:0] mid_output_pixel;
////    reg [11:0] output_pixel;
////    reg output_valid;
////    ram_controllor ram(
////        .clk_rd(video_clk),
////        .clk_wr(clk_33),
////        .rst_n(btn_rst),
////        .input_pixel(pixel_data),
////        .write_x(write_x),
////        .write_y(write_y),
////        .read_x(hdata),
////        .read_y(vdata),
////        .write_finished(finished),
////        .output_pixel(mid_output_pixel),
////        .output_valid(output_valid)
////    );
////    assign ram_valid = (hdata>=40&&hdata<=760&&vdata>=30&&vdata<=670);
////    always_comb begin
////        if(ram_valid) output_pixel=mid_output_pixel;
////        else output_pixel=12'd000;
////    end

////    wire [23:0] output_pixel_888;
    
////    rgb444_to_rgb888 convert(
////        .rgb444(output_pixel),
////        .rgb888(output_pixel_888)
////    );
////    wire video_de;
////    assign video_de = ((hdata < 800) & (vdata < 600));
////    // �� RGB ת��Ϊ HDMI TMDS �źŲ����????
////    ip_rgb2dvi u_ip_rgb2dvi (
////        .PixelClk   (video_clk),
////        .vid_pVDE   (video_de),
////        .vid_pHSync (video_hsync),
////        .vid_pVSync (video_vsync),
//////        .vid_pData  ({video_red,video_green,video_blue}),
////        .vid_pData  (output_pixel_888),
//////        .vid_pData(output_pixel),
////        .aRst       (~clk_locked),

////        .TMDS_Clk_p  (hdmi_tmds_c_p),
////        .TMDS_Clk_n  (hdmi_tmds_c_n),
////        .TMDS_Data_p (hdmi_tmds_p),
////        .TMDS_Data_n (hdmi_tmds_n)
////    );

////endmodule
