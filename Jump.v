`timescale 1ns / 1ps

module Jump (
    input wire fresh,
    input wire [31:0] clkdiv,
    input wire button_jump,
    input wire RESET,
    input wire START,
    input wire [8:0] row_addr,
    input wire [9:0] col_addr,
    output reg px,
    input wire game_status
    );
    
    reg [11:0] jump_time;
    wire [11:0] height;
    reg [0:82] pattern [0:88];
    // reg [7215:0] pattern;
    reg jumping;

    //initial begin
        // game_status<=1'b0;
        //game_status<=1'b0;//for DEBUG
        //jump_time<=8'b0;
        //jumping<=1'b0;
    //end

    assign height = (jump_time*12'd60 - jump_time*jump_time) / 3'd6;

    //for every frame
    always @(negedge fresh) begin
        //jump operation
        if (game_status) begin
            if (button_jump && jumping==1'b0) begin
               jumping<=1'b1;
            end
            if (jumping) begin
                if (jump_time>=12'd60) begin
                    jump_time<=12'b0;
                    jumping<=1'b0;
                end else begin
                    jump_time<=jump_time+1'b1;
                end
            end
        end else begin //if pausing
            if (RESET || START) begin
                jump_time<=12'b0;
                jumping<=1'b0;
            end
        end
        
    end

    always @(posedge clkdiv[0]) begin
        //TEST
        // if (game_status) begin
            if (row_addr >= 10'd402 - height - 10'd88 && row_addr < 10'd402 - height && col_addr>=10'd80 && col_addr<10'd162) begin
                //px <= 1'b1;
                //if (col_addr>=10'd120 && col_addr<10'd153) begin
                //    px<=1'b1;
                //end
                //else begin
                //    px<=1'b0;
                //end
                px <= pattern[row_addr+height-10'd314][col_addr-12'd80];
                //px <= pattern[16'd161-col_addr+(row_addr+height-10'd314)*13'd82];
            end else begin
                px <= 1'b0;
            end
        // end
    end

    always @(posedge RESET) begin
        pattern[0]<=82'b0000000000_0000000000_0000000000_0000000000_0000000011_1111111111_1111111111_1111111100_00;
        pattern[1]<=82'b0000000000_0000000000_0000000000_0000000000_0000000011_1111111111_1111111111_1111111100_00;
        pattern[2]<=82'b0000000000_0000000000_0000000000_0000000000_0000000011_1111111111_1111111111_1111111100_00;
        pattern[3]<=82'b0000000000_0000000000_0000000000_0000000000_0000000011_1111111111_1111111111_1111111100_00;
        pattern[4]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[5]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[6]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_0000001111_1111111111_1111111111_11;
        pattern[7]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_0000001111_1111111111_1111111111_11;
        pattern[8]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_0011001111_1111111111_1111111111_11;
        pattern[9]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_0011001111_1111111111_1111111111_11;
        pattern[10]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_0000001111_1111111111_1111111111_11;
        pattern[11]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_0000001111_1111111111_1111111111_11;
        pattern[12]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[13]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[14]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[15]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[16]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[17]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[18]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[19]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[20]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[21]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[22]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[23]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111111_11;
        pattern[24]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111100_00;
        pattern[25]<=82'b0000000000_0000000000_0000000000_0000000000_0000111111_1111111111_1111111111_1111111100_00;
        pattern[26]<=82'b1111000000_0000000000_0000000000_0000000000_1111111111_1111111111_1111111111_1111111100_00;
        pattern[27]<=82'b1111000000_0000000000_0000000000_0000000000_1111111111_1111111111_1111111111_1111111100_00;
        pattern[28]<=82'b1111000000_0000000000_0000000000_0000001111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[29]<=82'b1111000000_0000000000_0000000000_0000001111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[30]<=82'b1111000000_0000000000_0000000000_0000111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[31]<=82'b1111000000_0000000000_0000000000_0000111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[32]<=82'b1111110000_0000000000_0000000000_0011111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[33]<=82'b1111110000_0000000000_0000000000_0011111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[34]<=82'b1111111100_0000000000_0000000000_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[35]<=82'b1111111100_0000000000_0000000000_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[36]<=82'b1111111111_0000000000_0000001111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[37]<=82'b1111111111_0000000000_0000001111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[38]<=82'b1111111111_1100000000_0000111111_1111111111_1111111111_1111111111_1111000000_0000000000_00;
        pattern[39]<=82'b1111111111_1100000000_0000111111_1111111111_1111111111_1111111111_1111000000_0000000000_00;
        pattern[40]<=82'b1111111111_1111000000_1111111111_1111111111_1111111111_1111111111_1111000000_0000000000_00;
        pattern[41]<=82'b1111111111_1111000000_1111111111_1111111111_1111111111_1111111111_1111000000_0000000000_00;
        pattern[42]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_1111000000_0000000000_00;
        pattern[43]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_1111000000_0000000000_00;
        pattern[44]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_1111000000_0000000000_00;
        pattern[45]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_1111000000_0000000000_00;
        pattern[46]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[47]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[48]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[49]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[50]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[51]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[52]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[53]<=82'b1111111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[54]<=82'b0011111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[55]<=82'b0011111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[56]<=82'b0000111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[57]<=82'b0000111111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[58]<=82'b0000001111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[59]<=82'b0000001111_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[60]<=82'b0000000011_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[61]<=82'b0000000011_1111111111_1111111111_1111111111_1111111111_1111110000_0000000000_0000000000_00;
        pattern[62]<=82'b0000000000_1111111111_1111111111_1111111111_1111111111_1111000000_0000000000_0000000000_00;
        pattern[63]<=82'b0000000000_1111111111_1111111111_1111111111_1111111111_1111000000_0000000000_0000000000_00;
        pattern[64]<=82'b0000000000_0011111111_1111111111_1111111111_1111111111_1100000000_0000000000_0000000000_00;
        pattern[65]<=82'b0000000000_0011111111_1111111111_1111111111_1111111111_1100000000_0000000000_0000000000_00;
        pattern[66]<=82'b0000000000_0000111111_1111111111_1111111111_1111111111_0000000000_0000000000_0000000000_00;
        pattern[67]<=82'b0000000000_0000111111_1111111111_1111111111_1111111111_0000000000_0000000000_0000000000_00;
        pattern[68]<=82'b0000000000_0000001111_1111111111_1111111111_1111111100_0000000000_0000000000_0000000000_00;
        pattern[69]<=82'b0000000000_0000001111_1111111111_1111111111_1111111100_0000000000_0000000000_0000000000_00;
        pattern[70]<=82'b0000000000_0000000011_1111111111_1111111111_1111110000_0000000000_0000000000_0000000000_00;
        pattern[71]<=82'b0000000000_0000000011_1111111111_1111111111_1111110000_0000000000_0000000000_0000000000_00;
        pattern[72]<=82'b0000000000_0000000000_1111111111_1111111111_1111000000_0000000000_0000000000_0000000000_00;
        pattern[73]<=82'b0000000000_0000000000_1111111111_1111111111_1111000000_0000000000_0000000000_0000000000_00;
        pattern[74]<=82'b0000000000_0000000000_1111111111_1100001111_1111000000_0000000000_0000000000_0000000000_00;
        pattern[75]<=82'b0000000000_0000000000_1111111111_1100001111_1111000000_0000000000_0000000000_0000000000_00;
        pattern[76]<=82'b0000000000_0000000000_1111111100_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[77]<=82'b0000000000_0000000000_1111111100_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[78]<=82'b0000000000_0000000000_1111111100_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[79]<=82'b0000000000_0000000000_1111110000_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[80]<=82'b0000000000_0000000000_1111000000_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[81]<=82'b0000000000_0000000000_1111000000_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[82]<=82'b0000000000_0000000000_1111000000_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[83]<=82'b0000000000_0000000000_1111000000_0000000000_1111000000_0000000000_0000000000_0000000000_00;
        pattern[84]<=82'b0000000000_0000000000_1111111100_0000000000_1111111100_0000000000_0000000000_0000000000_00;
        pattern[85]<=82'b0000000000_0000000000_1111111100_0000000000_1111111100_0000000000_0000000000_0000000000_00;
        pattern[86]<=82'b0000000000_0000000000_1111111100_0000000000_1111111100_0000000000_0000000000_0000000000_00;
        pattern[87]<=82'b0000000000_0000000000_1111111100_0000000000_1111111100_0000000000_0000000000_0000000000_00;
    end
    
 
    
endmodule
