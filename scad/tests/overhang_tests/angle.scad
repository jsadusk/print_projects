a = 75;
difference(){
    translate([0, 0, -sin(a) * 10])
    rotate([a, 0, 0])
    cube(size=[10, 10, 50]);
    translate([-1, -49 + cos(a)*10, -sin(a)*10 - 1])
    cube(size=[12, 50, sin(a)*10+1]);
    translate([-1, -55 + cos(a)*10, sin(a)*10 -2])
    cube(size=[12, 50, sin(a)*10+1]);
}