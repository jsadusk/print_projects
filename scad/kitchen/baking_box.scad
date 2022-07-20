curve = 2;
box_side = 120;
wall_t = 2;
box_h = 40;
translate([-box_side / 2, -box_side / 2, curve])
difference() {
minkowski() {
cube(size = [box_side, box_side, box_h + curve]);
    sphere(r=curve, $fn=30);
}
translate([wall_t, wall_t, wall_t])
minkowski() {
cube(size = [box_side - wall_t * 2, box_side - wall_t * 2, box_h + curve]);
    sphere(r=curve, $fn=30);
}
#translate([-curve * 2, -curve * 2, box_h])
cube(size=[box_side * 2, box_side * 2, box_h * 2]);
}