# RISC-V 32-Bit Processor Project

## Author

Anya Yasir  
Registration Number: 2020-CE-44

## Overview

This project, developed by Anya Yasir, is a complete implementation of a 32-bit RISC-V processor. RISC-V is an open standard instruction set architecture (ISA) based on established reduced instruction set computer (RISC) principles. This processor is designed in SystemVerilog and is suitable for educational purposes, hardware enthusiasts, and anyone interested in processor design.

## Project Structure

The project consists of several SystemVerilog `.sv` files and memory initialization `.mem` files, each serving a distinct role in the processor design:

### SystemVerilog Files

- `alu.sv`: Arithmetic Logic Unit, performs arithmetic and logical operations.
- `br_cond.sv`: Branch Condition checker, evaluates branch conditions.
- `controller.sv`: Controls the processor operations based on decoded instructions.
- `csr.sv`: Control and Status Register, manages control and status registers.
- `data_mem.sv`: Data Memory, simulates the processor's data memory.
- `hazard_unit.sv`: Hazard Detection Unit, handles data hazards in the pipeline.
- `imm_gen.sv`: Immediate Generator, generates immediate values from instructions.
- `inst_dec.sv`: Instruction Decoder, decodes the fetched instructions.
- `inst_mem.sv`: Instruction Memory, simulates the processor's instruction memory.
- `mux_2x1.sv`: 2x1 Multiplexer, used in various parts of the processor for selection.
- `pc.sv`: Program Counter, keeps track of the processor's instruction address.
- `processor.sv`: Top-level module that integrates all components of the processor.
- `reg_file.sv`: Register File, stores the processor's registers.
- `tb_processor.sv`: Testbench for the processor, used for simulation and verification.

### Memory Initialization Files

- `csr.mem` and `csr_out.mem`: Initialization and output for Control and Status Registers.
- `dm.mem` and `dm_out.mem`: Data memory and its output contents.
- `inst.mem`: Instruction memory initialization file.
- `rf.mem` and `rf_out.mem`: Register file initialization and output.

## Getting Started

To use this processor:

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Environment Setup**: Ensure you have a SystemVerilog-compatible simulator.
3. **Simulation**: Use `tb_processor.sv` for simulating the processor.


## Design Diagram
https://github.com/Anya620/RISCV-Processor/blob/main/Processordesign.JPG
