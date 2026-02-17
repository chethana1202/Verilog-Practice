// 16x8 parameterized synchronous fifo

module param_synch_fifo #(parameter WIDTH = 8,
													parameter DEPTH = 16,
													parameter PTR_WIDTH = 5) (clk,rstn,write,read,din,dout,empty,full);

input clk,rstn;
input write,read;
input [WIDTH-1:0] din;

output reg [WIDTH-1:0] dout;
output wire empty, full;

reg [DEPTH-1:0] mem [WIDTH-1:0];

reg [PTR_WIDTH-1:0] wr_ptr = 5'd0;
reg [PTR_WIDTH-1:0] rd_ptr = 5'd0;

integer i;

assign empty = (wr_ptr[PTR_WIDTH-1:0] == rd_ptr[PTR_WIDTH-1:0]) ? 1'b1 : 1'b0;

assign full = ((wr_ptr[PTR_WIDTH-1] == ~rd_ptr[PTR_WIDTH-1]) &&
							(wr_ptr[PTR_WIDTH-2:0] == rd_ptr[PTR_WIDTH-2:0])) ? 1'b1 : 1'b0;


always@(posedge clk or negedge rstn)
begin
		if(!rstn)
		begin
				dout <= 8'd0;
				rd_ptr <= 5'd0;
		end
		else
		begin
				if(read && !empty)
				begin
						dout <= mem[rd_ptr];
						rd_ptr <= rd_ptr + 1'b1;
				end
				else
				begin
						dout <= dout;
						rd_ptr <= rd_ptr;
				end
		end
end

always@(posedge clk or negedge rstn)
begin
		if(!rstn)
		begin
				for(i=0;i<(DEPTH-1);i=i+1)
				begin
						mem[i] <= 8'd0;
				end
				wr_ptr <= 5'd0;
		end
		else
		begin
				if(write && !full)
				begin
						mem[wr_ptr] <= din;
						wr_ptr <= wr_ptr + 1'b1;
				end
				else
				begin
						mem[wr_ptr] <= mem[wr_ptr];
						wr_ptr <= wr_ptr;
				end
		end
end
						
endmodule
