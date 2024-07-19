`timescale 1ns / 1ps
module ps2_keyboard (
    input wire clock,
    input wire reset,

    input wire ps2_clock,
    input wire ps2_data,

    output wire [7:0] scancode,
    output wire valid
);
    // capture ps2 clock and data
    reg clk1_reg;
    reg clk2_reg;
    reg data_reg;

    // current scan code
    reg [7:0] code_reg;

    // state machine
    reg [3:0] state_reg;
    localparam STATE_DELAY = 8'd0;
    localparam STATE_START = 8'd1;
    localparam STATE_D0 = 8'd2;
    localparam STATE_D1 = 8'd3;
    localparam STATE_D2 = 8'd4;
    localparam STATE_D3 = 8'd5;
    localparam STATE_D4 = 8'd6;
    localparam STATE_D5 = 8'd7;
    localparam STATE_D6 = 8'd8;
    localparam STATE_D7 = 8'd9;
    localparam STATE_PARITY = 8'd10;
    localparam STATE_STOP = 8'd11;
    localparam STATE_FINISH = 8'd12;

    // rise transition
    wire rise_comb;
    assign rise_comb = (!clk1_reg) & clk2_reg;

    // parity
    reg valid_reg;
    wire odd_comb;
    assign odd_comb = code_reg[0] ^ code_reg[1] ^ code_reg[2] ^ code_reg[3] ^ code_reg[4] ^ code_reg[5] ^ code_reg[6] ^ code_reg[7];

    assign scancode = valid_reg ? code_reg : 8'b0;
    assign valid = valid_reg;

    always_ff @ (posedge clock) begin
        if (reset) begin
            clk1_reg <= 1'b0;
            clk2_reg <= 1'b0;
            data_reg <= 1'b0;
            code_reg <= 8'b0;
            state_reg <= STATE_DELAY;
            valid_reg <= 1'b0;
        end else begin
            clk1_reg <= ps2_clock;
            clk2_reg <= clk1_reg;

            data_reg <= ps2_data;

            valid_reg <= 1'b0;
            casez(state_reg)
                STATE_DELAY: begin
                    state_reg <= STATE_START;
                end
                STATE_START: begin
                    if (rise_comb) begin
                        if (data_reg == 1'b0) begin
                            state_reg <= STATE_D0;
                        end else begin
                            state_reg <= STATE_DELAY;
                        end
                    end
                end
                STATE_D0: begin
                    if (rise_comb) begin
                        code_reg[0] <= data_reg;
                        state_reg <= STATE_D1;
                    end
                end
                STATE_D1: begin
                    if (rise_comb) begin
                        code_reg[1] <= data_reg;
                        state_reg <= STATE_D2;
                    end
                end
                STATE_D2: begin
                    if (rise_comb) begin
                        code_reg[2] <= data_reg;
                        state_reg <= STATE_D3;
                    end
                end
                STATE_D3: begin
                    if (rise_comb) begin
                        code_reg[3] <= data_reg;
                        state_reg <= STATE_D4;
                    end
                end
                STATE_D4: begin
                    if (rise_comb) begin
                        code_reg[4] <= data_reg;
                        state_reg <= STATE_D5;
                    end
                end
                STATE_D5: begin
                    if (rise_comb) begin
                        code_reg[5] <= data_reg;
                        state_reg <= STATE_D6;
                    end
                end
                STATE_D6: begin
                    if (rise_comb) begin
                        code_reg[6] <= data_reg;
                        state_reg <= STATE_D7;
                    end
                end
                STATE_D7: begin
                    if (rise_comb) begin
                        code_reg[7] <= data_reg;
                        state_reg <= STATE_PARITY;
                    end
                end
                STATE_PARITY: begin
                    if (rise_comb) begin
                        if (data_reg ^ odd_comb == 1'b1) begin
                            state_reg <= STATE_STOP;
                        end else begin
                            state_reg <= STATE_DELAY;
                        end
                    end
                end
                STATE_STOP: begin
                    if (rise_comb) begin
                        if (data_reg == 1'b1) begin
                            state_reg <= STATE_FINISH;
                        end else begin
                            state_reg <= STATE_DELAY;
                        end
                    end
                end
                STATE_FINISH: begin
                    state_reg <= STATE_DELAY;
                    valid_reg <= 1'b1;
                end
                default: begin
                    state_reg <= STATE_DELAY;
                end
            endcase
        end
    end

endmodule