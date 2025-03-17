// Code your design here
module up_down_counter (
    input logic clk,         // Clock signal
    input logic rst,         // Reset signal
    input logic up_down,     // Direction control (1 = Up, 0 = Down)
    input logic load_en,     // Load enable signal
    input logic [3:0] load_value, // Load value
    output logic [3:0] count // 4-bit counter output
);

always_ff @(posedge clk) begin
    if (rst)
        count <= 4'b0000;       // Reset count to 0
    else if (load_en)
        count <= load_value;    // Load specified value
    else if (up_down)
        count <= count + 1;     // Increment when up_down = 1
    else
        count <= count - 1;     // Decrement when up_down = 0
end

endmodule
