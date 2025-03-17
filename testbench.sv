// Code your testbench here
// or browse Examples
module tb_up_down_counter;
  logic clk, rst, up_down, load_en;
  logic [3:0] load_value;
  logic [3:0] count;

  // Instantiate the DUT
  up_down_counter uut (
    .clk(clk),
    .rst(rst),
    .up_down(up_down),
    .load_en(load_en),
    .load_value(load_value),
    .count(count)
  );

  // Clock generation (T = 10 time units)
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_up_down_counter);

    clk = 0;
    rst = 1;
    up_down = 1; // Default to up count
    load_en = 0;
    load_value = 4'b0000;

    #10 rst = 0; // Release reset

    fork_join_test();
    fork_join_any_test();
    fork_join_none_test();

    #400; // Ensure sufficient simulation time
    $finish;
  end

  // ---------------------- //
  // Test using fork-join   //
  // ---------------------- //
  task fork_join_test();
    fork
      begin
        repeat (20) begin
          #10 $display("Checking count at %t, count=%d", $time, count);
        end
      end
    join
    $display("All fork-join tasks completed at %t", $time);
  endtask

  // ---------------------- //
  // Test using fork-join_any //
  // ---------------------- //
  task fork_join_any_test();
    fork
      begin
        #10 load_en = 1; load_value = 4'b1010;
        #5 load_en = 0;
        $display("[ANY] Loaded value = %d at %t", count, $time);
      end
      begin
        #20 up_down = 0; // Switch to down count
        #30 $display("[ANY] Down counting check, count=%d at %t", count, $time);
      end
      begin
        #50 up_down = 1; // Switch to up count
        #30 $display("[ANY] Up counting check, count=%d at %t", count, $time);
      end
    join_any
    $display("At least one fork-join_any task completed at %t", $time);
  endtask

  // ---------------------- //
  // Test using fork-join_none //
  // ---------------------- //
  task fork_join_none_test();
    fork
      begin
        #10 rst = 1; #5 rst = 0;
        $display("[NONE] Reset applied asynchronously at %t", $time);
      end
      begin
        #30 up_down = ~up_down; // Toggle up-down
        $display("[NONE] Up-Down toggled at %t, new mode = %s", 
                  $time, up_down ? "UP" : "DOWN");
      end
      begin
        #200;
        @(posedge clk); // Ensure the counter has updated
        if (count == 4'b0000)
          $display("[NONE] Final roll-over check passed at %t, count=%d", 
                    $time, count);
        else
          $display("[NONE] Final roll-over check failed at %t, count=%d", 
                    $time, count);
      end
    join_none
    $display("All fork-join_none tasks started without waiting at %t", $time);
  endtask
endmodule
