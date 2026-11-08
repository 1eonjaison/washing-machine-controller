module washingmachinetb;

logic water_valve, drum_motor, drain_pump,
      spin_motor, door_lock, done,
      clock, n_reset, start, door_closed,
      water_full, water_empty, timed;

washing_machine wm0 (.*);

initial
    begin
        clock = 1'b0;
        forever #5ns clock = ~clock;
    end

initial
    begin
        n_reset = '1;
        #10ns n_reset = '0;
        #10ns n_reset = '1;
    end

initial
    begin
        start = '0;
        door_closed = '0;
        water_full = '0;
        water_empty = '0;
        timed = '0;

        #30ns door_closed = '1;
        start = '1;

        #10ns start = '0;

        #20ns water_full = '1;
        #10ns water_full = '0;

        #30ns timed = '1;
        #10ns timed = '0;

        #20ns water_empty = '1;
        #10ns water_empty = '0;

        #30ns timed = '1;
        #10ns timed = '0;

        #20ns water_empty = '1;
        #10ns water_empty = '0;

        #30ns timed = '1;
        #10ns timed = '0;
    end

endmodule