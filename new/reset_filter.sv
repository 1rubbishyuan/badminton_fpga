// ¸´Î»ÂË²¨Ä£¿é

module reset_filter(
    input wire clk,
    input wire rst_in,
    output reg rst_out
);

localparam COUNT = 16;

reg [3:0] cnt = 4'b0;

always_ff @(posedge clk) begin
    if(rst_in) begin
        if (cnt == COUNT - 1) begin
            rst_out <= 1;
        end
        else begin
            rst_out <= 0;
            cnt <= cnt + 1;
        end
    end
    else begin 
        rst_out <= 0;
        cnt <= cnt - 1;
    end
end

endmodule