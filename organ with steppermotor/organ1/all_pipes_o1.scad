// flue pipe

include <OpenSCAD_support/loft.scad>
include <config.scad>

// placement
end_of_keyboard = 70; // y-direction
z1 = 30;
z2 = 75;

move_c = [36, 50, 1.5 + z1];
move_cis = [68, 50, 1.5 + z1];
move_d = [100, 50, 1.5 + z1];
move_dis = [132, 50, 1.5 + z1];
move_e = [162, 50, 1.5 + z1];
move_f = [194, 50, 1.5 + z1];
move_fis = [20, 20, 1.5 + z1];
move_g = [52, 20, 1.5 + z1];
move_gis = [84, 20, 1.5 + z1];
move_a = [116, 20, 1.5 + z1];
move_ais = [148, 20, 1.5 + z1];
move_h = [180, 20, 1.5 + z1];
move_c1 = [212, 20, 1.5 + z1];
pipe_points = [move_c, move_cis, move_d, move_dis, move_e, move_f, 
    move_fis, move_g, move_gis, move_a, move_ais, move_h, move_c1];

// variables seperate for each pipe
name = ["c", "cis", "d", "dis", "e", "f", "fis", "g", "gis", "a", "ais", "h", "c1"];
placement = [move_c, move_cis, move_d, move_dis, move_e, move_f, 
    move_fis, move_g, move_gis, move_a, move_ais, move_h, move_c1];
outerDiameter = [/*c*/ 30.2,/*cis*/ 30.2,/*d*/ 30.2,/*dis*/ 25.2,/*e*/ 25.2,/*f*/ 25.2,
    /*fis*/ 25.2,/*g*/ 25.2,/*gis*/ 20.2,/*a*/ 20.2,/*ais*/ 20.2,/*h*/ 20.2,/*c1*/ 20.2]; 
innerDiameter = [/*c*/ 26,/*cis*/ 26,/*d*/ 26,/*dis*/ 22,/*e*/ 22,/*f*/ 21,
    /*fis*/ 21,/*g*/ 21,/*gis*/ 17,/*a*/ 17,/*ais*/ 17,/*h*/ 16,/*c1*/ 16];        
labiumWidth = [/*c*/ 23.4,/*cis*/ 22.4,/*d*/ 21.5,/*dis*/ 20.6,/*e*/ 19.7,/*f*/ 18.8,
    /*fis*/ 18,/*g*/ 17.3,/*gis*/ 16.5,/*a*/ 15.8,/*ais*/ 15.2,/*h*/ 14.5,/*c1*/ 13.9];
outCut = [/*c*/ 6.6,/*cis*/ 6.2,/*d*/ 6,/*dis*/ 5.8,/*e*/ 5.5,/*f*/ 5.3,
    /*fis*/ 5.1,/*g*/ 4.8,/*gis*/ 4.6,/*a*/ 4.4,/*ais*/ 4.2,/*h*/ 4,/*c1*/ 3.9];           
lengthFlue = [/*c*/ 34.8,/*cis*/ 32.7,/*d*/ 30.8,/*dis*/ 29,/*e*/ 27.3,/*f*/ 25.7,
    /*fis*/ 24.1,/*g*/ 22.8,/*gis*/ 21.4,/*a*/ 20.2,/*ais*/ 19,/*h*/ 17.9,/*c1*/ 16.8];
flueSteps = [/*c*/ 20,/*cis*/ 20,/*d*/ 16,/*dis*/ 17,/*e*/ 16,/*f*/ 17,
    /*fis*/ 17,/*g*/ 16,/*gis*/ 16,/*a*/ 15,/*ais*/ 21,/*h*/ 15,/*c1*/ 15]; 

// variables equal for each pipe
minWallThickness = 1.2;
floorThickness = 2;
number_of_layers = 8 ;   // .. of the flue loft

