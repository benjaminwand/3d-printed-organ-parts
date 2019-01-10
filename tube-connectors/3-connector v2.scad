// measurements of tubes that shall be connected, tube 1 is largest

outside1=11;
inside1=8;
outside2=11;
inside2=8;
outside3=11;
inside3=8;

difference()
{
union ()
{
translate ([0,0,outside1]) cylinder(h=4.9+outside1*0.2, r=outside1/2+2);
hull()
{
translate ([outside2/-2-1,0,-4.9-outside1*0.2]) cylinder(h=4.9+outside1*0.2, r=outside2/2+2);
translate ([outside3/2+1,0,-4.9-outside1*0.2]) cylinder(h=4.9+outside1*0.2, r=outside3/2+2);
}
hull()
{
translate ([0,0,outside1]) cylinder(h=0.1, r=outside1/2+2);
translate ([outside3/2+1,0,0]) cylinder(h=0.1, r=outside3/2+2);
translate ([outside2/-2-1,0,0]) cylinder(h=0.1, r=outside2/2+2);
}
}

union()
{
hull()
{
translate ([0,0,outside1]) cylinder(h=0.1, r=inside1/2);
translate ([outside2/-2-1,0,0]) cylinder(h=0.1, r=inside2/2);
}

hull()
{
translate ([0,0,outside1]) cylinder(h=0.1, r=inside1/2);
translate ([outside3/2+1,0,0]) cylinder(h=0.1, r=inside3/2);
}
translate ([0,0,outside1]) cylinder(h=5+outside1*0.2, r=outside1/2);
translate ([outside2/-2-1,0,-5-outside1*0.2]) cylinder(h=5.1+outside1*0.2, r=outside2/2);
translate ([outside3/2+1,0,-5-outside1*0.2]) cylinder(h=5.1+outside1*0.2, r=outside3/2);
}
}