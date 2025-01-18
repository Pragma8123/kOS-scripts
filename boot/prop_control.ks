// Wait for ship to be unpacked
wait until ship:unpacked.

// Clear the screen.
clearScreen.

// Functions
local function setpropangle {
    parameter props.
    parameter angle.

    for prop in props {
        prop:getmodule("ModuleControlSurface"):setfield("deploy angle", angle).
    }
}

local function panic {
    parameter error.

    clearScreen.
    print error.
    
    shutdown.
}

local g_props is ship:partstagged("prop").

// Infinite loop
until g_props:length = 0 {
    // Get a list of all props
    set g_props to ship:partstagged("prop").
    if g_props:length = 0 {
        panic("No props found on ship!").
    }

    // Min prop angle of 9 and max of 40
    set propangle to min(40, max(10.0, (airspeed * 0.44))).
    setpropangle(g_props, propangle).

    // Print stats
    print "=========Prop Angle Controller========" at (0, 1).
    print "Airspeed:  " + round(airspeed, 1) at (0, 2).
    print "Prop Angle:" + round(propangle, 1) at (0, 3).
    print "======================================" at (0, 4).

    // Only modify prop angle every 250ms
    wait 0.25.
}
