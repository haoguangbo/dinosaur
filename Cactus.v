`timescale 1ns / 1ps

module Cactus(
    input wire [31:0] clkdiv,
    input wire RESET,
    input wire START,
    input wire [8:0] row_addr,
    input wire [9:0] col_addr,
    input wire game_status,
    input wire fresh,
    input wire [3:0] speed,
    output reg px
    );

    reg [3480:0] pattern;

    reg [9:0] position;


    always @(negedge fresh) begin
        if (game_status) begin
            position<=(position+speed)%(10'd640+10'd60);
        end else begin
            if (RESET || START) begin
                position <=10'b0;
            end
        end
    end

    always @(posedge clkdiv[0]) begin
        //TEST
        // if (game_status) begin
            if (row_addr>=10'd344 && row_addr<10'd402) begin
                if (col_addr>=(10'd640 > position ? 10'd640 - position : 10'd0) && col_addr<10'd700 - position) begin
                    px <= pattern[(col_addr + position - 16'd640) + (row_addr-16'd344) * 16'd60];
                end else begin
                    px <= 1'b0;
                end
            end else begin
                px <= 1'b0;
            end
        // end
    end


    always @(posedge RESET) begin
        //row 58
        //col 60
        pattern[59:0]<=60'b0000000000_0000000000_0000001111_1111000000_0000000000_0000000000;
        pattern[119:60]<=60'b0000000000_0000000000_0000011111_1111100000_0000000000_0000000000;
        pattern[179:120]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[239:180]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[299:240]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[359:300]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[419:360]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[479:420]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[539:480]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[599:540]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[659:600]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[719:660]<=60'b0000000011_1100000000_0000111111_1111110000_0000000000_0000000000;
        pattern[779:720]<=60'b0000000111_1110000000_0000111111_1111110000_0000000000_0000000000;
        pattern[830:780]<=60'b0000001111_1111000000_0000111111_1111110000_0000000000_0000000000;
        pattern[899:840]<=60'b0000001111_1111000000_0000111111_1111110000_0000000111_1000000000;
        pattern[959:900]<=60'b0000001111_1111000000_0000111111_1111110000_0000001111_1100000000;
        pattern[1019:960]<=60'b0000001111_1111000000_0000111111_1111110000_0000001111_1100000000;
        pattern[1079:1020]<=60'b0000001111_1111000000_0000111111_1111110000_0000001111_1100000000;
        pattern[1139:1080]<=60'b0000001111_1111000000_0000111111_1111110000_0000001111_1100000000;
        pattern[1199:1140]<=60'b0000001111_1111111111_1111111111_1111110000_0000001111_1100000000;
        pattern[1259:1200]<=60'b0000001111_1111111111_1111111111_1111110000_0000001111_1100000000;
        pattern[1319:1260]<=60'b0000001111_1111111111_1111111111_1111110000_0000001111_1100000000;
        pattern[1379:1320]<=60'b0000000011_1111111111_1111111111_1111110000_0000001111_1100000000;
        pattern[1439:1380]<=60'b0000000000_1111111111_1111111111_1111111111_1111111111_1100000000;
        pattern[1499:1440]<=60'b0000000000_0011111111_1111111111_1111111111_1111111111_1100000000;
        pattern[1559:1500]<=60'b0000000000_0001111111_1111111111_1111111111_1111111111_1100000000;
        pattern[1619:1560]<=60'b0000000000_0000011111_1111111111_1111111111_1111111111_1100000000;
        pattern[1679:1620]<=60'b0000000000_0000000000_1111111111_1111111111_1111111100_0000000000;
        pattern[1739:1680]<=60'b0000000000_0000000000_0000111111_1111111111_1111110000_0000000000;
        pattern[1799:1740]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[1859:1800]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[1920:1860]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[1979:1920]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2039:1980]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2099:2040]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2159:2100]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2219:2160]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2279:2220]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2339:2280]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2399:2340]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2459:2400]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2519:2460]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2579:2520]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2639:2580]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2699:2640]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2759:2700]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2819:2760]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2879:2820]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2939:2880]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[2999:2940]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3059:3000]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3119:3060]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3179:3120]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3239:3180]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3299:3240]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3359:3300]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3419:3360]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern[3479:3420]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
    end
    

endmodule
