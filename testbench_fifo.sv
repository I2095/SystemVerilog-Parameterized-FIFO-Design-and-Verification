`timescale 1ns/1ps

module tb;
  parameter DEPTH = 8;
  parameter DATA_WIDTH = 8;

  // DUT signals
  
  logic clk, rst;
  logic write_en, read_en;
 logic [DATA_WIDTH-1:0] data_in;
logic[DATA_WIDTH-1:0] data_out;
  logic full, empty;

  // Instantiate DUT 
  
  fifo #(DATA_WIDTH, DEPTH) dut (
    .clk(clk),
    .rst(rst),
    .write_en(write_en),
    .read_en(read_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );
  
// Clock
  always #5 clk = ~clk; //clock toggles every 5 nanoseconds,time period is 10ns.

  // Scoreboard
  
  logic [DATA_WIDTH-1:0] model_q[$]; //generate expected o/p
 logic         pending_read;
  logic [DATA_WIDTH-1:0] pending_expected;
  
//Reset
   task reset();
    rst = 1; write_en = 0; read_en = 0; data_in = 0;
    pending_read = 0;
    repeat(2) @(posedge clk);
    rst = 0;
  endtask
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);      //Stores all signals of testbench into waveform file.
clk = 0;
 reset(); 
repeat(100) 
  begin @(posedge clk);
 #1; // small delay to let signals settle after clock edge
    
// Step 1: Check previous cycle's read result NOW
 if (pending_read)
   begin
  if (data_out !== pending_expected)
 $error("MISMATCH: expected=%0d got=%0d", pending_expected, data_out);
pending_read = 0;
 end
    
 // Step 2: Apply new stimulus
 write_en = $urandom_range(0, 1);
 read_en  = $urandom_range(0, 1);
 data_in  = $urandom;
    
// Step 3: Update model for this cycle's actions
  if (write_en && !full)
   model_q.push_back(data_in);    //built-in SystemVerilog queue methods.
    
 if (read_en && !empty) 
   begin
      pending_expected = model_q.pop_front();
        pending_read = 1;             // check data_out on NEXT clock edge
     end
    end

// Check last pending read if any
    if (pending_read)
      begin
      @(posedge clk); #1;
      if (data_out !== pending_expected)
    $error("MISMATCH: expected=%0d got=%0d", pending_expected, data_out);
  end
    
   $display("Test Passed");
    
    $finish;
    
  end
  
endmodule

