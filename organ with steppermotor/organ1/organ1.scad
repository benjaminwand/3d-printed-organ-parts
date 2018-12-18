// print each color seperately

include <all_pipes_o1.scad>;            
include <config.scad>;
include <OpenSCAD_support/motor_dummy.scad>;

// upper part with pipes
difference(){
    translate([0, 0, 28])cube([230, 81, 3], false);
    translate ([0, 0, 1.5 - z1])
        for (i= [0 : len(pipe_points)-1 ])
            translate(pipe_points[i]) 
                cylinder(z1 + 5, wideOuter+0.2, wideOuter+0.2, false);

};

// lower part with motors
color("blue")
    union(){
        difference(){           // floor
            cube([230, 81, 3], false);
                for (i= [0 : len(pipe_points)-1 ])
                    translate(pipe_points[i] + [0, 0, -35]) 
                        motor_dummy();
        };
        cube([3, 81, 28], false);
        translate([227, 0, 0])cube([3, 81, 28], false);
        difference(){
            union(){
                translate([0, 78, 0])cube([230, 3, 28], false);
            }
            union(){
                translate([73, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                 
                translate([96, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);       
                translate([193, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                 
                translate([216, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                   
            }
        }
    };
    
color("DarkKhaki")
    union(){
        difference(){
            hull(){
                translate([0, 81, -12])cube(3, false);            
                translate([172, 81, -12])cube(3, false);
                translate([0, 81, 177])cube(3, false);
                translate([172, 81, 177])cube(3, false);
                translate([0, 105, -12])cube(3, false);
                translate([172, 105, -12])cube(3, false);
            }
            union(){
                hull(){
                    translate([85, 98.5, 90]) 
                    rotate([97.25, 0, 0]) cylinder( 0.1, 65, 65,false);
                    translate([85, 87, 90]) 
                    
                    rotate([90, 0, 0]) cylinder( 5, 50, 50,false);
                    translate([73, 90, 13]) 
                    rotate([90,0,0]) cylinder( 8, 7, 7,false);                 
                    translate([96, 90, 13]) 
                    rotate([90,0,0]) cylinder( 8, 7, 7,false);            
                };
                translate([73, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                 
                translate([96, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                   
            }
        }
    };
    
// lower part with motors
color("Magenta")
    union(){
        difference(){
            hull(){
                translate([360, 81, -12])cube(3, false);            
                translate([175, 81, -12])cube(3, false);
                translate([360, 81, 177])cube(3, false);
                translate([175, 81, 177])cube(3, false);
                translate([360, 105, -12])cube(3, false);
                translate([175, 105, -12])cube(3, false);
            }
            union(){
                hull(){
                    translate([270, 98.5, 90]) 
                    rotate([97.25, 0, 0]) cylinder( 0.1, 65, 65,false);
                    translate([270, 87, 90]) 
                    rotate([90, 0, 0]) cylinder( 5, 50, 50,false);
                    translate([193, 90, 13]) 
                    rotate([90,0,0]) cylinder( 8, 7, 7,false);                 
                    translate([270, 90, 13]) 
                    rotate([90,0,0]) cylinder( 8, 7, 7,false);            
                };
                translate([193, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                 
                translate([216, 90, 14]) 
                rotate([90,0,0]) cylinder( 20, 7, 7,false);                         
            }
        }
    };

//front plate
color("green")
translate([0, -3, 0])cube([230, 3, 31], false);

//motor spacer
color("red")
    union(){
    translate([227, 0, -12])cube([3, 81, 12], false);
    translate([0, 78, -12])cube([230, 3, 12], false);
    translate([0, -3, -12])cube([230, 6, 12], false);
};  

// between motors and tubes
color("GreenYellow")
    for (i = [0 : len(pipe_points) -1])
        translate([10 * i, -15, 0])
difference(){
    cylinder(4, narrowInner, narrowInner, $fn = 20);
    translate([0, 0, -1])cylinder(6, 2.35, 2.35, $fn = 15);
};

//bellow
difference(){ color("lavender", alpha = 0.5)
    union(){
        hull(){
            translate([0,150, 90]) 
                cube ([170, 3, 90], false);  
            translate([85,153, 90]) 
                rotate([90,0,0]) cylinder( 3, 85, 85,false);
            translate([42.5, 150, 37.5]) cube ([85, 17.5, 65], false);  
        };
        translate([85,168, 20]) 
            intersection(){
                rotate([0,45,0])cylinder( 30, 12, 12,true);
                rotate([0,-45,0])cylinder(30, 12, 12,true);
            };
    };
    union(){
        translate([97,155, 70])rotate([90,0,0]) cylinder(30, 7, 7,true);
        translate([73,155, 70])rotate([90,0,0]) cylinder(30, 7, 7,true);
        translate([45,145, 40]) cube ([80, 20, 60], false);  
 
    };
};


// todo: 
// durchgang zu balg an blaues dran