// proportions, are most likely good like that
air_supply_diameter = [for (i = [0: (len(name) - 1)])wideOuter * 2]; 
flueWidth = /*[0.5, 0.8];*/     [for (i = [0: (len(name) - 1)])innerDiameter[i] * 0.02 + 0.2];
tubeInsert = [for (i = [0: (len(name) - 1)])lengthFlue[i] - (labiumWidth[i]/2 + outCut[i])/sqrt(2) - minWallThickness];    
pipeInsert = [for (i = [0: (len(name) - 1)])outerDiameter[i]*0.1 + 5]; 
height = [for (i = [0: (len(name) - 1)])
    floorThickness
    + lengthFlue[i]
    + labiumWidth[i] / sqrt(2)
    + outerDiameter[i]*0.1 + 5]; 
    
// calculations, don't touch in production use
labium_angle_45 = [for (i = [0: (len(name) - 1)])labiumWidth[i] * 360 / outerDiameter[i] / PI / sqrt(2)];
ground = [for (i = [0: (len(name) - 1)])(lengthFlue[i] + floorThickness)*-1];
airSupplyX = [for (i = [0: (len(name) -1)])(ground[i] + tubeInsert[i]) / sqrt(2)];
airSupplyY = [for (i = [0: (len(name) -1)])sin(270+labium_angle_45[i]*0.4)*(outerDiameter[i]+flueWidth[i])/4 - outerDiameter[i]/4];
soundingLength = [for (i = [0: (len(name) - 1)])height[i] - pipeInsert[i] - floorThickness];

// announcing sounding length
for (i = [0: (len(name) - 1)])
    echo(str("sounding length inside pipe ", name[i], " in mm: ", round(soundingLength[i])));

// flueLength warning    
for (i = [0: (len(name) -1)])
    if ((lengthFlue[i] + floorThickness) < (tubeInsert[i] + labiumWidth[i]/2/sqrt(2) + outCut[i]/sqrt(2)))
        echo(str("(lengthFlue[i] + floorThickness) is too short for pipe ", name[i])); 

flueloft_upper_inner_points = 
    [for (i = [0: (len(name) -1)])
        [for (j =[(270+labium_angle_45[i]*0.5) : (-labium_angle_45[i]/(flueSteps[i]-1)) : (270-labium_angle_45[i]*0.5)]) 
            concat(
                cos(j)*(outerDiameter[i]+flueWidth[i])/2 - (outCut[i]-0.1)/sqrt(2), 
                sin(j)*(outerDiameter[i]+flueWidth[i])/2, 
                -cos(j)*(outerDiameter[i]+flueWidth[i])/2 - (outCut[i]-0.1)/sqrt(2)
            ),
        for (j =[(270-labium_angle_45[i]*0.5) : (labium_angle_45[i]/(flueSteps[i]-1)) : (270+labium_angle_45[i]*0.5)]) 
            concat(
                cos(j)*(outerDiameter[i]-flueWidth[i])/2 - (outCut[i]-0.1)/sqrt(2), 
                sin(j)*(outerDiameter[i]-flueWidth[i])/2, 
                -cos(j)*(outerDiameter[i]-flueWidth[i])/2 - (outCut[i]-0.1)/sqrt(2)
            )
    ],
];
    
flueloft_lower_inner_points=
    [for (i = [0: (len(name) -1)])
        [for (j =[1 : (2*flueSteps[i])]) 
            concat(
            cos((360 * (0.5*j-0.25) / flueSteps[i]))*air_supply_diameter[i]/2 + airSupplyX[i], 
            -sin((360 * (0.5*j-0.25) / flueSteps[i]))*air_supply_diameter[i]/2 + airSupplyY[i], 
            ground[i]+tubeInsert[i]
        )],
    ];

// outer flue loft calculations

