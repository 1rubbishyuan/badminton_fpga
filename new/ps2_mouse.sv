`timescale 1ns / 1ps
module ps2_mouse(
    input wire clock,
    input wire reset, 

    input wire ps2_clock_i,
    output wire ps2_clock_o,
    output wire ps2_clock_t,

    input wire ps2_data_i,
    output wire ps2_data_o,
    output wire ps2_data_t,

    // x, y axis
    output wire [11:0] mouse_x,
    output wire [11:0] mouse_y,

    // middle, right, left, buttons
    output wire [2:0] btn_click);

    // send command
    reg [7:0] command;
    reg command_valid;
    wire command_ready;

    // recv data
    reg data_ready;
    wire [7:0] data;
    wire data_valid;

    reg [7:0] packet_b1;
    reg [7:0] packet_b2;
    reg [7:0] packet_b3;

    wire [11:0] diff_x;
    wire [11:0] diff_y;
    assign diff_x = {{4{packet_b1[4]}}, packet_b2};
    assign diff_y = {{4{packet_b1[5]}}, packet_b3};

    reg [11:0] mouse_x_reg;
    reg [11:0] mouse_y_reg;
    reg [2:0] btn_click_reg;

    localparam STATE_INIT = 3'd0;
    localparam STATE_SEND_F4 = 3'd1;
    localparam STATE_WAIT_ACK = 3'd2;
    localparam STATE_READ_B1 = 3'd3;
    localparam STATE_READ_B2 = 3'd4;
    localparam STATE_READ_B3 = 3'd5;
    localparam STATE_READ_DONE = 3'd6;

    reg [2:0] state_reg;

    // PS/2 controller
    PS2Controller u_ps2 (
        .clock(clock),
        .reset(reset),

        .io_req_bits(command),
        .io_req_valid(command_valid),
        .io_req_ready(command_ready),

        .io_resp_bits(data),
        .io_resp_valid(data_valid),
        .io_resp_ready(data_ready),

        .io_ps2_clock_i(ps2_clock_i),
        .io_ps2_clock_o(ps2_clock_o),
        .io_ps2_clock_t(ps2_clock_t),
        .io_ps2_data_i(ps2_data_i),
        .io_ps2_data_o(ps2_data_o),
        .io_ps2_data_t(ps2_data_t)
    );

    initial begin
        mouse_x_reg = 12'd1024;
        mouse_y_reg = 12'd1024;
    end

    always @(posedge clock) begin
        if (reset) begin
            command <= 8'b0;
            command_valid <= 1'b0;
            data_ready <= 1'b0;
            packet_b1 <= 8'b0;
            packet_b2 <= 8'b0;
            packet_b3 <= 8'b0;
            mouse_x_reg <= 12'd1024;
            mouse_y_reg <= 12'd1024;
            btn_click_reg <= 3'd0;
            state_reg <= STATE_INIT;
        end else begin
            casez(state_reg)
                STATE_INIT: begin
                    state_reg <= STATE_SEND_F4;
                    command_valid <= 1'b1;
                    command <= 8'hF4;
                end
                STATE_SEND_F4: begin
                    // F4: Enable Data Reporting
                    if (command_ready) begin
                        command_valid <= 1'b0;
                        data_ready <= 1'b1;
                        state_reg <= STATE_WAIT_ACK;
                    end
                end
                STATE_WAIT_ACK: begin
                    if (data_valid) begin
                        if (data == 8'hFA) begin
                            data_ready <= 1'b1;
                            state_reg <= STATE_READ_B1;
                        end else begin
                            // retry
                            data_ready <= 1'b0;
                            state_reg <= STATE_INIT;
                        end
                    end
                end
                STATE_READ_B1: begin
                    if (data_valid) begin
                        packet_b1 <= data;
                        state_reg <= STATE_READ_B2;
                    end
                end
                STATE_READ_B2: begin
                    if (data_valid) begin
                        packet_b2 <= data;
                        state_reg <= STATE_READ_B3;
                    end
                end
                STATE_READ_B3: begin
                    if (data_valid) begin
                        packet_b3 <= data;
                        data_ready <= 1'b0;
                        state_reg <= STATE_READ_DONE;
                    end
                end
                STATE_READ_DONE: begin
                    btn_click_reg <= packet_b1[2:0];
                    mouse_x_reg <= mouse_x_reg + diff_x;
                    mouse_y_reg <= mouse_y_reg + diff_y;
                    data_ready <= 1'b1;
                    state_reg <= STATE_READ_B1;
                end
                default: begin
                    state_reg <= STATE_INIT;
                end
            endcase
        end
    end

    assign mouse_x = mouse_x_reg;
    assign mouse_y = mouse_y_reg;
    assign btn_click = btn_click_reg;
endmodule

