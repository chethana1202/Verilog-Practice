// Derived clock of 50% duty and divide by 5 frequency

//src_clk = 100 MHz, derived clk = 20 MHz with 50% duty

`timescale 1ns/1ns

module clk_divider3_tb();

reg src_clk;
reg rstn;
wire clk20_50;

clk_divider3 dut(.src_clk(src_clk),.rstn(rstn),.clk20_50(clk20_50));

initial
begin
    src_clk = 1'b0;
    forever #5 src_clk = ~src_clk;
end

task initialize();
begin
    rstn = 1'b0;
end
endtask

task reset();
begin
    rstn = 1'b0;
    #10 rstn = 1'b1;
end
endtask

initial
begin
    initialize();
    reset();
    #300 $finish;
end

endmodule
