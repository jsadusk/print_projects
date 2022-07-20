include <components/rpi_utils.scad>
include <components/keystone.scad>

$fn = 50;

screw_d = 4.5;
screw_outer = 2;
screw_r = screw_d / 2;
screw_outer_r = screw_r + screw_outer;
screw_outer_d = screw_outer_r * 2;
screw_tab_off = 5;
screw_tab_t = rpi_plate_t;



module mounting_screw_tab() {
    translate([-screw_r - screw_tab_off, 0, 0])
    difference() {
        union() {
            cylinder(r=screw_outer_r, h=screw_tab_t);
            translate([0, -screw_outer_r, 0])
            cube([screw_outer_r + screw_tab_off, screw_outer_d, screw_tab_t]);
        }
        translate([0, 0, -1])
        cylinder(r=screw_r, h=screw_tab_t + 2);
    }
}

module door_controller_rpi_mount() {
    rpi_mounting_plate();
    translate([0, rpi_w / 2, 0])
    mounting_screw_tab();
    translate([rpi_l + 2, rpi_w / 2, 0])
    rotate([0, 0, 180])
    mounting_screw_tab();
    translate([rpi_l - keystone_h + 2, rpi_w + 2, rpi_plate_t - 1])
    rotate([90,0, 90])
    keystone_box(1);
    translate([rpi_l - keystone_h + 2, rpi_w, 0])
    cube([keystone_h, keystone_outer_l + 5, rpi_plate_t]);
}
    
translate([-rpi_l / 2, -rpi_w / 2 - keystone_l / 2, 0])
door_controller_rpi_mount();