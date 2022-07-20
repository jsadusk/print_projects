include <MCAD/boxes.scad>

rpi_hole_w_spacing = 49;
rpi_hole_l_spacing = 58;
rpi_hole_d = 2.75;
rpi_stud_d = 6.2;
rpi_l = 85;
rpi_w = 56;
rpi_hole_corner_off = 3.5;
rpi_plate_t = 3;

rpi_hole_r = rpi_hole_d / 2;
rpi_stud_r = rpi_stud_d / 2;

module rpi_stud(height = 2) {
    difference() {
        cylinder(r=rpi_stud_r, h=height);
        translate([0, 0, -1])
        cylinder(r=rpi_hole_r, h=height + 2);
    }
}

module rpi_studs(height = 2) {
    rpi_stud(height);
    translate([rpi_hole_l_spacing, 0, 0])
    rpi_stud(height);
    translate([rpi_hole_l_spacing, rpi_hole_w_spacing, 0])
    rpi_stud(height);
    translate([0, rpi_hole_w_spacing, 0])
    rpi_stud(height);
}

module rpi_hole_blanks(height = 2) {
    cylinder(r=rpi_hole_r, h=height);
    translate([rpi_hole_l_spacing, 0, 0])
    cylinder(r=rpi_hole_r, h=height);
    translate([rpi_hole_l_spacing, rpi_hole_w_spacing, 0])
    cylinder(r=rpi_hole_r, h=height);
    translate([0, rpi_hole_w_spacing, 0])
    cylinder(r=rpi_hole_r, h=height);
}

module rpi_plate_blank(margin=1, thickness=rpi_plate_t, corner_r=2) {
    roundedCube([rpi_l + margin * 2, rpi_w + margin * 2, thickness], corner_r, true, false);
}

module rpi_mounting_plate(margin=1, thickness=rpi_plate_t, stud_height=2) {
    difference() {
        union() {
            rpi_plate_blank(margin, thickness);
            translate([rpi_hole_corner_off + margin, rpi_hole_corner_off + margin, 0])
            rpi_studs(height = stud_height + thickness);
        }
        translate([rpi_hole_corner_off + margin, rpi_hole_corner_off + margin, -1])
        rpi_hole_blanks(thickness + stud_height + 2);
    }
}

module rpi_mounting_blank_ventilated(margin=1, thickness=rpi_plate_t, stud_height=2, beam_w=4) {
    difference() {
        rpi_plate_blank(margin, thickness + 2);
        translate([rpi_hole_off + margin, rpi_hole_off + margin, -1])
        #cube([rpi_l - ((rpi_hole_off + margin) * 2), rpi_l - ((rpi_hole_off + margin) * 2), thickness + 2]);
    }
}

module rpi_mounting_plate_ventilated(margin=1, thickness=rpi_plate_t, stud_height=2, beam_w=4) {
    
}

rpi_mounting_blank_ventilated();