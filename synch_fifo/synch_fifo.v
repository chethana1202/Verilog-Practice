module synch_fifo(clk,rstn,write,read,din,dout,empty,full);

input clk,rstn;
input write,read;
input [7:0] din;
output reg [7:0] dout;
output wire empty,full;

reg [7:0] mem [15:0];

reg [4:0] wr_ptr = 5'd0;
reg [4:0] rd_ptr = 5'd0;

integer i;

assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;
assign full = ((wr_ptr[4] == ~rd_ptr[4]) && (wr_ptr[3:0] == rd_ptr[3:0])) ? 1'b1 : 1'b0;

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
        for(i=0;i<16;i=i+1)
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
