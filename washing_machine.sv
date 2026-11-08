module washing_machine(
    output logic water_valve, drum_motor, drain_pump,
                 spin_motor, door_lock, done,
    input logic clock, n_reset, start, door_closed,
                water_full, water_empty, timed);

enum {IDLE, FILL, WASH, DRAIN1, RINSE,
      DRAIN2, SPIN, FINISHED} present_state, next_state;

always_ff @(posedge clock, negedge n_reset)
    begin: SEQ
        if (!n_reset)
            present_state <= IDLE;
        else
            present_state <= next_state;
    end

always_comb
    begin: COM
        water_valve = '0;
        drum_motor = '0;
        drain_pump = '0;
        spin_motor = '0;
        door_lock = '0;
        done = '0;
        next_state = present_state;

        unique case (present_state)
            IDLE: begin
                if (start && door_closed)
                    next_state = FILL;
            end

            FILL: begin
                door_lock = '1;
                water_valve = '1;
                if (water_full)
                    next_state = WASH;
            end

            WASH: begin
                door_lock = '1;
                drum_motor = '1;
                if (timed)
                    next_state = DRAIN1;
            end

            DRAIN1: begin
                door_lock = '1;
                drain_pump = '1;
                if (water_empty)
                    next_state = RINSE;
            end

            RINSE: begin
                door_lock = '1;
                water_valve = '1;
                drum_motor = '1;
                if (timed)
                    next_state = DRAIN2;
            end

            DRAIN2: begin
                door_lock = '1;
                drain_pump = '1;
                if (water_empty)
                    next_state = SPIN;
            end

            SPIN: begin
                door_lock = '1;
                spin_motor = '1;
                if (timed)
                    next_state = FINISHED;
            end

            FINISHED: begin
                done = '1;
                next_state = IDLE;
            end

        endcase
    end
endmodule