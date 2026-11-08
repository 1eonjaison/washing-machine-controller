# SystemVerilog Washing Machine Controller

This project is a washing machine controller developed using SystemVerilog.

The controller uses a Finite State Machine (FSM) to manage the different stages of a washing cycle. It controls the water valve, drum motor, drain pump, spin motor and door lock based on sensor inputs and timing signals.

The project also includes a testbench to simulate the washing cycle and verify the controller's behaviour.

---

## How It Works

The washing machine operates using eight states that represent the different stages of a washing cycle.

The controller moves between states depending on sensor inputs and timing signals.

The washing cycle consists of:

- **Idle** – Waits for the start signal and checks that the door is closed.
- **Fill** – Opens the water valve until the water level sensor indicates that the machine is full.
- **Wash** – Activates the drum motor until the timing signal is received.
- **Drain 1** – Activates the drain pump until the machine is empty.
- **Rinse** – Activates the water valve and drum motor until the timing signal is received.
- **Drain 2** – Drains the water after rinsing.
- **Spin** – Activates the spin motor until the timing signal is received.
- **Finished** – Signals that the washing cycle is complete before returning to Idle.

The door remains locked during the active washing stages and unlocks when the cycle finishes.

---

## Finite State Machine

The controller uses a Finite State Machine with eight states.

The design uses:

- **Sequential Logic** – Updates the current state on the rising edge of the clock.
- **Combinational Logic** – Determines the next state based on the current state and input signals.
- **Output Control** – Activates the appropriate components depending on the current state.
- **Reset** – Returns the controller to the Idle state using an active-low reset signal.

---

## Testbench

The project includes a SystemVerilog testbench to simulate the washing machine controller.

The testbench generates a clock signal and applies different inputs to simulate a complete washing cycle.

It tests the controller by changing the door sensor, water level sensors and timing signals.

The simulation can be used to observe state transitions and check that the correct outputs are activated during each stage.

---

## Project Aim

The aim of this project was to design and simulate a washing machine controller using a Finite State Machine in SystemVerilog.

It helped me improve my understanding of digital logic design, sequential and combinational circuits, state transitions and hardware simulation.

The project also helped me gain experience with writing SystemVerilog testbenches and designing control systems that respond to different inputs.
