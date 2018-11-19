
// outer and inner diameter of tube for the barometer
meter_diameter = [11, 8]; 

// outer and inner diameters of all tubes towards the pipes
tubes = [ [11, 8], [11, 8], [11, 8], [11, 8], [11, 8], [11, 8],       
[16, 12], [16, 12],
[8, 6], [8, 6]];

// outer diameter of wider valve pipe:
wideOuter = 11.6;
// inner diameter of narrower valve pipe:
narrowInner = 8.2; 

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

echo(tubes_X=tubes_X);

// bellow case
case_points = [ [0, -98.5, 1.5], [0, 98.5, 1.5], [0, -98.5, 200], [0, 98.5, 200], [-20, -98.5, 1.5], [-20, 98.5, 1.5], [-3, -98.5, 200], [-3, 98.5, 200] ];

// bellow case
difference(){
    union(){                           // plus
        union(){                                // case towards bellow
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
                hull(){                         // towards bellow
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
        };
            rotate([90, 0, 0])
                linear_extrude(meter_diameter[0]*3.5 + 15) 
                    polygon(points = [
                        [0, 201.5], 
                        [0, 160], 
                        [meter_diameter[0] + 5, meter_diameter[0] + 165], 
                        [meter_diameter[0] + 5, 201.5]
                    ]);
        translate([0, 100, 0])
            rotate([90, 0, 0])
                linear_extrude(100) 
                    polygon(points = [
                        [0, 201.5], 
                        [0, 160], 
                        [30, 190], 
                        [30, 201.5]
                    ]);
        translate ([0, meter_diameter[0] * -2 - 15], 0)
            cube ([meter_diameter[0] + 5 , meter_diameter[0] * 2 + 15, 20], false);
        translate([0, -meter_diameter[0] - 14, meter_diameter[1]/2 +7.5])   //ruler
            cube([meter_diameter[0] +2, 13, 180], false);
        for (i= [0:2:200])
        translate([meter_diameter[0] +1.4, -meter_diameter[0] - 14, i])   //ruler
            cube([1, 13, 1], false);
        for (i= [0:10:200])
        translate([meter_diameter[0] +1.8, -meter_diameter[0] - 14, i])   //ruler
            cube([1, 13, 1], false);
        translate([-5, 0, 0])
            rotate([0, 90, 0])
                linear_extrude(tubes_X[len(tubes) -1] + wideOuter/2 + 8) 
                    polygon(points = [
                        [0, -0.1], 
                        [-60, 0], 
                        [-60, 35], 
                        [0, 35]
                    ]);
    };
    union(){                // minus
                            //tube holder  
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, meter_diameter[1]/2 +7.5])
            cylinder (170, meter_diameter[0]/2, meter_diameter[0]/2);
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, meter_diameter[1]/2 +7.5])
            cylinder (170, meter_diameter[0]/2, meter_diameter[0]/2);
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
        for (i = [1 : 5])
            translate([2.5, 0, 25*i + 20])
                rotate ([90, 0, 0]) cylinder(50, 1, 1, false);

        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, 191 - meter_diameter[1]/2 - meter_diameter[1]/2])
            cylinder (10, meter_diameter[1]/2, meter_diameter[1]/2);
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, 191 - meter_diameter[1]/2 - meter_diameter[1]/2])
            cylinder (10, meter_diameter[1]/2, meter_diameter[1]/2);
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, 163 - meter_diameter[1]/2 - meter_diameter[1]/2])
            cylinder (28.01, meter_diameter[0]/2, meter_diameter[0]/2);
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, 165 - meter_diameter[1]/2 - meter_diameter[1]/2])
            cylinder (30.01, meter_diameter[0]/2, meter_diameter[0]/2);
    hull(){
        translate([meter_diameter[0]/2 + 3, 2, 200])
            sphere(meter_diameter[0]/2 + 1.5);
        translate([meter_diameter[0]/2 + 1.5, 10, 178.5])
            sphere(meter_diameter[0]/2);
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]/2 - 3, 200 - meter_diameter[1]/2 - meter_diameter[1]/2])
            sphere(meter_diameter[1]/2);
    };    
    hull(){
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*1.5 - 13, 200 - meter_diameter[1]/2 - meter_diameter[1]/2])
            sphere(meter_diameter[1]/2);
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*2.5 - 15, 200 - meter_diameter[1]/2 - meter_diameter[1]/2])
            sphere(meter_diameter[1]/2);        
    };
    hull(){
        translate([meter_diameter[0]/2 + 1.5, -meter_diameter[0]*2.5 - 15, 200 - meter_diameter[1]/2 - meter_diameter[1]/2])
            sphere(meter_diameter[1]/2);  
        translate([- 2, -meter_diameter[0]*2.5 - 15, 165])
        rotate([0, 90, 0])
            cylinder (0.01, meter_diameter[0], meter_diameter[0]);
    }; 
        
        translate([0, 97.5, 0])
        rotate([90, 0, 0])
        linear_extrude(95.5) 
            polygon(points = [
                [1.5, 202], 
                [1.5, 165], 
                [28, 192], 
                [28, 202]
            ]);
    
    for (i = [0 : len(tubes) -1])
        translate ([tubes_X[i], 15, 20]) cylinder(50, wideOuter/2, wideOuter/2, false);            
    
    translate([-5, 0, 0])
        rotate([0, 90, 0])
            linear_extrude(tubes_X[len(tubes) -1] + wideOuter/2 + 5) 
                polygon(points = [
                    [-1.5, 1.5], 
                    [-1.5, 28.5], 
                    [-20.05, 15 + wideOuter*0.4], 
                    [-20.05, 15 - wideOuter*0.4]
                ]);
    
    for (i = [0 : len(tubes) -1])
    translate ([tubes_X[i], 45, 40]) rotate ([90, 0, 0]) cylinder(20, tubes[i][0]/2, tubes[i][0]/2, false);
    
    for (i = [0 : len(tubes) -1])
    translate ([tubes_X[i], 25.5, 40]) rotate ([90, 0, 0]) cylinder(11, tubes[i][1]/2, wideOuter/2, false);
    };
};

/*
todo:
rendert nicht richtig, irgendwas ist komisch hier
code besser kommentieren
*/