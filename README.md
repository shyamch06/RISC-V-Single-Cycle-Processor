# RISC-V Single-Cycle Processor (RV32I) — Verilog

A single-cycle RV32I RISC-V processor implemented in Verilog, built from the ground up (PC logic, control unit, register file, ALU, memory) and demonstrated live on FPGA hardware — the core runs a Fibonacci-sequence program and streams the result to a 7-segment display in real time.

---
## Overview

This project implements the classic single-cycle RISC-V datapath supporting the base **RV32I** instruction subset needed for R-type, I-type, loads, stores, branches, `jal`/`jalr`, `lui`, and `auipc` instructions.

As a demo application, the processor runs a small hand-assembled program that computes the Fibonacci sequence iteratively in registers `x1`/`x2`, and the running value is converted to BCD and multiplexed out to a 4-digit 7-segment display, so you can watch the Fibonacci numbers count up on real hardware.

---
## Features

- Full single-cycle datapath: PC register, PC+4 adder, branch/jump target adder, instruction memory, register file, sign/zero extension unit, ALU, data memory, and result mux
- Two-level control: a main decoder (opcode → control signals) and an ALU decoder (aluop/func3/func7 → ALU operation)
- Support for R-type, I-type (arithmetic + loads), S-type (stores), B-type (branches: `beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu`), `jal`, `jalr`, `lui`, and `auipc`
- Clock divider to bring a fast FPGA input clock (e.g. 100 MHz) down to a human-visible rate for the demo
- BCD converter (double-dabble algorithm) + 7-segment display driver with digit multiplexing, so a 32-bit register value can be shown on a 4-digit display
- **XDC constraint file** for Basys3 board
- Fully synthesizable Verilog, tested on real FPGA hardware

---
## Verification & Results

Correctness was verified with a self-checking simulation testbench in addition to hardware testing on the Basys 3.

### Self-Checking Testbench

A custom testbench drives the design through Icarus Verilog and automatically checks every computed Fibonacci value against the expected sequence, rather than relying on manual waveform inspection:

    Summary: 10 PASS, 0 FAIL out of 10 checks

The testbench also confirmed correct 32-bit overflow behavior: since the demo loop has no halt condition, it keeps computing Fibonacci terms indefinitely, and terms past roughly the 47th correctly wrap around via standard unsigned integer overflow — expected, mathematically verified behavior rather than a bug.

### Waveform

`fib_value` (register `x1`) stepping cleanly through the Fibonacci sequence in GTKWave:

![Fibonacci sequence waveform](https://raw.githubusercontent.com/shyamch06/RISC-V-Single-Cycle-Processor/main/GTK_Wave/Wave%20Form.jpeg)

### Post-Implementation Timing & Utilization (Vivado, XC7A35T)

| Metric | Result |
|---|---|
| Target clock | 100 MHz (10.000 ns) |
| Worst Negative Slack (WNS) | +5.466 ns |
| Estimated max frequency | ~221 MHz |
| Slice LUTs | 845 / 20,800 (4%) |
| Slice Registers | 470 / 41,600 (1%) |
| Failing endpoints | 0 |

Full reports: [Timing Summary](https://github.com/shyamch06/RISC-V-Single-Cycle-Processor/blob/main/Reports/Timing%20Summary.jpeg) · [Utilization Report](https://github.com/shyamch06/RISC-V-Single-Cycle-Processor/blob/main/Reports/Utilization%20Report.jpeg)

---
## How to Simulate

```bash
iverilog -o riscv_sim *.v
vvp riscv_sim
gtkwave singlecycle_riscv.vcd
```

The testbench speeds up the clock divider for simulation via a `defparam` override on `MAX_COUNT`, so the full 10-check run completes in a fraction of a second of simulated time instead of waiting on the display-speed divider.

---
## Repository Structure

| Module | File | Description |
|---|---|---|
| `topmodule` | top-level | Wires the processor to the clock divider and display chain |
| `processor` | core | Instantiates and connects the full datapath |
| `pc_flop`, `pc_plus4`, `pc_mux`, `pc_target` | PC logic | Program counter update logic |
| `instruction_memory` | IMEM | Loads `program.mem` and serves instructions |
| `instruction_decoder` | decode | Splits instruction into fields (opcode, rs1, rs2, rd, func3, func7) |
| `controlunit`, `main_decoder`, `alu_decoder` | control | Generates all control signals from the opcode/func3/func7 |
| `reg_file` | regfile | 32×32-bit register file, x0 hardwired to zero |
| `extend` | immediate gen | Sign/zero-extends immediates for I/S/B/U/J formats |
| `alu_mux`, `alu` | execute | ALU operand mux and the ALU itself |
| `data_memory` | DMEM | Byte-addressable-ish data memory for loads/stores |
| `result_mux` | writeback | Selects ALU result / memory data / PC+4 / immediate for register writeback |
| `clkdivider` | demo support | Divides the board clock down for visible timing |
| `bcdconvertor` | demo support | Binary-to-BCD conversion (double dabble) |
| `display`, `sevenseg` | demo support | 7-segment display driver and digit decoder |

---
## Tools Used

* Verilog HDL
* Xilinx Vivado
* Icarus Verilog (iverilog)
* GTKWave
* Basys 3 FPGA Board

---

## Author

Cherukuri Shyam Sundhar

Electronics and Communication Engineering

IIT Bhubaneswar
