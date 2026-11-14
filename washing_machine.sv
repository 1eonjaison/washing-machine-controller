module washing_machine( // Washing machine controller using a finite state machine (FSM).
    output logic water_valve, drum_motor, drain_pump,
                 spin_motor, door_lock, done,
    input logic clock, n_reset, start, door_closed,
                water_full, water_empty, timed);

enum {IDLE, FILL, WASH, DRAIN1, RINSE,
      DRAIN2, SPIN, FINISHED} present_state, next_state; // Defines the washing machine states and tracks state transitions.

    always_ff @(posedge clock, negedge n_reset) // Updates the current state on each clock cycle or resets to IDLE.
    begin: SEQ
        if (!n_reset)
            present_state <= IDLE;
        else
            present_state <= next_state;
    end

always_comb // Controls outputs and determines the next state based on inputs.
    begin: COM
        water_valve = '0;
        drum_motor = '0;
        drain_pump = '0;
        spin_motor = '0;
        door_lock = '0;
        done = '0;
        next_state = present_state;

        unique case (present_state)
            IDLE: begin  // Waits for the start signal and a closed door.
                if (start && door_closed)
                    next_state = FILL;
            end

            FILL: begin // Locks the door and fills the drum with water.
                door_lock = '1;
                water_valve = '1;
                if (water_full)
                    next_state = WASH;
            end

            WASH: begin // Runs the drum motor until the timer finishes.
                door_lock = '1;
                drum_motor = '1;
                if (timed)
                    next_state = DRAIN1;
            end

            DRAIN1: begin // Drains the water after the wash cycle.
                door_lock = '1;
                drain_pump = '1;
                if (water_empty)
                    next_state = RINSE;
            end

            RINSE: begin // Adds water and rotates the drum for rinsing.
                door_lock = '1;
                water_valve = '1;
                drum_motor = '1;
                if (timed)
                    next_state = DRAIN2;
            end

            DRAIN2: begin // Drains the water after the rinse cycle.
                door_lock = '1;
                drain_pump = '1;
                if (water_empty)
                    next_state = SPIN;
            end

            SPIN: begin // Spins the drum until the timer finishes.
                door_lock = '1;
                spin_motor = '1;
                if (timed)
                    next_state = FINISHED;
            end

            FINISHED: begin // Signals completion and returns to IDLE.
                done = '1;
                next_state = IDLE;
            end

        endcase
    end
endmodule
