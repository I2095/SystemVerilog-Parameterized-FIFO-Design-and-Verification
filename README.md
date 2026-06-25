# SystemVerilog-Parameterized-FIFO-Design-and-Verification
RTL design and self-checking verification of a configurable synchronous FIFO using SystemVerilog, randomized testing, scoreboarding, assertions, and waveform analysis.


## Overview

This project implements a parameterized synchronous FIFO
(First-In First-Out) memory buffer in SystemVerilog and verifies
its functionality using a self-checking randomized testbench.

The design supports configurable data width and depth and includes
overflow/underflow protection through full and empty status flags.

Verification is performed using a scoreboard-based architecture
with randomized stimulus generation and automatic result checking.

---

## Features

- Parameterized FIFO design
- Configurable DATA_WIDTH and DEPTH
- Full and Empty flag generation
- Overflow protection
- Underflow protection
- Simultaneous read/write support
- Self-checking verification environment
- Randomized testing using $urandom
- Queue-based golden reference model

---

# FIFO Architecture
<img width="1004" height="500" alt="image" src="https://github.com/user-attachments/assets/e77c1e1f-f806-477b-b7d4-d1d39bccf18f" />

---

# Verification Architecture
<img width="1868" height="316" alt="image" src="https://github.com/user-attachments/assets/84801eba-9766-4007-a1fc-6ed201d71e3b" />

## Verification Methodology

The FIFO was verified using a self-checking testbench consisting of:

- Generator
- Driver
- Monitor
- Scoreboard

A SystemVerilog queue was used as the golden reference model.

Expected behavior:

model_q.push_back(data_in);

Observed behavior:

data_out

The scoreboard automatically compares DUT output
against the reference model and reports mismatches.

---

## 🚀 How to Run on EDA Playground

Follow the steps below to simulate and verify the FIFO design using **EDA Playground**.

---

### 1. Open EDA Playground

Go to:

https://www.edaplayground.com

Sign in or create an account.

---

### 2. Create a New Playground

Add files as follows:

| File | Tab |
|------|-----|
| `fifo.sv` | Design |
| `tb.sv` | Testbench |

---

### 3. Configure Simulation

Set the following options:

| Setting | Value |
|--------|--------|
| Simulator | Aldec Riviera-PRO |
| Top Module | `tb` |
| EPWave | Enable “Open EPWave after run” |

---

### 4. Run Simulation

Click **Run**.

If everything is correct, the console should display:

```text
Test Passed
```

---

### 5. View Waveforms (EPWave)

After execution:

1. Open **EPWave**
2. Add these signals:

```text
clk
rst
write_en
read_en
data_in
data_out
empty
full
count
```

---

##  Verification Success Criteria

- Console shows: `Test Passed`
- No `$error` messages
- FIFO maintains correct ordering
- Full/Empty flags behave correctly

---

# Simulation waveform
<img width="1340" height="300" alt="image" src="https://github.com/user-attachments/assets/7d024bd3-10e1-423c-8021-155ec6d071fc" />

## Verification Results

| Metric | Result |
|----------|---------|
| Randomized Cycles | 100 |
| Writes Tested | 52 |
| Reads Tested | 48 |
| Overflow Cases | Covered |
| Underflow Cases | Covered |
| Simultaneous R/W | Covered |
| Data Mismatches | 0 |
| Test Status | PASS |

---

## Corner Cases Verified

✓ FIFO Empty Read Attempt

✓ FIFO Full Write Attempt

✓ Simultaneous Read and Write

✓ Pointer Wraparound

✓ Continuous Burst Writes

✓ Continuous Burst Reads

✓ Reset During Operation

---

## SystemVerilog Features Utilized

The FIFO design and verification environment leverage several SystemVerilog constructs commonly used in RTL development and functional verification.

| Feature | Purpose |
|----------|----------|
| `parameter` | Enables configurable FIFO depth (`DEPTH`) and data width (`DATA_WIDTH`) for design scalability and reusability. |
| `always_ff` | Implements synchronous sequential logic for FIFO memory, pointers, and occupancy count updates. |
| `assign` | Generates combinational `full` and `empty` status flags based on the current FIFO occupancy. |
| `$urandom` / `$urandom_range` | Generates randomized stimulus to improve verification coverage and expose corner-case scenarios. |
| `logic [$]` Queue | Serves as a golden reference model for expected FIFO behavior within the scoreboard. |
| `push_back()` / `pop_front()` | Models FIFO write and read operations in the reference queue for data integrity checking. |
| `$error()` | Automatically reports mismatches between expected and actual FIFO output data. |
| `$dumpfile()` / `$dumpvars()` | Creates VCD waveform files for post-simulation debugging and analysis. |
| `task` | Encapsulates reusable procedures such as reset operations, improving testbench readability and maintainability. |
| `$clog2()` | Automatically determines the required pointer width based on the configured FIFO depth. |

### Verification Concepts Demonstrated

- Randomized Verification
- Self-Checking Testbench Development
- Queue-Based Scoreboarding
- Data Integrity Verification
- Functional Debugging
- Waveform Analysis
- Boundary Condition Testing
- Overflow and Underflow Protection Verification

---
## Skills Demonstrated

- RTL Design
- SystemVerilog
- Digital Design
- FIFO Architecture
- Verification Methodology
- Randomized Testing
- Scoreboarding
- Functional Validation
- Debugging
- Waveform Analysis

---

### Key Takeaways

This project demonstrates the application of modern SystemVerilog design and verification techniques, including parameterized RTL development, randomized stimulus generation, automated result checking, and waveform-based debugging. The combination of a scoreboard-driven verification flow and randomized testing helps ensure robust validation of FIFO functionality under a wide range of operating conditions.

