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
