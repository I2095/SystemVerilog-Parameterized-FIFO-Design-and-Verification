## Interface Signals

The FIFO communicates with external logic through the following control, data, and status signals.

| Signal     | Direction | Width | Description                                                                                                                            |
| ---------- | --------- | ----- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `clk`      | Input     | 1-bit | System clock. All FIFO operations are synchronized to the rising edge of `clk`.                                                        |
| `rst`      | Input     | 1-bit | Active-high reset. Clears internal pointers, occupancy count, and output data.                                                         |
| `write_en` | Input     | 1-bit | Write enable signal. When asserted and the FIFO is not full, `data_in` is stored in the FIFO.                                          |
| `read_en`  | Input     | 1-bit | Read enable signal. When asserted and the FIFO is not empty, the next data word is presented on `data_out`.                            |
| `data_in`  | Input     | 8-bit | Input data bus used for write transactions.                                                                                            |
| `data_out` | Output    | 8-bit | Output data bus used for read transactions.                                                                                            |
| `full`     | Output    | 1-bit | Status flag indicating that the FIFO has reached maximum capacity. Further write operations are blocked until space becomes available. |
| `empty`    | Output    | 1-bit | Status flag indicating that the FIFO contains no valid data. Read operations are blocked until new data is written.                    |

---

## FIFO Design (`src/fifo.sv`)

The FIFO is implemented as a parameterized synchronous memory buffer using a memory array, read/write pointers, and an occupancy counter. The design supports configurable data width and storage depth while maintaining FIFO ordering and protecting against overflow and underflow conditions.

### Design Parameters

| Parameter    | Default Value | Description                                              |
| ------------ | ------------- | -------------------------------------------------------- |
| `DATA_WIDTH` | 8             | Width of each data word stored in the FIFO.              |
| `DEPTH`      | 8             | Total number of storage locations available in the FIFO. |

---

## FIFO Operating Modes

The FIFO supports independent read and write operations as well as simultaneous read/write transactions.

| Write Enable | Read Enable | Full | Empty | Operation                                                                                               |
| ------------ | ----------- | ---- | ----- | ------------------------------------------------------------------------------------------------------- |
| 1            | 0           | 0    | X     | Write operation. `data_in` is stored and occupancy count increments.                                    |
| 0            | 1           | X    | 0     | Read operation. Data is removed from the FIFO and occupancy count decrements.                           |
| 1            | 1           | 0    | 0     | Simultaneous read and write. Data transfer occurs in both directions while occupancy remains unchanged. |
| 1            | 0           | 1    | 0     | FIFO full condition. Write request is ignored to prevent overflow.                                      |
| 0            | 1           | X    | 1     | FIFO empty condition. Read request is ignored to prevent underflow.                                     |
| 0            | 0           | X    | X     | Idle state. No FIFO activity occurs.                                                                    |

### Functional Behavior

* Maintains **First-In First-Out (FIFO)** data ordering.
* Prevents data corruption through overflow and underflow protection.
* Supports simultaneous read and write operations.
* Dynamically updates occupancy tracking using an internal count register.
* Generates `full` and `empty` status flags based on FIFO occupancy.