flueloft_upper_outer_points=
    [for (i = [0: (len(name) -1)])
        [for (j =[(270+labium_angle_45[i]*0.55) : (-labium_angle_45[i]*1.1/(flueSteps[i]-1)) : (270-labium_angle_45[i]*0.55)]) 
            concat(
                cos(j)*((outerDiameter[i]+flueWidth[i])/2+minWallThickness) - (outCut[i]-0.05)/sqrt(2), 
                sin(j)*((outerDiameter[i]+flueWidth[i])/2+minWallThickness), 
                -cos(j)*((outerDiameter[i]+flueWidth[i])/2+minWallThickness) - (outCut[i]-0.05)/sqrt(2)
            ),
        for (j =[(270-labium_angle_45[i]*0.55) : (labium_angle_45[i]*1.1/(flueSteps[i]-1)) : (270+labium_angle_45[i]*0.55)]) 
            concat(
                cos(j)*((outerDiameter[i]-flueWidth[i])/2-minWallThickness) - (outCut[i]-0.05)/sqrt(2), 
                sin(j)*((outerDiameter[i]-flueWidth[i])/2-minWallThickness), 
                -cos(j)*((outerDiameter[i]-flueWidth[i])/2-minWallThickness) - (outCut[i]-0.05)/sqrt(2)
            )
    ],
];        
        
   
flueloft_lower_outer_points=
    [for (i = [0: (len(name) -1)])
        [for (j =[1 : (2*flueSteps[i])]) 
            concat(
                cos((360 * (0.5*j-0.25) / flueSteps[i]))*(air_supply_diameter[i]+2*minWallThickness)/2 + airSupplyX[i], 
                -sin((360 * (0.5*j-0.25) / flueSteps[i]))*(air_supply_diameter[i]+2*minWallThickness)/2 + airSupplyY[i], 
                ground[i]+tubeInsert[i])
        ],
];
    
//  beard points
upper_beard_points=[for (i = [0 : (len(name) -1)])
    [for (k =[(270+labium_angle_45[i]*0.55) : (-labium_angle_45[i]*1.1/(flueSteps[i]-1)) : (270-labium_angle_45[i]*0.55)]) 
        concat(
            cos(k)*((outerDiameter[i]+flueWidth[i]+minWallThickness)/2), 
            sin(k)*((outerDiameter[i]+flueWidth[i]+minWallThickness)/2), 
            -cos(k)*((outerDiameter[i]+flueWidth[i]+minWallThickness)/2)
        ),
    for (k =[(270-labium_angle_45[i]*0.55) : (labium_angle_45[i]*1.1/(flueSteps[i]-1)) : (270+labium_angle_45[i]*0.55)]) 
        concat(
            cos(k)*outerDiameter[i]/4, 
            sin(k)*outerDiameter[i]/4, 
            -cos(k)*outerDiameter[i]/4
        )
    ],
];
    
lower_beard_points=[for (i = [0 : (len(name) -1)])
    [for (k =[(270+labium_angle_45[i]*0.55) : (-labium_angle_45[i]*1.1/(flueSteps[i]-1)) : (270-labium_angle_45[i]*0.55)]) 
        concat(
            cos(k)*((outerDiameter[i]+flueWidth[i])/2+minWallThickness) - outCut[i]/sqrt(2), 
            sin(k)*((outerDiameter[i]+flueWidth[i])/2+minWallThickness), 
            -cos(k)*((outerDiameter[i]+flueWidth[i])/2+minWallThickness) - outCut[i]/sqrt(2)
        ),
    for (k =[(270-labium_angle_45[i]*0.55) : (labium_angle_45[i]*1.1/(flueSteps[i]-1)) : (270+labium_angle_45[i]*0.55)]) 
        concat(
            cos(k)*outerDiameter[i]/4 - outCut[i]/sqrt(2), 
            sin(k)*outerDiameter[i]/4, 
            -cos(k)*outerDiameter[i]/4 - outCut[i]/sqrt(2)
        )
    ],
];
    
// elliptic loft filler
fill_upper_points =     [for (i = [0: (len(name) -1)])[flueloft_upper_outer_points[i][0] + [0.01, 0, 0.01],
    flueloft_upper_outer_points[i][round(flueSteps[i]/2)] + [0.01, 0, 0.01],
    (flueloft_upper_outer_points[i][flueSteps[i]-1] + [0.01, 0, 0.01]),
    [-outCut[i]/sqrt(2), 0, -outCut[i]/sqrt(2)] + [0.01, 0, 0.01]],];

