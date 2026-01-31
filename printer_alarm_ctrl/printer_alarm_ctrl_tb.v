/* A printing device has three sensors: S2, S1, S0
S2 indicates low ink, S1 indicates that repair is needed, S0 indicates a paper jam
There are three corresponding alarms:
Alarm A should activate if the device is jammed or requires repair.
Alarm B should activate if the device is jammed or low on ink.
Alarm C should activate if two or more issues occur at the same time. */


module printer_alarm_ctrl_tb();

reg [2:0] S;
wire A, B, C;

integer i;

printer_alarm_ctrl dut(.S(S),.A(A),.B(B),.C(C));

initial
begin
    S = 3'd0;
    for(i=0;i<8;i=i+1)
    begin
        S = i;
        #10;
    end
    #50 $finish;
end

endmodule    
