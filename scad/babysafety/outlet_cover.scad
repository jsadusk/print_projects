$fn=100;

filament_t = 0.4;
wall_t = filament_t * 2;

box_l = 125;
box_w = 80;
box_h = 53;
box_lip = 3;

cord_d = 10;
cord_r = cord_d / 2;
cord_off1 = 45;
cord_off2 = 37;

screw_d = 4;
screw_r = screw_d / 2;
screw_head_d = 9;
screw_head_r = screw_head_d / 2;

module box() {
    difference() {
        cube([box_l + wall_t * 2, box_w + wall_t * 2, box_h + wall_t]);
        translate([wall_t, wall_t, wall_t])
        cube([box_l, box_w, box_h + wall_t]);
    }
}

module cord_cut() {
    translate([0, box_w / 2 + wall_t, -wall_t])
    cylinder(r=cord_r, h=wall_t * 3);
    translate([-cord_r, -wall_t, -wall_t])
    cube([cord_d, box_w / 2 + wall_t * 2, box_h + wall_t * 3]);
}

module screw_tube() {
    difference() {
        cylinder(r=screw_head_r + wall_t, h=box_h - box_lip);
        translate([0, 0, -wall_t])
        cylinder(r=screw_head_r, h=box_h - box_lip);
        translate([0, 0, -1])
        cylinder(r=screw_r, h=box_h + 2);
    }
}

translate([-box_l/2, -box_w / 2, 0]) {
difference() {
    box();
    translate([cord_off2, 0, 0])
    cord_cut();
    translate([box_l + wall_t * 2 - cord_off1, 0, 0])
    cord_cut();
    translate([box_l / 2 + wall_t, box_w / 2 + wall_t, -wall_t])
    cylinder(r=screw_head_r, h=wall_t * 3);
}
translate([box_l / 2 + wall_t, box_w / 2 + wall_t, 0])
    screw_tube();
}