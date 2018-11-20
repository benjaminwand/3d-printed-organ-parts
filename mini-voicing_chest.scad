
// outer and inner diameter of tube for the barometer
meter_diameter = [11, 8]; 

// outer and inner diameters of all tubes towards the pipes
// by the way, it doesn't make a lot of sense using pipes 
// where the inside is much wider than the outside of he valves pipes
tubes = [ [11, 8], [11, 8], [11, 8], [11, 8], [11, 8], [11, 8],       
[16, 12], [16, 12],
[8, 6], [8, 6]];

// outer diameter of wider valve pipe:
wideOuter = 11.6;
// inner diameter of narrower valve pipe:
narrowInner = 8.2; 

// the height in your printer volume (z-axis)
height = 190;

// from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Add_all_values_in_a_list
function add2(v) = [for(p=v) 1]*v;
    
// placements of valves/tubes in x-direction
tubes_X = [for (i= [0 : len(tubes) -1])           
    round(
        add2([ for (j = [0 : i])  max (tubes[j][0], wideOuter) ]) 
        - (tubes[i][0])/2   // back to the middle of the tube
        + 10                // distance to bellow
        + 3*i               // 3mm distance between pipes
    )
];

// bellow case
case_points = [ [0, -98.5, 1.5], [0, 98.5, 1.5], [0, -98.5, height - 1.5], [0, 98.5, height - 1.5], [-20, -98.5, 1.5], [-20, 98.5, 1.5], [-3, -98.5, height - 1.5], [-3, 98.5, height - 1.5] ];
        
x_length = tubes_X[len(tubes) -1] + wideOuter/2 + 23.5;
echo(str("x length of the resulting print: ", x_length));

  //  echo(str("sounding length inside pipe ", name[i], " in mm: ", soundingLength[i]));

