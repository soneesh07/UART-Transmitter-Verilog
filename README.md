# UART Transmitter (Verilog HDL)

An 8-bit UART (Universal Asynchronous Receiver Transmitter) Transmitter designed in **Verilog HDL**. The project implements a modular UART transmitter capable of serially transmitting 8-bit parallel data using a finite state machine (FSM), baud rate generator, bit counter, and shift register.

---

## Features

- 8-bit UART transmission
- Finite State Machine (FSM) based controller
- Configurable baud rate generator
- Shift register for serial data transmission
- Bit counter for tracking transmitted bits
- Start bit and stop bit generation
- Modular RTL design
- Verified using a custom Verilog testbench
- Simulated with GTKWave

---

## UART Frame Format

| Field | Bits |
|-------|------|
| Start Bit | 1 |
| Data Bits | 8 (LSB First) |
| Parity | None |
| Stop Bit | 1 |

Transmission format:

```
Idle → Start → D0 → D1 → D2 → D3 → D4 → D5 → D6 → D7 → Stop
```

---

## Project Structure

```
UART-Transmitter-Verilog/
│
├── uart_tx.v          # UART transmitter RTL
├── uart_tx_tb.v       # Testbench
├── README.md
└── .gitignore
```

---

## Design Architecture

The UART transmitter consists of four major blocks:

- UART FSM
- Baud Counter
- Bit Counter
- Shift Register

```
                 +----------------+
 data_in ------->| Shift Register |
                 +----------------+
                         |
                         |
                         v
                  +--------------+
                  | UART FSM     |
                  +--------------+
                         |
        +-------------------------------+
        | Baud Counter | Bit Counter    |
        +-------------------------------+
                         |
                         v
                        TX
```

---

## FSM States

```
          +-------+
          | IDLE  |
          +-------+
              |
              | start
              v
          +-------+
          | START |
          +-------+
              |
              | baud_done
              v
          +-------+
          | DATA  |
          +-------+
              |
     bit_done |
              v
          +-------+
          | STOP  |
          +-------+
              |
              | baud_done
              v
          +-------+
          | IDLE  |
          +-------+
```

---

## Simulation

### Test Input

```
data_in = 8'b10100101
```

### UART Output (LSB First)

```
Start : 0

Bit0 : 1
Bit1 : 0
Bit2 : 1
Bit3 : 0
Bit4 : 0
Bit5 : 1
Bit6 : 0
Bit7 : 1

Stop : 1
```

---

## Simulation Result

The design was verified using:

- Icarus Verilog
- GTKWave

## Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Git
- GitHub

---

## Future Improvements

- UART Receiver (RX)
- Configurable baud rate
- Configurable data width
- Parity bit support
- Multiple stop bits
- Loopback communication (TX ↔ RX)

---

## Author

**Soneesh**

Electrical Engineering Student,IIT Kharagpur.

Interested in:
- Digital Design
- FPGA Design
- RTL Design
- Computer Architecture
