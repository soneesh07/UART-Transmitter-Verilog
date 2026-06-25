# UART Transmitter (Verilog HDL)

## Overview

This project implements an 8-bit UART (Universal Asynchronous Receiver Transmitter) Transmitter using Verilog HDL.

The transmitter sends serial data with:

- 1 Start Bit
- 8 Data Bits (LSB First)
- 1 Stop Bit

The design is fully modular and verified using a Verilog testbench and GTKWave.

---

## Features

- 8-bit UART Transmission
- Configurable Baud Rate Counter
- Finite State Machine (FSM)
- Shift Register
- Bit Counter
- Testbench Included
- GTKWave Simulation

---

## Project Structure

- uart_tx.v
- uart_tx_tb.v

---

## Architecture

UART TX consists of:

- UART FSM
- Baud Counter
- Bit Counter
- Shift Register

---

## Simulation

The design was simulated using:

- Icarus Verilog
- GTKWave

---

## FSM

IDLE
↓

START
↓

DATA
↓

STOP
↓

IDLE

---

## Test Case

Input Data

10100101

Transmitted Data

Start Bit

0

↓

1

↓

0

↓

1

↓

0

↓

0

↓

1

↓

0

↓

1

↓

Stop Bit

1

---

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave

---

## Future Improvements

- UART Receiver
- Configurable Data Width
- Parity Bit
- Multiple Stop Bits
- Parameterized Baud Rate