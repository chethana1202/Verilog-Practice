// Derived clock of 50% duty and divide by 5 frequency

//src_clk = 100 MHz, derived clk = 20 MHz with 50% duty

module clk_divider3(src_clk,rstn,clk20_50);

input src_clk;
input rstn;
output reg clk20_50;

reg clk20_40p; // clk with 20 MHz and 40% duty - positive edge triggered
reg clk20_40n; // clk with 20 MHz and 40% duty - negative edge trigered
reg [2:0] clk_count;

always@(posedge src_clk or negedge rstn)
begin
    if(!rstn)
    begin
        clk_count <= 3'd0;
        clk20_50 <= 1'b0;
    end
    else
    begin
        // Using MOD 5 counter
        if(clk_count == 4)
          clk_count <= 3'd0;
        else
          clk_count <= clk_count + 1'b1;
    end
end

always@(posedge src_clk or negedge rstn)
begin
    if(!rstn)
    begin
        clk20_40p <= 1'b0;
    end
    else
    begin
        // Generating a clock of 20 MHz with 40% duty using MOD 5 counter
        if(clk_count < 2)
          clk20_40p <= 1'b1;
        else
          clk20_40p <= 1'b0;
    end
end

// Derived clock(50% duty) logic: postrig clk20_40p | negtrig clk20_40  
always@(negedge src_clk or negedge rstn)
begin
    if(!rstn)
    begin
        clk20_40n <= 1'b0;
    end
    else
    begin
        clk20_40n <= clk20_40p;
    end
end

always@(*)
begin
    clk20_50 = clk20_40p | clk20_40n;
end

endmodule
