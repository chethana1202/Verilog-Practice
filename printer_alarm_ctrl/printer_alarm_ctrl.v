/* A printing device has three sensors: S2, S1, S0
S2 indicates low ink, S1 indicates that repair is needed, S0 indicates a paper jam
There are three corresponding alarms:
Alarm A should activate if the device is jammed or requires repair.
Alarm B should activate if the device is jammed or low on ink.
Alarm C should activate if two or more issues occur at the same time. */

// Using behavioural abstraction

module printer_alarm_ctrl(S,A,B,C);

input [2:0] S;
output reg A, B, C;

always@(*)
begin
    case(S)
    3'b000: {A,B,C} = 3'b000;
    3'b001: {A,B,C} = 3'b110;
    3'b010: {A,B,C} = 3'b100;
    3'b011: {A,B,C} = 3'b111;
    3'b100: {A,B,C} = 3'b010;
    3'b101: {A,B,C} = 3'b111;
    3'b110: {A,B,C} = 3'b111;
    3'b111: {A,B,C} = 3'b111;
    default: {A,B,C} = 3'b000;
    endcase
end

endmodule
