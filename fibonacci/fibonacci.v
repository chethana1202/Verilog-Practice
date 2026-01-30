module fibonacci(clk,rstn,val);

input clk;
input rstn;
output reg [31:0] val;

reg [31:0] prev,curr;

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
    begin
        prev <= 32'd0;
        curr <= 32'd1;
        val <= 32'd0;
    end
    else
    begin
        val = prev + curr;
        prev = curr;
        curr = val;
    end
end

endmodule        
