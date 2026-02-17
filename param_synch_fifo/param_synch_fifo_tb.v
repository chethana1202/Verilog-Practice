module param_synch_fifo_tb();

parameter WIDTH = 8;

reg clk,rstn;
reg write,read;
reg [WIDTH-1:0] din;

wire [WIDTH-1:0] dout;
wire empty,full;

integer i;

// 16x8 fifo
param_synch_fifo #(8,16,5) dut(.clk(clk),.rstn(rstn),.write(write),.read(read),.din(din),.dout(dout),.empty(empty),.full(full));

// 8x8 fifo
//param_synch_fifo #(8,8,4) dut(.clk(clk),.rstn(rstn),.write(write),.read(read),.din(din),.dout(dout),.empty(empty),.full(full));

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

task write_data(input [WIDTH-1:0] d);
begin
		@(negedge clk);
		read = 1'b0;
		write = 1'b1;
		din = d;
		@(negedge clk);
		write = 1'b0;
end
endtask

task read_data();
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
		write_data(8'hAA);
		read_data();
		#10;
		read_data();
		write_data(8'hFF);
		read_data();
		#10;
		reset();
		for(i=0;i<18;i=i+1)
		begin
				write_data(i);
		end
		read_data();
		reset();
		#100 $finish;
end

endmodule