fill_lower_points = [for (i = [0: (len(name) -1)]) [flueloft_lower_outer_points[i][0],
    flueloft_lower_outer_points[i][round(flueSteps[i]/2)],
    flueloft_lower_outer_points[i][flueSteps[i]-1],
    [-outCut[i], 0, ground[i] + tubeInsert[i]]],];
    
// labum cut points
    
labium_line=[for (i = [0 : (len(name) -1)])
    [for (j =[(270-labium_angle_45[i]*0.5) : (labium_angle_45[i]*1.1/flueSteps[i]) : (270+labium_angle_45[i]*0.6)]) 
        concat(
            cos(j)*outerDiameter[i]/2, 
            sin(j)*outerDiameter[i]/2, 
            -cos(j)*outerDiameter[i]/2)
    ],
];
    
lower_inner_labium_cut=[for (i = [0 : (len(name) -1)])
    [for (j =[(270-labium_angle_45[i]*0.5) : (labium_angle_45[i]*1.1/flueSteps[i]) : (270+labium_angle_45[i]*0.6)]) 
        concat(
            cos(j)*outerDiameter[i]/8 - outCut[i] / sqrt(2), 
            sin(j)*outerDiameter[i]/8, 
            -cos(j)*outerDiameter[i]/8 - outCut[i] / sqrt(2))
    ],
];

lower_outer_labium_cut=[for (i = [0 : (len(name) -1)])
    [for (j =[(270-labium_angle_45[i]*0.5) : (labium_angle_45[i]*1.1/flueSteps[i]) : (270+labium_angle_45[i]*0.6)]) 
        concat(
            cos(j)*outerDiameter[i]*7/8 - outCut[i] / sqrt(2), 
            sin(j)*outerDiameter[i]*7/8, 
            -cos(j)*outerDiameter[i]*7/8 - outCut[i] / sqrt(2))
    ],
];
    
upper_inner_labium_cut=[for (i = [0 : (len(name) -1)])
    [for (j =[(270-labium_angle_45[i]*0.5) : (labium_angle_45[i]*1.1/flueSteps[i]) : (270+labium_angle_45[i]*0.6)]) 
        concat(
            cos(j)*outerDiameter[i]/8 + outerDiameter[i]/2 - outCut[i] / sqrt(2), 
            sin(j)*outerDiameter[i]/8, 
            -cos(j)*outerDiameter[i]/8 + outerDiameter[i]/2 - outCut[i] / sqrt(2))
    ],
];
    
upper_outer_labium_cut=[for (i = [0 : (len(name) -1)])
    [for (j =[(270-labium_angle_45[i]*0.5) : (labium_angle_45[i]*1.1/flueSteps[i]) : (270+labium_angle_45[i]*0.6)]) 
        concat(
            cos(j)*outerDiameter[i]*7/8 + outerDiameter[i]/2 - outCut[i] / sqrt(2), 
            sin(j)*outerDiameter[i]*7/8, 
            -cos(j)*outerDiameter[i]*7/8 + outerDiameter[i]/2 - outCut[i] / sqrt(2))
    ],
];

labium_cut_points=
    [for (i = [0 : (len(name) -1)])
		[for (k = [0 : flueSteps[i] - 1])
            for (j = [0:4])
                if (j%5 == 0) lower_inner_labium_cut[i][k]
                else if (j%5 == 1) upper_inner_labium_cut[i][k]
                else if (j%5 == 2) labium_line[i][k]
                else if (j%5 == 3) upper_outer_labium_cut[i][k]
                else lower_outer_labium_cut[i][k]
        ],
	];
                
labium_cut_faces=[for (i = [0 : (len(name) -1)])
    [                     // Copying from loft module
        [for (k= [0 : 4]) k], // Upper plane
        for (k = [0 : flueSteps[i] -2])
            for (j = [0 : 4]) // Towards lower points
                [5 * k + (j+1)%5, 
                5 * k + j, 
                5 * (k+1) + j],
        for (k = [1 : (flueSteps[i]-1)])
            for (j = [0 : 4]) // Towards upper points
                [5 * k + j, 
                5 * k + (j+1) % 5, 
                5 * (k-1) + (j+1) % 5],
        [for (k= [5 * (flueSteps[i]) -1  : -1 : 5 * (flueSteps[i]-1) ]) k], // Lower plane    
    ],
];

