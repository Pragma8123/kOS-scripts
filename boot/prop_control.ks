// Wait for ship to be unpacked
wait until ship:unpacked.

// Clear the screen.
clearscreen.


// Local functions
local function set_propangle {
    parameter angle.

    local props is ship:partstagged("prop").

    // Get a list of all props
    if props:length = 0 {
        panic("No props found on ship!").
    }

    for prop in props {
        prop:getmodule("ModuleControlSurface"):setfield("deploy angle", angle).
    }
}

local function calc_ideal_angle {
    parameter air_speed.

    // TODO: Find a better algorithm for calculating ideal prop angle
    return min(40.0, max(10.0, air_speed * 0.44)).
}

local function panic {
    parameter error.

    clearscreen.
    print error.
    
    shutdown.
}


// Infinite loop
until 0 {
    // Min prop angle of 9 and max of 40
    set propangle to calc_ideal_angle.
    set_propangle(propangle).

    // Print stats
    print "=========Prop Angle Controller========" at (0, 1).
    print "Airspeed:  " + round(airspeed, 1) at (0, 2).
    print "Prop Angle:" + round(propangle, 1) at (0, 3).
    print "======================================" at (0, 4).

    // Script loop runs at 10Hz
    wait 0.1.
}
