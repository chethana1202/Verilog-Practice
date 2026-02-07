module synch_fifo_tb();

reg clk,rstn;
reg write,read;
reg [7:0] din;

wire [7:0] dout;
wire empty,full;

synch_fifo dut(.clk(clk),.rstn(rstn),.write(write),.read(read),.din(din),.dout(dout),.empty(empty),.full(full));

initial
begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

task initialize();
begin
    rstn = 1'b0;
    write = 1'b0;
    read = 1'b0;
    din = 8'd0;
end
endtask

task reset();
begin
    rstn = 1'b0;
    #10 rstn = 1'b1;
end
endtask

task write_task(input [7:0] data);
begin
    @(negedge clk);
    read = 1'b0;
    write = 1'b1;
    din = data;
    @(negedge clk);
    write = 1'b0;
end
endtask

task read_task();
begin
    @(negedge clk);
    write = 1'b0;
    read = 1'b1;
    @(negedge clk);
    read = 1'b0;
end
endtask

initial
begin
    initialize();
    #10;
    reset();
    write_task(8'hAB);
    read_task();
    #10;
    read_task();
    write_task(8'hFF);
    read_task();
    #10;
    write_task(8'hBB);
    read_task();
    #10;
    read_task();
    write_task(8'hAA);
    read_task();
    #10;
    reset();
    #10;
    repeat(18)
    write_task(8'hDA);
    read_task();
    reset();
    #10;
    #100 $finish;
end

endmodule
