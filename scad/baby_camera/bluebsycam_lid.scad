$fn = 100;

mb_w = 36;

sensor_d = 7.5;
lamp_d = 20;
lense_d = 17;

sensor_edge_to_mb_top = 1;
sensor_edge_to_mb_side = 10;

lamp_edge_to_mb_side = 5.6;
lamp_sensor_edge_to_mb_side = 8;

sensor_r = sensor_d / 2;
lamp_r = lamp_d / 2;
lense_r = lense_d / 2;

screw_hole_d = 3;
screw_stud_to_side = 2;
screw_stud_t = 1.6;
screw_stud_h = 6.5;

screw_stud_d = screw_hole_d + screw_stud_t * 2;
screw_stud_r = screw_stud_d / 2;
screw_hole_r = screw_hole_d / 2;
screw_stud_off = mb_w / 2 - screw_stud_r / 2 - screw_stud_to_side;
mounting_screw_off = 3;

lid_w = 73;
lid_l = 107;
lid_corner_r = 8;
lid_t = 3;
lid_tol = 0.5;

box_side_t = 3;
box_lip_t = 2;
box_h = 35;

box_l = lid_l + box_side_t * 2;
box_w = lid_w + box_side_t * 2;
box_corner_r = lid_corner_r + box_side_t;

slot_w = 26;
slot_h = 3.6;
slot_depth = box_w - box_side_t - box_lip_t;

box_bottom_t = 4.8;

rpi_l = 87;
rpi_w = 56;
rpi_screw_d = 2.6;
rpi_hole_l_off = 24.5;
rpi_hole_off = 2.3;
rpi_margin = -0.5;
rpi_screw_stud_h = 1;
rpi_screw_stud_t = 2;
rpi_power_off = 71.8;
rpi_power_w = 12;
rpi_power_h = 9;

rpi_screw_r = rpi_screw_d / 2;
rpi_hole_l_pos = box_l / 2 - box_side_t - box_lip_t - rpi_margin - rpi_hole_l_off;
rpi_hole_r_pos = box_l / 2 - box_side_t - box_lip_t - rpi_margin - rpi_l + rpi_hole_off;
rpi_hole_y_pos = rpi_w / 2 - rpi_hole_off;

temp_sensor_w = 22;
temp_sensor_h = 15;
temp_sensor_pin_w = 3;
temp_sensor_pin_h = 11;

usb_w = 15;
usb_h = 18.6;
ether_w = 16;
ether_h = 15.3;
usb_usb_gap = 3;
usb_ether_gap = 3.1;
usb_side_gap = 1.4;
ether_side_gap = 1.7;

usb_off = rpi_w / 2 - usb_side_gap;
/*difference(){
    square(size=[mb_w, mb_w], center=true);
    square(size=[mb_w - 0.001, mb_w - 0.001], center=true);
}*/

module lamp_assembly_pattern() {
    //lamp
    translate([mb_w / 2 + lamp_edge_to_mb_side + lamp_r, 0])
    circle(r=lamp_r);

    //lamp sensor
    lamp_sensor_x_off = mb_w / 2 + sensor_r;
    lamp_sensor_y_off = mb_w / 2 -      
        lamp_sensor_edge_to_mb_side - sensor_r;
    translate([lamp_sensor_x_off, - 
        lamp_sensor_y_off])
    circle(r=sensor_r);
}

module lense_assembly_pattern() {
    //lense
    circle(r=lense_r);

    //lense sensor
    lense_sensor_y_off = mb_w / 2 +
        sensor_edge_to_mb_top - sensor_r;
    lense_sensor_x_off = mb_w / 2 - sensor_r -
        sensor_edge_to_mb_side;
    translate([lense_sensor_x_off,  
        lense_sensor_y_off])
    circle(r=sensor_r);
}

module lid_screw_pattern(radius, off=0) {
    translate([
        lid_l/2 - mounting_screw_off - radius,
        lid_w/2 - mounting_screw_off - radius])
    circle(r=radius + off);
    
    translate([
        -lid_l/2 + mounting_screw_off + radius,
        -lid_w/2 + mounting_screw_off + radius])
    circle(r=radius + off);
    
    translate([
        -lid_l/2 + mounting_screw_off + radius,
        lid_w/2 - mounting_screw_off - radius])
    circle(r=radius + off);
    
    translate([
        lid_l/2 - mounting_screw_off - radius,
        -lid_w/2 + mounting_screw_off + radius])
    circle(r=radius + off);
}

module hole_pattern() {
    mirror(v=[1,0,0]){
    lense_assembly_pattern();
    lamp_assembly_pattern();
    rotate([0, 0, 180])
    lamp_assembly_pattern();
    lid_screw_pattern(screw_hole_r);
    }
}

//hole_pattern();


module screw_stud_pattern() {
    translate([screw_stud_off, screw_stud_off])
    difference() {
        circle(r=screw_stud_r);
        circle(r=screw_hole_r);
    }
}

module screw_studs_pattern() {
    screw_stud_pattern();
    rotate([0, 0, 90])
    screw_stud_pattern();
     rotate([0, 0, -90])
    screw_stud_pattern();
     rotate([0, 0, 180])
    screw_stud_pattern();
}

module corner_pattern(radius) {
    translate([-radius, -radius])
    difference() {
        square(size=[radius + 0.1, radius + 0.1]);
        circle(r=radius);
    }
}

