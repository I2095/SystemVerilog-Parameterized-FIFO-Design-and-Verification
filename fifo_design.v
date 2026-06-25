module fifo #(
  parameter DATA_WIDTH = 8,
  parameter DEPTH = 8
)
(
  input  logic clk,
  input  logic rst,
  input  logic write_en,
  input  logic read_en,
  input  logic [DATA_WIDTH-1:0] data_in,
  output logic [DATA_WIDTH-1:0] data_out,
  output logic full,
  output logic empty
);

  // Memory
  logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

  // Pointers and count
  logic [$clog2(DEPTH)-1:0] write_ptr;
  logic [$clog2(DEPTH)-1:0] read_ptr;
  logic [$clog2(DEPTH):0]   count;

  // Status flags
  assign full  = (count == DEPTH);
  assign empty = (count == 0);
  
// FIFO logic
  always_ff @(posedge clk or posedge rst) 
    begin
    if (rst) 
      begin
      write_ptr <= 0;
      read_ptr  <= 0;
      count     <= 0;
      data_out  <= 0;
    end 
      else begin

// Write logic
      if (write_en && !full) 
        begin
        mem[write_ptr] <= data_in;
        write_ptr <= (write_ptr + 1) % DEPTH;   
      end

// Read Logic
      if (read_en && !empty) 
        begin
        data_out <= mem[read_ptr];
        read_ptr <= (read_ptr + 1) % DEPTH;
      end

      case ({write_en && !full, read_en && !empty})
        2'b10: count <= count + 1; // write only
        2'b01: count <= count - 1; // read only
        2'b11: count <= count;     // simultaneous → no change
        default: count <= count;
      endcase 
    end 
  end
endmodule

