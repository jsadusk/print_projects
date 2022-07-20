
angle = 64;
difference() {
translate([0, 0, -sin(angle) * 10])
rotate([0, -(90-angle), 0])
cube(size=[80, 10, 10]);
    translate([-5, -1, -10])
    cube(size=[80, 12, 10]);

translate([0, -1, sin(90-angle) * 80 - sin(angle) * 10])
    cube(size=[80, 12, 10]);


translate([-sin(90 - angle) * 10 + tan(angle) * 10, 0, 10])
cube(size=[.1, 10, 20]);
}