module rounded_rectangle(length, width, corner) {
    difference() {
        square(size=[length, width], center=true);
        translate([length/2, width/2])
        corner_pattern(corner);
        translate([-length/2, -width/2])
        rotate([0, 0, 180])
        corner_pattern(corner);
        translate([-length/2, width/2])
        rotate([0, 0, 90])
        corner_pattern(corner);
        translate([length/2, -width/2])
        rotate([0, 0, -90])
        corner_pattern(corner);
    }
}

module lid_pattern() {
    difference() {
        rounded_rectangle(lid_l, lid_w, lid_corner_r);
        hole_pattern();
    }
}

module lid_surface() {
    linear_extrude(height=lid_t) {
        lid_pattern();
    }
}

module studs() {
    translate([0, 0, -0.01])
    linear_extrude(height=screw_stud_h + 0.01) {
        screw_studs_pattern();
    }
}

module lid() {
    lid_surface();
    translate([0, 0, lid_t])
    studs();
}




module rpi_screw_pattern(radius, offset=0) {
    translate([rpi_hole_l_pos - rpi_screw_r, rpi_hole_y_pos - rpi_screw_r])
    circle(r=rpi_screw_r + offset);
    
    translate([rpi_hole_l_pos - rpi_screw_r, -rpi_hole_y_pos + rpi_screw_r])
    circle(r=rpi_screw_r + offset);
    
    translate([rpi_hole_r_pos, rpi_hole_y_pos - rpi_screw_r])
    circle(r=rpi_screw_r + offset);
    
    translate([rpi_hole_r_pos, -rpi_hole_y_pos + rpi_screw_r])
    circle(r=rpi_screw_r + offset);

}

module temp_sensor_holes() {
    translate([-box_l/2 - temp_sensor_w - screw_hole_r, 0, -1])
    cylinder(r=screw_hole_r, h=box_bottom_t + rpi_screw_stud_h + 2);
    
    translate([-box_l/2 - 1, -temp_sensor_pin_h/2, box_bottom_t + rpi_screw_stud_h])
    cube(size=[box_side_t + box_lip_t + 2, temp_sensor_pin_h, temp_sensor_pin_w]);
}


module slot() {
    translate([-slot_w / 2, -slot_depth / 2 - box_side_t - box_lip_t, (box_bottom_t - slot_h) / 2])
    cube(size=[slot_w, slot_depth + 1, slot_h]);
}

module io_plug_holes() {
    translate([box_l / 2 - box_side_t - box_lip_t - 1, rpi_w/2 - usb_side_gap - usb_w, box_bottom_t + rpi_screw_stud_h])
    cube(size=[box_side_t + box_lip_t + 2, usb_w, usb_h]);
    
    translate([box_l / 2 - box_side_t - box_lip_t - 1, rpi_w/2 - usb_side_gap - usb_w - usb_usb_gap - usb_w, box_bottom_t + rpi_screw_stud_h])
    cube(size=[box_side_t + box_lip_t + 2, usb_w, usb_h]);
    
    translate([box_l / 2 - box_side_t - box_lip_t - 1, rpi_w/2 - usb_side_gap - usb_w - usb_usb_gap - usb_w - usb_ether_gap - ether_w, box_bottom_t + rpi_screw_stud_h])
    cube(size=[box_side_t + box_lip_t + 2, ether_w, ether_h]);
}

module power_plug_hole() {
    translate([box_l / 2 - box_side_t - box_lip_t - rpi_margin - rpi_power_off - rpi_power_w, -box_w / 2 - 1, box_bottom_t + rpi_screw_stud_h])
    cube(size=[rpi_power_w, box_side_t + box_lip_t + 2, rpi_power_h]);
}

module temp_sensor_stick() {
    translate([-box_l / 2 - temp_sensor_w/2  - screw_hole_r, 0, 0])
    linear_extrude(height=box_bottom_t + rpi_screw_stud_h) {
        rounded_rectangle(temp_sensor_w + screw_hole_d + 2, temp_sensor_h, 2);
        translate([screw_hole_r, -temp_sensor_h/2])
        square(size=[temp_sensor_w/2, temp_sensor_h]);
    }
    
    
}

module box () {
    difference() {
    union() {
    difference() {
        linear_extrude(height=box_h)
        rounded_rectangle(box_l, box_w, box_corner_r);

        translate([0, 0, box_h - lid_t])
        linear_extrude(height=lid_t + lid_tol)
        rounded_rectangle(lid_l + lid_tol, lid_w+ 0.5, lid_corner_r);
        
        translate([0, 0, box_bottom_t])
        linear_extrude(height=box_h - box_bottom_t + 1)
        rounded_rectangle(lid_l - box_lip_t * 2, lid_w - box_lip_t * 2, lid_corner_r);
    }
    
    linear_extrude(height=box_h - lid_t)
        lid_screw_pattern(screw_hole_r, screw_stud_t);
    
    translate([0, 0, box_bottom_t - 0.01])
    linear_extrude(height=rpi_screw_stud_h + 0.1)
    rpi_screw_pattern(rpi_screw_r, rpi_screw_stud_t);
    
    temp_sensor_stick();
    }
    translate([0, 0, box_bottom_t])
    linear_extrude(height=box_h)
        lid_screw_pattern(screw_hole_r);
    
    translate([0, 0, -0.1])
    linear_extrude(height=rpi_screw_stud_h + box_bottom_t + 0.2)
    rpi_screw_pattern(rpi_screw_r);
    
    io_plug_holes();
    power_plug_hole();
    
    temp_sensor_holes();
    
    slot();
    }
}

/*translate([-lid_l/2 -1, 0, 0])
lid();*/

translate([/*box_l/2 + 1*/0, 0, 0])
box();