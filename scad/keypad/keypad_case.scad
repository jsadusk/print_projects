use <MCAD/regular_shapes.scad>
include <components/keystone.scad>

$fn = 40;

bottom_wall_t = 3;
side_wall_t = 9.5;
top_bottom_wall_t = 5.5;
keypad_l = 102;
keypad_w = 88;
keypad_lip = 5;
corner_r = 3;
box_h = keystone_w + 4 + bottom_wall_t + keypad_lip;

screw_d = 4;
screw_r = screw_d / 2;
socket_d = 11;
socket_r = socket_d / 2;
screw_l_off = 19;
screw_w_off = 3.5;
screw_l = 15;
nut_t = 4;
m4_screw_d = 5;
m4_screw_r = m4_screw_d / 2;
mount_l_off = 15;
mount_w_off = 26;
m4_nut_t = 4;
m4_nut_s = 6.6;
m4_nut_r = m4_nut_s / 2 / cos(30);
m4_nut_d = m4_nut_r * 2;

module m4_nut() {
    linear_extrude(height=m4_nut_t + 1)
    hexagon(across_flats=m4_nut_s);
}

module mounting_blank() {
    translate([0, 0, bottom_wall_t / 2])
    m4_nut();
    translate([0, 0, -1])
    cylinder(h=bottom_wall_t + 1, r=m4_screw_r);
}

module mounting_outer() {
    linear_extrude(height=bottom_wall_t /2 + m4_nut_t)
    hexagon(across_flats=m4_nut_s + 3);
}

module corner_cut(r, h) {
    translate([r, r, -1])
    rotate([0, 0, 180])
    difference() {
        cube([r +1, r + 1, h + 2]);
        translate([0, 0, -1])
        cylinder(r=r, h=h+4);
    }
}

module box() {
    difference() {
    union() {
    difference() {
        cube([keypad_l, keypad_w, box_h]);
        corner_cut(corner_r, box_h);
        translate([keypad_l, 0, 0])
        rotate([0, 0, 90])
        corner_cut(corner_r, box_h);
        translate([keypad_l, keypad_w, 0])
        rotate([0, 0, 180])
        corner_cut(corner_r, box_h);
        translate([0, keypad_w, 0])
        rotate([0, 0, -90])
        corner_cut(corner_r, box_h);
        translate([top_bottom_wall_t, side_wall_t, bottom_wall_t])
        cube([keypad_l - top_bottom_wall_t * 2, keypad_w - side_wall_t * 2, box_h]);
        
        translate([screw_l_off, screw_w_off, -1]){
            cylinder(r=screw_r, h=box_h + 2);
            cylinder(r=socket_r, h= box_h - screw_l + nut_t + 1);
        }
        translate([keypad_l - screw_l_off, screw_w_off, -1]){
            cylinder(r=screw_r, h=box_h + 2);
            cylinder(r=socket_r, h= box_h - screw_l + nut_t + 1);
        }
        translate([screw_l_off, keypad_w - screw_w_off, -1]){
            cylinder(r=screw_r, h=box_h + 2);
            cylinder(r=socket_r, h= box_h - screw_l + nut_t + 1);
        }
        translate([keypad_l - screw_l_off, keypad_w - screw_w_off, -1]){
            cylinder(r=screw_r, h=box_h + 2);
            cylinder(r=socket_r, h= box_h - screw_l + nut_t + 1);
        }
        /*translate([wall_height - 0.1, (keypad_w - outer_width) / 2 , 0])
        rotate([0, -90, 0])
        keystone_blank();*/

    }
    translate([0, keypad_w / 2 - (keystone_outer_l + 3)/ 2 , bottom_wall_t])
    cube([keystone_h, keystone_outer_l + 3, keystone_w + 4]);
    
            translate([mount_l_off, mount_w_off, 0])
        mounting_outer();
        translate([keypad_l - mount_l_off, mount_w_off, 0])
        mounting_outer();
        translate([mount_l_off, keypad_w - mount_w_off, 0])
        mounting_outer();
        translate([keypad_l - mount_l_off, keypad_w - mount_w_off, 0])
        mounting_outer();

    }
    translate([keystone_h, keypad_w / 2 + keystone_l / 2 + 3, bottom_wall_t + 2])
        rotate([90, 0, 270])
        keystone_blank();
            translate([mount_l_off, mount_w_off, 0])
        mounting_blank();
        translate([keypad_l - mount_l_off, mount_w_off, 0])
        mounting_blank();
        translate([mount_l_off, keypad_w - mount_w_off, 0])
        mounting_blank();
        translate([keypad_l - mount_l_off, keypad_w - mount_w_off, 0])
        mounting_blank();
}
    /*difference() {
        translate([wall_height, (keypad_w - outer_width) / 2, -wall_thickness])
        rotate([0, -90, 0])
        keystone();
        translate([-1, -1, -wall_thickness * 2])
        cube([keypad_l + 2, keypad_w + 2, wall_thickness * 2]);
        translate([-1, -1, box_h])
        cube([keypad_l + 2, keypad_w + 2, wall_thickness * 2]);*/
        
    //}
}

translate([-keypad_l / 2, -keypad_w / 2, 0])
box();
//corner_cut(3, 10);
//keystone_blank();
