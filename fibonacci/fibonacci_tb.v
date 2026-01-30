module fibonacci_tb();

reg clk;
reg rstn;

wire [31:0] val;

fibonacci dut(.clk(clk),.rstn(rstn),.val(val));

initial
begin
    clk = 1'b0;
    forever #5 clk = ~clk;
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
    #200 $finish;
end

endmodule
