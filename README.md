# 📡 FPGA-Based I²C Temperature Controller with Complete ASIC Design Flow

## 📌 Overview

This project presents the complete design, implementation, and ASIC realization of an **I²C-based digital temperature controller** developed in **Verilog HDL**. The design interfaces with the **ADT7420 digital temperature sensor (PmodTMP2)** using a custom-built **I²C Master Controller**, acquires temperature data over the I²C bus, performs hardware-based Celsius-to-Fahrenheit conversion, and displays the measured temperature on the **Basys-3 FPGA** using multiplexed seven-segment displays and LEDs.

Beyond FPGA implementation, the project demonstrates a complete **RTL-to-GDSII ASIC design flow** using the Cadence digital implementation toolchain. The design was synthesized using **Cadence Genus**, physically implemented using **Cadence Innovus**, and timing-verified using **Cadence Tempus**, providing practical exposure to industry-standard digital ASIC design methodologies.

---

# 🎯 Project Objectives

* Design a custom I²C Master Controller in Verilog HDL
* Interface with the ADT7420 temperature sensor
* Implement accurate I²C timing and protocol handling
* Display temperature in both Celsius and Fahrenheit
* Validate functionality on Basys-3 FPGA hardware
* Perform complete ASIC synthesis and physical implementation
* Verify timing closure through Static Timing Analysis (STA)

---

# ⚙️ Design Specifications

| Parameter              | Value              |
| ---------------------- | ------------------ |
| FPGA Board             | Digilent Basys-3   |
| FPGA Device            | Xilinx Artix-7     |
| Sensor                 | ADT7420 (PmodTMP2) |
| Input Clock            | 100 MHz            |
| Generated Clock        | 200 kHz            |
| I²C SCL Frequency      | 10 kHz             |
| Communication Protocol | I²C                |
| HDL                    | Verilog            |
| Simulation             | SimVision          |
| ASIC Synthesis         | Cadence Genus      |
| Physical Design        | Cadence Innovus    |
| STA                    | Cadence Tempus     |

---

# 🏗️ System Architecture

```text
                 +----------------------+
                 | 100 MHz FPGA Clock   |
                 +----------+-----------+
                            |
                            v
                 +----------------------+
                 | Clock Divider        |
                 | 100 MHz → 200 kHz    |
                 +----------+-----------+
                            |
                            v
                 +----------------------+
                 | I²C Master FSM       |
                 | START                |
                 | Address              |
                 | ACK/NACK             |
                 | Read MSB             |
                 | Read LSB             |
                 +----------+-----------+
                            |
                            v
                 +----------------------+
                 | Temperature Register |
                 +----------+-----------+
                            |
            +---------------+----------------+
            |                                |
            v                                v
   Celsius Display                Fahrenheit Converter
                                           |
                                           v
                               Seven Segment Display
```

---

# 🔄 I²C Communication Flow

The custom I²C Master Controller performs the following sequence:

1. Power-up initialization
2. Generate START condition
3. Transmit 7-bit slave address
4. Transmit Read bit
5. Receive slave ACK
6. Read temperature MSB
7. Send ACK
8. Read temperature LSB
9. Send NACK
10. Store received temperature
11. Repeat measurement continuously

The controller uses a Finite State Machine (FSM) with dedicated states for every stage of the I²C transaction, ensuring protocol compliance and deterministic timing.

---

# 🛠️ RTL Modules

| Module           | Description                              |
| ---------------- | ---------------------------------------- |
| top.v            | Top-level integration module             |
| i2c_master.v     | Custom I²C Master Controller             |
| clkgen_200kHz.v  | 100 MHz to 200 kHz clock divider         |
| temp_converter.v | Celsius-to-Fahrenheit conversion         |
| multiply_by_9.v  | Arithmetic multiplier                    |
| divide_by_5.v    | Arithmetic divider                       |
| add_32.v         | Adds 32 for Fahrenheit conversion        |
| seg7.v           | Multiplexed seven-segment display driver |

---

# 🔧 FPGA Implementation

The RTL design was synthesized and implemented on the Digilent Basys-3 FPGA. Functional verification confirmed successful communication with the ADT7420 sensor, continuous temperature acquisition, and real-time display updates on the onboard LEDs and seven-segment display.

---

# 🧪 Functional Verification

Simulation was carried out using Cadence SimVision to verify:

* Clock generation
* I²C START/STOP conditions
* SDA bidirectional behavior
* Slave acknowledgment
* Temperature data reception
* FSM transitions
* Celsius-to-Fahrenheit conversion
* Display logic

Simulation waveforms demonstrating successful data transfer are included in the repository.

---

# 🏭 ASIC Design Flow

The FPGA RTL was subsequently implemented using an industry-standard ASIC flow.

### RTL Synthesis

* Cadence Genus
* Gate-level netlist generation
* Area optimization
* Logic optimization

### Physical Design

* Floorplanning
* Standard-cell placement
* Power planning
* Clock Tree Synthesis (CTS)
* Global routing
* Detailed routing

### Static Timing Analysis

Performed using Cadence Tempus to verify:

* Setup timing
* Hold timing
* Worst Negative Slack (WNS)
* Total Negative Slack (TNS)
* Timing closure

---

# 🚀 Applications

* Digital Temperature Monitoring
* Embedded Sensor Interfaces
* FPGA-Based Embedded Systems
* ASIC RTL Design
* Physical Design Flow Demonstration
* Digital Communication Interfaces
* Educational FPGA/ASIC Projects

---

# 🔮 Future Improvements

* Support multiple I²C slave devices
* Configurable I²C clock frequency
* Interrupt-driven temperature acquisition
* UART interface for serial monitoring
* APB/AHB wrapper for SoC integration
* ASIC implementation in advanced technology nodes

---

# 👩‍💻 Author

**Sreelakshmi S S**

Electronics and Communication Engineering
Government Engineering College, Thrissur

**Interests:** Digital ASIC Design • RTL Design • FPGA • Physical Design • Embedded Systems

---

# 📜 License

This project is intended for educational and research purposes.
