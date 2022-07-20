
translate([0, 0, 10 - 10*sqrt(2)/2])
difference() {
rotate([45, 0, 0])
cube(size=[10, 10, 10]);
translate([-1, -10, 10 * sqrt(2)/2 + 1])
cube(size=[12, 20, 10]);
}

translate([0, -10 * sqrt(2)/2 - 3, 0])
cube(size=[10, 3, 12]);
translate([0, -10*sqrt(2)/2 -1, 10])
cube(size=[10, 10*sqrt(2) + 1, 2]);