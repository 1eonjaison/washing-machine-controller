module washingmachinetb; // Testbench for simulating and verifying the washing machine FSM.

logic water_valve, drum_motor, drain_pump,
      spin_motor, door_lock, done,
      clock, n_reset, start, door_closed,
      water_full, water_empty, timed;

      washing_machine wm0 (.*); // Connects the washing machine module to the testbench signals.

initial // Generates a clock signal with a period of 10ns.
    begin
        clock = 1'b0;
        forever #5ns clock = ~clock;
    end

initial // Resets the washing machine controller before testing.
    begin
        n_reset = '1;
        #10ns n_reset = '0;
        #10ns n_reset = '1;
    end

initial // Simulates the washing machine cycle by changing input signals.
    begin
        start = '0; // Initialises all input signals to zero.
        door_closed = '0;
        water_full = '0;
        water_empty = '0;
        timed = '0;

        #30ns door_closed = '1; // Closes the door and starts the washing cycle.
        start = '1;

        #10ns start = '0; // Disables the start signal.

        #20ns water_full = '1; // Simulates the drum filling with water.
        #10ns water_full = '0;

        #30ns timed = '1; // Simulates completion of the wash cycle.
        #10ns timed = '0;

        #20ns water_empty = '1; // Simulates draining water after washing.
        #10ns water_empty = '0;

        #30ns timed = '1; // Simulates completion of the rinse cycle.
        #10ns timed = '0;

        #20ns water_empty = '1; // Simulates draining water after rinsing.
        #10ns water_empty = '0;

        #30ns timed = '1; // Simulates completion of the spin cycle.
        #10ns timed = '0;
    end
endmodule
