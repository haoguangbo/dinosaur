`timescale 1ns / 1ps

module Ground (
    input wire [31:0] clkdiv,
    input wire N_rst,
    input wire [8:0] row_addr,
    input wire [9:0] col_addr,
    output reg [9:0] ground_position,
    input wire game_status,
    input wire fresh,
    output reg [3:0] speed,
	 //reg [319:0] pattern,
    //output reg [319:0] px
    output reg px
    );
    reg [1279:0] pattern;

   // initial begin
   //     speed<=1'd1;
   //     ground_position<=6'b0;
   // end

    always @(negedge fresh) begin
        if (game_status) begin
            ground_position<=(ground_position+speed)%10'd160;
        end
    end

    always @(posedge clkdiv[0]) //begin
    begin
        if (game_status) begin
            if (row_addr>=10'd400 && row_addr<10'd408) begin
                px <= pattern[(col_addr+ground_position)%10'd160+(row_addr-10'd400)*12'd160];
                //px <= 1'b1;
            end else begin
                px <= 1'b0;
            end
        end else begin
            speed<=10'd1;
            pattern[159:0]<=160'b1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111_1111111111;
            pattern[319:160]<=160'b0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
            pattern[479:320]<=160'b0000000000_0111000000_0000000000_0000000011_1000000000_0000000000_0000000000_0000000000_0000000110_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000;
            pattern[639:480]<=160'b0000000000_0000000000_0000000000_0000000000_0000110000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000111000_0000000000_0000000000_0000000000;
            pattern[799:640]<=160'b0000000000_0100000000_0000000000_0000110000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0011000000;
            pattern[959:800]<=160'b0000000000_0000000000_0000011100_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0011110000_0000000000_0000000000_0000000000_0000000000_0000000000;
            pattern[1119:960]<=160'b0000000010_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0011000000_0000000000_0000000000_0000000000_0000000000_0011100000_0000000000_0000000000_0000000000;
            pattern[1279:1120]<=160'b0000000000_0111000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000000000_0000111000_0000000000_0000000000_0000000000_0000000000_0000001000;
        end
    end
    
    initial begin
        ground_position<=10'b0;
    end
    

endmodule

