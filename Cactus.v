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

    reg [59:0] pattern0 [57:0];
    reg [59:0] pattern1 [57:0];
    reg [59:0] pattern2 [57:0];
    reg [9:0] position;
    reg [1:0] cactus_type;
    reg [9:0] wait_counter;
    reg [9:0] wait_time;
    wire [4:0] random_number;

    //use random module to generate pseudo random number
    Random random (.clk(fresh),.RESET(RESET),.data(random_number));


    always @(negedge fresh) begin
        if (game_status) begin
            if (position==10'b0) begin
                if (wait_counter==10'b0) begin
                    wait_time<=random_number*10'd10;//wait time randoms from 0s to 5s (60 frames every second)
                    cactus_type<=random_number%3;//random a cactus type
                    wait_counter<=1;
                end else begin
                    wait_counter<=wait_counter+1;
                    if (wait_counter>=wait_time) begin//if reached the wait time
                        position<=speed;//begin to show the cactus
                        wait_counter<=10'b0;//make the counter return to zero
                    end
                end
            end else begin
                position<=(position+speed)%(10'd640+10'd60);//move the cactus (same speed as the ground)
            end
        end else begin
            if (RESET || START) begin //reset or begin the game after it stops
                position <=10'b0;
                wait_counter<=10'b0;
                wait_time<=10'b0;
            end
        end
    end

    always @(posedge clkdiv[0]) begin
        if (row_addr>=10'd344 && row_addr<10'd402) begin
            if (col_addr>=(10'd640 > position ? 10'd640 - position : 10'd0) && col_addr<10'd700 - position) begin
                //print pattern base on the value of cactus type
                if (cactus_type==0) begin
                    px <= pattern0[row_addr - 16'd344][col_addr + position - 16'd640];
                end
                if (cactus_type==1) begin
                    px <= pattern1[row_addr - 16'd344][col_addr + position - 16'd640];
                end
                if (cactus_type==2) begin
                    px <= pattern2[row_addr - 16'd344][col_addr + position - 16'd640];
                end
            end else begin
                px <= 1'b0;
            end
        end else begin
            px <= 1'b0;
        end
    end


    always @(posedge RESET) begin
        //three different cactus patterns (actually there can be more)
        //row 58
        //col 60
        pattern0[0]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern0[1]<=60'b0000000000_0000000000_0000001111_1111000000_0000000000_0000000000;
        pattern0[2]<=60'b0000000000_0000000000_0000011111_1111100000_0000000000_0000000000;
        pattern0[3]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[4]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[5]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[6]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[7]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[8]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[9]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[10]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[11]<=60'b0000000000_0000011000_0000111111_1111110000_0000000000_0000000000;
        pattern0[12]<=60'b0000000000_0000111100_0000111111_1111110000_0000000000_0000000000;
        pattern0[13]<=60'b0000000000_0001111110_0000111111_1111110000_0000000000_0000000000;
        pattern0[14]<=60'b0000000000_0011111111_0000111111_1111110000_0011000000_0000000000;
        pattern0[15]<=60'b0000000000_0011111111_0000111111_1111110000_0111100000_0000000000;
        pattern0[16]<=60'b0000000000_0011111111_0000111111_1111110000_1111110000_0000000000;
        pattern0[17]<=60'b0000000000_0011111111_0000111111_1111110000_1111110000_0000000000;
        pattern0[18]<=60'b0000000000_0011111111_0000111111_1111110000_1111110000_0000000000;
        pattern0[19]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern0[20]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern0[21]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern0[22]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern0[23]<=60'b0000000000_0011111111_1111111111_1111111111_1111110000_0000000000;
        pattern0[24]<=60'b0000000000_0000111111_1111111111_1111111111_1111110000_0000000000;
        pattern0[25]<=60'b0000000000_0000001111_1111111111_1111111111_1111110000_0000000000;
        pattern0[26]<=60'b0000000000_0000000011_1111111111_1111111111_1111000000_0000000000;
        pattern0[27]<=60'b0000000000_0000000000_1111111111_1111111111_1100000000_0000000000;
        pattern0[28]<=60'b0000000000_0000000000_0000111111_1111111111_0000000000_0000000000;
        pattern0[29]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[30]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[31]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[32]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[33]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[34]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[35]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[36]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[37]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[38]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[39]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[40]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[41]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[42]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[43]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[44]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[45]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[46]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[47]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[48]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[49]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[50]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[51]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[52]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[53]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[54]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[55]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[56]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern0[57]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;


        pattern1[0]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern1[1]<=60'b0000000000_0000000000_0000001111_1111000000_0000000000_0000000000;
        pattern1[2]<=60'b0000000000_0000000000_0000011111_1111100000_0000000000_0000000000;
        pattern1[3]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[4]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[5]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[6]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[7]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[8]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[9]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[10]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[11]<=60'b0000000000_0000011000_0000111111_1111110000_0000000000_0000000000;
        pattern1[12]<=60'b0000000000_0000111100_0000111111_1111110000_0000000000_0000000000;
        pattern1[13]<=60'b0000000000_0001111110_0000111111_1111110000_0000000000_0000000000;
        pattern1[14]<=60'b0000000000_0011111111_0000111111_1111110000_0011000000_0000000000;
        pattern1[15]<=60'b0000000000_0011111111_0000111111_1111110000_0111100000_0000000000;
        pattern1[16]<=60'b0000000000_0011111111_0000111111_1111110000_1111110000_0000000000;
        pattern1[17]<=60'b0000000000_0011111111_0000111111_1111110000_1111110000_0000000000;
        pattern1[18]<=60'b0000000000_0011111111_0000111111_1111110000_1111110000_0000000000;
        pattern1[19]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern1[20]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern1[21]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern1[22]<=60'b0000000000_0011111111_1111111111_1111110000_1111110000_0000000000;
        pattern1[23]<=60'b0000000000_0011111111_1111111111_1111111111_1111110000_0000000000;
        pattern1[24]<=60'b0000000000_0000111111_1111111111_1111111111_1111110000_0000000000;
        pattern1[25]<=60'b0000000000_0000001111_1111111111_1111111111_1111110000_0000000000;
        pattern1[26]<=60'b0000000000_0000000011_1111111111_1111111111_1111000000_0000000000;
        pattern1[27]<=60'b0000000000_0000000000_1111111111_1111111111_1100000000_0000000000;
        pattern1[28]<=60'b0000000000_0000000000_0000111111_1111111111_0000000000_0000000000;
        pattern1[29]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[30]<=60'b0000000000_0000000000_0000111111_1111110000_0000000000_0000000000;
        pattern1[31]<=60'b0000000000_0000000000_0000111111_1111110000_0000000110_0000000000;
        pattern1[32]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0000000000;
        pattern1[33]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0000000000;
        pattern1[34]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0000000000;
        pattern1[35]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0000100000;
        pattern1[36]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0001110000;
        pattern1[37]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0011111000;
        pattern1[38]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0011111000;
        pattern1[39]<=60'b0000000000_0000000000_0000111111_1111110000_0000001111_0011111000;
        pattern1[40]<=60'b0000011000_0000000000_0000111111_1111110000_0110001111_0011111000;
        pattern1[41]<=60'b0000111100_0000000000_0000111111_1111110000_1111001111_0011111000;
        pattern1[42]<=60'b0000111100_0000000000_0000111111_1111110000_1111001111_0111110000;
        pattern1[43]<=60'b0000111100_1000000000_0000111111_1111110000_1111001111_1111100000;
        pattern1[44]<=60'b0100111101_1100000000_0000111111_1111110000_1111001111_1111000000;
        pattern1[45]<=60'b1110111101_1100000000_0000111111_1111110000_1111001111_1110000000;
        pattern1[46]<=60'b1110111111_1000000000_0000111111_1111110000_1111001111_1100000000;
        pattern1[47]<=60'b1110111111_0000000000_0000111111_1111110000_1111001111_1000000000;
        pattern1[48]<=60'b1110111110_0000000000_0000111111_1111110000_1111001111_0000000000;
        pattern1[49]<=60'b1110111100_0000000000_0000111111_1111110000_0111101111_0000000000;
        pattern1[50]<=60'b0111111100_0000000000_0000111111_1111110000_0011111111_0000000000;
        pattern1[51]<=60'b0011111100_0000000000_0000111111_1111110000_0001111111_0000000000;
        pattern1[52]<=60'b0001111100_0000000000_0000111111_1111110000_0000111111_0000000000;
        pattern1[53]<=60'b0000111100_0000000000_0000111111_1111110000_0000011111_0000000000;
        pattern1[54]<=60'b0000111100_0000000000_0000111111_1111110000_0000001111_0000000000;
        pattern1[55]<=60'b0000111100_0000000000_0000111111_1111110000_0000001111_0000000000;
        pattern1[56]<=60'b0000111100_0000000000_0000111111_1111110000_0000001111_0000000000;
        pattern1[57]<=60'b0000111100_0000000000_0000111111_1111110000_0000001111_0000000000;

        pattern2[0]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[1]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[2]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[3]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[4]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[5]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[6]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[7]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[8]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[9]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[10]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[11]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[12]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[13]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[14]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[15]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[16]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[17]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[18]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[19]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[20]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[21]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[22]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[23]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[24]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[25]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[26]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[27]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[28]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[29]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[30]<=60'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
        pattern2[31]<=60'b0000000000_0000000000_0000000001_1000000000_0000000000_0000000000;
        pattern2[32]<=60'b0000000000_0000000000_0000000011_1100000000_0000000000_0000000000;
        pattern2[33]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[34]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[35]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[36]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[37]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[38]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[39]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[40]<=60'b0000000000_0000000000_0001000111_1110000000_0000000000_0000000000;
        pattern2[41]<=60'b0000000000_0000000000_0011100111_1110000000_0000000000_0000000000;
        pattern2[42]<=60'b0000000000_0000000000_0011100111_1110000000_0000000000_0000000000;
        pattern2[43]<=60'b0000000000_0000000000_0011100111_1110000000_0000000000_0000000000;
        pattern2[44]<=60'b0000000000_0000000000_0011100111_1110001000_0000000000_0000000000;
        pattern2[45]<=60'b0000000000_0000000000_0011100111_1110011100_0000000000_0000000000;
        pattern2[46]<=60'b0000000000_0000000000_0011111111_1110011100_0000000000_0000000000;
        pattern2[47]<=60'b0000000000_0000000000_0001111111_1110011100_0000000000_0000000000;
        pattern2[48]<=60'b0000000000_0000000000_0000111111_1111111100_0000000000_0000000000;
        pattern2[49]<=60'b0000000000_0000000000_0000011111_1111111000_0000000000_0000000000;
        pattern2[50]<=60'b0000000000_0000000000_0000001111_1111110000_0000000000_0000000000;
        pattern2[51]<=60'b0000000000_0000000000_0000000111_1111100000_0000000000_0000000000;
        pattern2[52]<=60'b0000000000_0000000000_0000000111_1111000000_0000000000_0000000000;
        pattern2[53]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[54]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[55]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[56]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;
        pattern2[57]<=60'b0000000000_0000000000_0000000111_1110000000_0000000000_0000000000;

    end
    

endmodule
