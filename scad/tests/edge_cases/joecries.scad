seed = 1;
x_range = 260;
y_range = 130;
z_range = 130;

n_pieces = 40;
rand_x = rands(0, x_range, n_pieces, seed);
rand_y = rands(0, y_range, n_pieces, seed + 1);
rand_z = rands(0, z_range, n_pieces, seed + 2);

translate([-130, -65, 0]) {
translate([0, 0, 10])
for(i = [0: n_pieces - 1]) {
    translate([rand_x[i], rand_y[i], rand_z[i]])
    diamond();
}
}

module diamond() {
    translate([0, 0, 10])
    cylinder(r1 = 10, r2 = 0, h = 10, $fn = 4);
    cylinder(r1 = 0, r2 = 10, h = 10, $fn = 4);
}