module posedge_detector_tb();

reg clk;
reg signal;
wire posedge_flag;

posedge_detector dut(.clk(clk),.signal(signal),.posedge_flag(posedge_flag));

initial
begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial
begin
    signal = 1'b0;
    @(negedge clk);
    signal = 1'b1;
    repeat(2)
    @(negedge clk);
    signal = 1'b0;
    repeat(3)
    @(negedge clk);
    signal = 1'b1;
    repeat(2)
    @(negedge clk);
    signal = 1'b0;
    repeat(3)
    @(negedge clk);
    signal = 1'b1;
    repeat(1)
    @(negedge clk);
    signal = 1'b0;
    repeat(4)
    @(negedge clk);
    signal = 1'b1;
    repeat(3)
    @(negedge clk);
    signal = 1'b0;
    repeat(5)
    @(negedge clk);
    signal = 1'b1;
    #100 $finish;
end

endmodule    
