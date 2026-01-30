// Posedge detection of a signal

module posedge_detector(clk,signal,posedge_flag);

input clk;
input signal;
output reg posedge_flag;

reg signal_delayed;

always@(posedge clk)
begin
    signal_delayed <= signal;
end

always@(*)
begin
    if(signal & ~signal_delayed)
      posedge_flag <= 1'b1;
    else
      posedge_flag <= 1'b0;
end

endmodule
