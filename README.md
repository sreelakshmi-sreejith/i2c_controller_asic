# FPGA-Based I²C Temperature Controller with Complete ASIC Design Flow

## Overview

This project implements a custom **I²C Master Controller** in **Verilog HDL** to interface with the **ADT7420 digital temperature sensor** on the **PmodTMP2** module. The design periodically reads temperature data over the I²C bus, converts the measured value from **Celsius to Fahrenheit** using dedicated hardware modules, and displays the result on the **Basys-3 FPGA's seven-segment display** and LEDs.

Beyond FPGA implementation, the project demonstrates a **complete ASIC design flow** using the Cadence digital design suite. The RTL design was synthesized using **Cadence Genus**, physically implemented using **Cadence Innovus**, and verified through **Cadence Tempus** static timing analysis, providing hands-on experience with an industry-standard RTL-to-GDSII workflow.

---

## Key Features

* Custom Verilog implementation of the I²C Master protocol
* Communication with the ADT7420 temperature sensor over the I²C bus
* 100 MHz FPGA clock divided to 200 kHz and 10 kHz for I²C timing
* Finite State Machine (FSM) implementing START, address transmission, ACK/NACK handling, data reception, and repeated transactions
* Bidirectional SDA tri-state control compliant with the I²C protocol
* Hardware-based Celsius-to-Fahrenheit conversion using arithmetic modules
* Real-time display of temperature on the Basys-3 seven-segment display
* LED output for binary temperature visualization
* Functional RTL simulation and waveform verification
* FPGA implementation and hardware validation
* ASIC synthesis, place-and-route, clock tree synthesis, routing, and timing closure using Cadence tools

---

## Hardware Used

* Digilent Basys-3 FPGA Development Board
* Xilinx Artix-7 FPGA
* Digilent PmodTMP2 Temperature Sensor (ADT7420)

---

## Design Flow

```
Verilog RTL Design
        │
        ▼
Functional Simulation
        │
        ▼
FPGA Implementation (Vivado)
        │
        ▼
Hardware Verification
        │
        ▼
Cadence Genus (RTL Synthesis)
        │
        ▼
Cadence Innovus (Floorplanning, Placement, CTS, Routing)
        │
        ▼
Cadence Tempus (Static Timing Analysis)
        │
        ▼
Timing Closure
```

---

## RTL Modules

* `top.v` – Top-level integration module
* `i2c_master.v` – I²C Master finite state machine
* `clkgen_200kHz.v` – Clock divider
* `temp_converter.v` – Celsius-to-Fahrenheit converter
* `multiply_by_9.v` – Arithmetic module
* `divide_by_5.v` – Arithmetic module
* `add_32.v` – Arithmetic module
* `seg7.v` – Seven-segment display controller

---

## ASIC Implementation

The ASIC flow includes:

* RTL synthesis using Cadence Genus
* Gate-level netlist generation
* Floorplanning
* Standard cell placement
* Clock Tree Synthesis (CTS)
* Global and detailed routing
* Physical layout generation
* Static Timing Analysis (STA)
* Setup and hold timing verification

Screenshots of the RTL schematic, floorplan, routing, layout, timing reports, and simulation waveforms are included in the repository.

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* Cadence Genus
* Cadence Innovus
* Cadence Tempus
* SimVision

---

## Applications

* FPGA-Based Embedded Systems
* Digital ASIC Design
* RTL Design and Verification
* I²C Communication Interfaces
* Sensor Interfacing
* Digital Hardware Design
