$fn=50;
handle_l = 50;
handle_t = 10;

guard_t = handle_t * 2;
guard_l = guard_t + handle_l;
curve_r = guard_t / 2;

overhang = 2;
bump = 1;


difference() {
  union() {
    rotate([0, 90, 0])
        cylinder(r=curve_r, h=handle_l);
    sphere(r=curve_r);
    translate([handle_l, 0, 0])
        sphere(r=curve_r);
  }
  translate([0, -handle_t / 2, -handle_t * 2 + overhang])
      cube([handle_l, handle_t, handle_t * 2]);
  translate([-curve_r, -curve_r, -guard_t - curve_r + 1.5])
      cube([guard_l, guard_t, guard_t]);
}

translate([handle_t + bump, handle_t / 2, -curve_r + overhang + 0.5])
sphere(r=bump);
translate([handle_t + bump, -handle_t / 2, -curve_r + overhang + 0.5])
sphere(r=bump);
translate([handle_l - handle_t - bump, handle_t / 2, -curve_r + overhang + 0.5])
sphere(r=bump);
translate([handle_l - handle_t - bump, -handle_t / 2, -curve_r + overhang + 0.5])
sphere(r=bump);
