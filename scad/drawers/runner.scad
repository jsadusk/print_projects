$fn=100;

include <threads.scad>;

// measurements

//runner
width = 16;
length = 200;
thickness = 2;
depth = 8;

//peg
peg_d = 8;
peg_l = 8;
peg_flat = 0.1;
peg_1_2_off = 56.2;
peg_2_3_off = 88.2;
peg_tolerance = 0.2;

//screw
cap_t = 3;
cap_d = 16;
slot_l = 12;
slot_w = 2;
shaft_d = 7;
thread_d = 8.5;
thread_l = 8;
shaft_l = 11;
thread_spacing = 2.6;

//derived
peg_r = peg_d/2;
head_d = peg_d*2;
head_r = head_d/2;
head_t = thickness/2;
peg_1_off = (length - (peg_1_2_off + peg_2_3_off + peg_d * 3))/2;
cap_r = cap_d / 2;
shaft_r = shaft_d / 2;
thread_r = thread_d / 2;
track_r = thread_r - shaft_r;

module screw() {
    translate([0,0,cap_t - 0.01]) {
    metric_thread(diameter=thread_d, pitch=thread_spacing, thread_size=thread_d - shaft_d, length=thread_l);
    cylinder(r=shaft_r, h=shaft_l);
}
    difference() {
        cylinder(r=cap_r, h = cap_t);
        translate([-slot_l/2, -slot_w/2, -1])
        cube(size=[slot_l, slot_w, cap_t/2 + 1]);
    }
}

module peg(tolerance=0) {
    difference() {
        translate([0, 0, peg_r - peg_flat])
        rotate([0, 90, 0]){
            cylinder(r=peg_r + tolerance, h=peg_l + thickness/2 + tolerance);
            cylinder(r=head_r + tolerance, h=head_t + tolerance/2);
        }
        
        translate([-1, -head_r, -head_r - tolerance])
        cube(size=[peg_l + 2, head_d, head_r]);
        translate([-1, -head_r, peg_d-(peg_flat*2) + tolerance])
        cube(size=[peg_l + 2, head_d, head_r]);
    }
}

module bar(length, width, depth) {
    translate([width/2, 0, 0]) {
        cylinder(r=width/2, h=depth);
        translate([length-width, 0, 0])
        cylinder(r=width/2, h=depth);
        translate([0, -width/2, 0])
        cube(size=[length-width, width, depth]);
    }
}

module runner() {
    difference() {
        bar(length, width, depth);
        translate([thickness, 0, thickness])
        bar(length-(thickness*2), width-(        thickness*2), depth);
        translate([peg_1_off + peg_r, -(peg_r-peg_flat), thickness+0.01])
        rotate([0, 90, 90])
        peg(peg_tolerance);
        translate([peg_1_off + peg_1_2_off + peg_d + peg_r, -(peg_r-peg_flat), thickness+0.01])
        rotate([0, 90, 90])
        peg(peg_tolerance);
        translate([peg_1_off + peg_d + peg_1_2_off + peg_d + peg_2_3_off + peg_r, -(peg_r - peg_flat), thickness + 0.01])
        rotate([0, 90, 90])
        peg(peg_tolerance);
    }
}
num = 1;

translate([-length/2, -width * num / 2 + width + cap_d / 2, 0]) {
for (i=[0:num - 1]) {
    translate([0, width*i + i, 0])
    runner();
}

translate([peg_l, -width-1, 0]) {
    for (i=[0:num * 3 -1])
    translate([peg_l*i + thickness*i, 0, 0])
    peg();
}

for(i=[0:num*2 * 6-1]){
    translate([cap_r + cap_d*i + i, -width-peg_d*2-2, 0])
    screw();
}
}