// logic
for (i = [0: len(name) - 1])
translate(placement[i])
translate ([-airSupplyX[i], -airSupplyY[i], lengthFlue[i]])
difference(){
    union(){
        translate ([0, 0, ground[i]]) union(){         // basic shape
            difference(){   
                cylinder(height[i], d=(outerDiameter[i] + 2* minWallThickness), $fn=(30+outerDiameter[i])); 
                union(){
                    translate ([0, 0, floorThickness]) 
                        cylinder(height[i], d=innerDiameter[i], center=false, $fn=(10+outerDiameter[i]));
                    translate ([0, 0, (height[i] - pipeInsert[i])]) 
                        cylinder(height[i], d=outerDiameter[i], center=false, $fn=(10+outerDiameter[i]));
                };
            };
        };; 
        union(){                                    // outer elliptic loft
            hull(){
                translate([airSupplyX[i], airSupplyY[i], ground[i]]) rotate([0, 0, 90/flueSteps[i]])
                    cylinder(h=0.1, d=(air_supply_diameter[i]+2*minWallThickness), center=true, $fn=(2*flueSteps[i]));
                translate([airSupplyX[i], airSupplyY[i], (ground[i] + tubeInsert[i])])rotate([0, 0, 90/flueSteps[i]])
                    cylinder(h=0.1, d=(air_supply_diameter[i]+2*minWallThickness), center=true, $fn=(2*flueSteps[i]));
            };
            loft(flueloft_upper_outer_points[i], flueloft_lower_outer_points[i], number_of_layers);
        };
        intersection(){                             // elliptic_loft_fill
            loft(fill_upper_points[i], fill_lower_points[i], number_of_layers);
            translate([0, 0, ground[i]])
                difference(){
                    cylinder(height[i], d=(2*outerDiameter[i])); 
                    translate([0, 0, -0.1])cylinder((height[i] + 0.2), d=(outerDiameter[i])); 
            }
        }  
        intersection(){                             // beard
            loft(upper_beard_points[i], lower_beard_points[i], number_of_layers); 
            translate([0, 0, ground[i]])
                difference(){
                    cylinder(height[i], d=(2*outerDiameter[i])); 
                    translate([0, 0, -0.1])cylinder((height[i] + 0.2), d=(outerDiameter[i])); 
                }
        } 
    };
    union(){
        union(){
            hull(){
                translate([airSupplyX[i], airSupplyY[i], ground[i] - 0.1]) 
                    cylinder(h=0.1, d=air_supply_diameter[i], center=true, $fn=flueSteps[i]);
                translate([airSupplyX[i], airSupplyY[i], (ground[i] + tubeInsert[i] + 0.1)])
                    cylinder(h=0.1, d=air_supply_diameter[i], center=true, $fn=flueSteps[i]);
            };
            loft(flueloft_upper_inner_points[i], flueloft_lower_inner_points[i], number_of_layers);
        }; 
        difference(){                               // elliptic labium cut
            polyhedron(
                points=labium_cut_points[i], 
                faces=labium_cut_faces[i]);
            difference(){
                translate([0, 0, -outerDiameter[i]])
                    cylinder(h=2*outerDiameter[i], d=outerDiameter[i], center=false, $fn=(30+outerDiameter[i]));
                union(){
                translate([-outerDiameter[i]/sqrt(2), 0, -outerDiameter[i]/sqrt(2)])
                    rotate ([0,45,0])                
                        cube ([outerDiameter[i]*2, outerDiameter[i]*2, outerDiameter[i]*2], center=true);
                rotate([0,45,0])
                    resize(newsize=[outerDiameter[i]*sqrt(2), outerDiameter[i], outerDiameter[i]/2]) 
                        sphere(r=10);
                };
            };
        };
    };
};

