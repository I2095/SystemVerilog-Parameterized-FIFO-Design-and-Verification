# Simulation Results
<img width="1348" height="304" alt="image" src="https://github.com/user-attachments/assets/ab4e56b5-32db-4e5f-9333-74c5d8358814" />

## Simulation Analysis (Waveform Explanation)

The waveform demonstrates correct FIFO behavior under synchronous read/write operations.

---

### Clock (`clk`)
A continuous free-running clock drives the entire design.  
All FIFO operations are synchronous and occur strictly on the **rising edge** of `clk`, ensuring deterministic timing behavior.

---

### Write Operation (`write_en` + `write_ptr`)
When `write_en` is asserted:

- `data_in` is written into the FIFO memory location pointed to by `write_ptr`
- The write pointer increments sequentially after each write
- The pointer wraps around from `7 → 0`, demonstrating circular buffer behavior

This confirms correct implementation of **modulo-based FIFO addressing**.

---

### Read Operation (`read_en` + `read_ptr`)
When `read_en` is asserted:

- `data_out` reflects the value stored at the location pointed to by `read_ptr`
- A **1-cycle registered delay** is observed, confirming synchronous read behavior
- The read pointer increments sequentially after each read

This validates proper **pointer-based data retrieval with registered output logic**.

---

### Data Flow (`data_in` / `data_out`)
The FIFO correctly maintains **First-In First-Out ordering**.

Observed output sequence:

```
09 → 3D → F9 → 12 → CE → ...
```

This confirms:
- No data corruption
- Correct storage and retrieval order
- Proper synchronization between write and read pointers

---

### Empty Flag (`empty`)
- `empty` asserts HIGH when `write_ptr == read_ptr`
- It de-asserts immediately after a write operation occurs
- It re-asserts only when all written data has been read out

This confirms accurate **FIFO occupancy tracking**.

---

### Full Flag (`full`)
- `full` would assert when the FIFO reaches maximum capacity (pointer wrap-around with full occupancy)
- In this simulation, `full` remains LOW, indicating:
  - FIFO never reached maximum depth
  - No overflow condition occurred

---

<img width="1360" height="336" alt="image" src="https://github.com/user-attachments/assets/3a5d9991-07b0-4b45-a226-e3e5e7d5e7ee" />


### Phase 1 — Initial Write Burst

In the first phase, `write_en` is asserted HIGH continuously, resulting in a burst write operation into the FIFO.

- Data values such as `09, 8D, 01, 3D, F9, AA` are written sequentially
- `read_en` remains LOW, ensuring no read operations occur during this phase
- The `empty` flag de-asserts immediately after the first valid write, confirming successful data storage

This phase validates:
- Correct memory write operation
- Proper write pointer increment behavior
- Accurate empty flag de-assertion

---

### Phase 2 — Interleaved Read and Write (Producer–Consumer Model)

In this phase, `write_en` and `read_en` are alternated to simulate a real-world **producer–consumer scenario**.

- Data is simultaneously written and read in a controlled alternating pattern
- `data_out` reflects previously written values with a **1-clock-cycle latency**, confirming synchronous registered read behavior
- FIFO maintains correct ordering despite concurrent operations

This phase validates:
- Simultaneous read/write handling
- FIFO ordering integrity
- Correct pipeline latency behavior

---

### Phase 3 — Repeated Burst Cycles & Stress Testing

The final phase introduces repeated write-then-read cycles across the full simulation duration (500,000 ns).

- Multiple burst cycles are executed back-to-back
- Pointer wrap-around is exercised (`7 → 0`), validating circular buffer behavior
- No data corruption or ordering violations are observed during extended operation

This phase validates:
- Long-duration stability
- Pointer wrap-around correctness
- Robust FIFO behavior under continuous load

---

### Verification Mechanism (Scoreboard Model)

The testbench uses a **self-checking scoreboard-based verification approach**.

- `pending_expected[7:0]` acts as a reference model queue
- Every write operation pushes expected data into the scoreboard
- Every read operation compares `data_out` against the expected value

This ensures **automated correctness checking without manual waveform inspection**.

---

### FIFO Occupancy Tracking

The internal `count[3:0]` register continuously tracks FIFO depth in real time:

```
0 → 1 → 2 → 1 → 0
```

This confirms:
- Accurate occupancy tracking
- Correct increment/decrement logic
- Proper synchronization between read and write operations

---

### Summary

The simulation confirms correct FIFO behavior under all tested scenarios:

- ✔ Burst write functionality
- ✔ Interleaved producer–consumer operation
- ✔ Long-duration stress testing
- ✔ Correct pointer wrap-around (circular buffer behavior)
- ✔ Accurate scoreboard-based verification
- ✔ Reliable occupancy tracking
- ✔ No data loss or ordering violations