// bellow case
difference(){
    union(){                                // plus
        union(){                            // case towards bellow
            hull(){                         // towards voice chest
                translate(case_points[0])sphere(1.5); 
                translate(case_points[1])sphere(1.5); 
                translate(case_points[2])sphere(1.5); 
                translate(case_points[3])sphere(1.5);
            };
            hull(){                         // floor
                translate(case_points[0])sphere(1.5); 
                translate(case_points[1])sphere(1.5); 
                translate(case_points[4])sphere(1.5); 
                translate(case_points[5])sphere(1.5);
            };   
            difference(){
                hull(){                     // towards bellow
                    translate(case_points[4])sphere(1.5); 
                    translate(case_points[5])sphere(1.5); 
                    translate(case_points[6])sphere(1.5); 
                    translate(case_points[7])sphere(1.5);
                };
                for (j = [3 : 16]) translate([0, -5*j, 5*j])
                    for (i = [3 : 16 ])
                        translate([-12, 5*i, 5*i]) rotate([45, 0 , 0]) cube([20, 5, 5], true);
                };
            hull(){                         // side
                translate(case_points[0])sphere(1.5); 
                translate(case_points[2])sphere(1.5); 
                translate(case_points[4])sphere(1.5);
                translate(case_points[6])sphere(1.5);
            };
            hull(){                         // side
                translate(case_points[1])sphere(1.5); 
                translate(case_points[3])sphere(1.5); 
                translate(case_points[5])sphere(1.5);
                translate(case_points[7])sphere(1.5);
            };
            hull(){                         // top
                translate(case_points[2])sphere(1.5); 
                translate(case_points[3])sphere(1.5); 
                translate(case_points[6])sphere(1.5);
                translate(case_points[7])sphere(1.5);
            };
            translate([-20, -98.5, 0]) cube ([20, 197, 0.5], false);
        };
        union(){                            // tube holders
            rotate([90, 0, 0])                  // upper tube holder
                linear_extrude(meter_diameter[0]*3.5 + 15) 
                    polygon(points = [
                        [0, height ], 
                        [0, height - 40], 
                        [meter_diameter[0] + 5, meter_diameter[0] + height - 35], 
                        [meter_diameter[0] + 5, height ]
                    ]);
            translate ([0, meter_diameter[0] * -2 - 15], 0) // lower tube holder
                cube ([meter_diameter[0] + 5 , meter_diameter[0] * 2 + 15, 20], false);
        };
        translate([0, 100, 0])              // bassin outside
            rotate([90, 0, 0])
                linear_extrude(100) 
                    polygon(points = [
                        [0, height ], 
                        [0, height - 40], 
                        [30, height - 10], 
                        [30, height ]
                    ]);
        union(){                             //ruler
            translate([0, -meter_diameter[0] - 14, meter_diameter[1]/2 +7.5])  
                cube([meter_diameter[0] +2, 13, height - 7.5 - meter_diameter[1]/2], false);
            for (i= [0:2:(height-10)])
            translate([meter_diameter[0] +1.4, -meter_diameter[0] - 14, i])   
                cube([1, 13, 1], false);
            for (i= [0:10:(height-10)])
            translate([meter_diameter[0] +1.8, -meter_diameter[0] - 14, i])   
                cube([1, 13, 1], false);
        };
            rotate([0, 90, 0])              // windchest outside
                linear_extrude(tubes_X[len(tubes) -1] + wideOuter/2 + 3) 
                    polygon(points = [
                        [0, -0.1], 
                        [-60, 15 - 2 - wideOuter/2], 
                        [-60, 15 + 2 + wideOuter/2],
                        [-50, 35], 
                        [-30, 35],
                        [0, 30]
                    ]);
    };
    union(){                // minus                             
        union(){            // barometer tube spacers
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, meter_diameter[1]/2 +7.5])
                cylinder (height - 30, meter_diameter[0]/2, meter_diameter[0]/2);
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, meter_diameter[1]/2 +7.5])
                cylinder (height - 30, meter_diameter[0]/2, meter_diameter[0]/2);
        };
        union(){            // lower barometer action
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, meter_diameter[1]/2 +2])
                cylinder (6, meter_diameter[1]/2, meter_diameter[1]/2);
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, meter_diameter[1]/2 +2])
                cylinder (6, meter_diameter[1]/2, meter_diameter[1]/2);
            hull(){
                translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, meter_diameter[1]/2 +2])
                    sphere(meter_diameter[1]/2);
                translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, meter_diameter[1]/2 +2])
                    sphere(meter_diameter[1]/2);
            };
        };
        for (i = [1 : 5])   // spacers for nylon string
            translate([2.5, 0, 25*i + 20])
                rotate ([90, 0, 0]) cylinder(50, 1, 1, false);
        union(){                    // upper barometer action
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, height - 9 - meter_diameter[1]/2 - meter_diameter[1]/2])
                cylinder (10, meter_diameter[1]/2, meter_diameter[1]/2);
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, height - 9 - meter_diameter[1]/2 - meter_diameter[1]/2])
                cylinder (10, meter_diameter[1]/2, meter_diameter[1]/2);
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, height - 37 - meter_diameter[1]/2 - meter_diameter[1]/2])
                cylinder (28.01, meter_diameter[0]/2, meter_diameter[0]/2);
            translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, height - 35 - meter_diameter[1]/2 - meter_diameter[1]/2])
                cylinder (30.01, meter_diameter[0]/2, meter_diameter[0]/2);
            hull(){
                translate([meter_diameter[0]/2 + 3, 2, height])
                    sphere(meter_diameter[0]/2 + 1.5);
                translate([meter_diameter[0]/2 + 1.5, 10, height - 21.5])
                    sphere(meter_diameter[0]/2);
                translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, height - meter_diameter[1]/2 - meter_diameter[1]/2])
                    sphere(meter_diameter[1]/2);
            };    
            hull(){
                translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, height - meter_diameter[1]/2 - meter_diameter[1]/2])
                    sphere(meter_diameter[1]/2);
                translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*2.5 - 15, height - meter_diameter[1]/2 - meter_diameter[1]/2])
                    sphere(meter_diameter[1]/2);        
            };
            hull(){
                translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*2.5 - 15, height - meter_diameter[1]/2 - meter_diameter[1]/2])
                    sphere(meter_diameter[1]/2);  
                translate([- 2, -meter_diameter[0]*2.5 - 15, height - 35])
                rotate([0, 90, 0])
                    cylinder (0.01, meter_diameter[0], meter_diameter[0]);
            }; 
        };
        
        translate([0, 97.5, 0])             // bassin inside
        rotate([90, 0, 0])
        linear_extrude(95.5) 
            polygon(points = [
                [1.5, height + 2], 
                [1.5, height - 35], 
                [28, height - 8], 
                [28, height + 2]
            ]);    
        for (i = [0 : len(tubes) -1])           // valve spacers
            translate ([tubes_X[i], 15, 20]) cylinder(50, wideOuter/2, wideOuter/2, false);
        translate([-5, 0, 0])                   // windchest inside
            rotate([0, 90, 0])
                linear_extrude(tubes_X[len(tubes) -1] + wideOuter/2 + 5) 
                    polygon(points = [
                        [-1.5, 1.5], 
                        [-1.5, 28.5], 
                        [-20.05, 15 + wideOuter*0.4], 
                        [-20.05, 15 - wideOuter*0.4]
                    ]);
        union(){                                // towards pipes
            for (i = [0 : len(tubes) -1])
            translate ([tubes_X[i], 45, 40]) rotate ([90, 0, 0]) cylinder(20, tubes[i][0]/2, tubes[i][0]/2, false);
            
            for (i = [0 : len(tubes) -1])
            translate ([tubes_X[i], 25.5, 40]) rotate ([90, 0, 0]) cylinder(11, tubes[i][1]/2, wideOuter/2, false);
        };
    };
};


// bellow
difference(){
hull(){
translate([-30, -100, 100])cube ([3, 200,height - 100], false);
difference(){
    translate([-30, 0, 100])rotate ([0, 90, 0])cylinder(3, 100, 100, false);
    translate([-30.5, -100, 101])cube ([4, 200, 100], false);
};
translate([-35, 0, 70])cube([15,65, 50], true);
};
translate([0, 12, 70])rotate([0, -90, 0])cylinder(50, 7, 7, false);     //minus
translate([0, -12, 70])rotate([0, -90, 0])cylinder(50, 7, 7, false);
translate([-33, 0, 70])cube([15,60, 45], true);
translate([-45, 0, 30])rotate([90, 0, 0])cylinder(150, 16, 16, true);
};
/*
todo:
code besser kommentieren
x and y volumme
chnGE NAME FOR meter diameter ( make shorter)
*/