$fn = 100;

camera_l = 102;
camera_w = 58;
camera_h = 23;
camera_a = 10;

wall_t = 0.8;

lense_d = 48;
lense_r = lense_d / 2;
lense_top_off = 14;

cable_t = 1.7;
clip_w = 7;
screw_d = 5;
screw_r = screw_d / 2;

mount_t = 1.6;
mount_h = camera_h * 2;

module cradle_box() {
    difference() {
        cube([camera_l + wall_t * 2, camera_w + wall_t * 2, camera_h + wall_t]);
        translate([wall_t, wall_t, wall_t])
        cube([camera_l, camera_w, camera_h + 1]);
    }
}

module lense_cutout() {
    translate([0, 0, -wall_t])
    cylinder(r=lense_r, h = wall_t * 3);
}
    
module cradle_w_lense() {
    difference() {
        cradle_box();
        translate([camera_l - lense_top_off - lense_r, camera_w / 2 + wall_t, 0])
        lense_cutout();
    }
}

module cradle() {
    shift = (camera_h + wall_t) * sin(camera_a);
    difference() {
    translate([shift, 0, 0])
    rotate([0, -camera_a, 0])
    translate([0, 0, wall_t])
    union() {
        translate([-shift, 0,  0])
        cube([shift, camera_w + wall_t * 2, camera_h + wall_t]);
        cradle_w_lense();
    }
    
    translate([-shift * 2, -1, 1])
    cube([shift * 2, camera_w * 2, camera_h * 2]);
}
}

module mount() {
    difference() {
        cube([mount_t + wall_t, camera_w + wall_t * 2, mount_h]);
        translate([-mount_t + 1, screw_d * 1.5, mount_h - screw_d * 1.5])
        rotate([0, 90, 0])
        cylinder(r=screw_r, h=mount_t + 2);
        translate([-mount_t + 1, camera_w + wall_t * 2 - screw_d * 1.5, mount_h - screw_d * 1.5])
        rotate([0, 90, 0])
        cylinder(r=screw_r, h=mount_t + 2);
    }
}

module clip() {
    translate([0, -wall_t - cable_t, 0])
    cube([clip_w, wall_t, clip_w]);
    translate([clip_w - wall_t, -wall_t * 3, 0])
    cube([wall_t, wall_t * 2 + cable_t, clip_w]);
}
translate([-camera_l / 2, 0, 0])
difference() {
rotate([0, camera_a, 0]) {
cradle();
translate([-mount_t, 0, 0])
mount();
translate([0, 0, clip_w])
clip();
}
translate([-1000, -1000, -1000])
cube([2000, 2000, 1000]);
}