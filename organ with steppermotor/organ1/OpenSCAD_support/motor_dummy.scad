module motor_dummy(){
    rotate([0, 0, 45])
    union(){
        translate([10, 0, -1])cylinder(10, 1.5, 1.5, false, $fn = 10);
        translate([-10, 0, -1])cylinder(10, 1.5, 1.5, false, $fn = 10);
        translate([0, 0, -1])cylinder(10, 2.75, 2.75, false, $fn = 15);
    };
};
//motor_dummy();