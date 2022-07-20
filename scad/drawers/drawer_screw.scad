include <threads.scad>;

$fn=200;
cap_t = 3;
cap_d = 16;
cap_r = cap_d / 2;
slot_l = 12;
slot_w = 2;
shaft_d = 6.5;
thread_d = 8;
thread_l = 8;
shaft_l = 11;
thread_spacing = 2.6;

shaft_r = shaft_d / 2;
thread_r = thread_d / 2;
track_r = thread_r - shaft_r;

translate([0,0,cap_t - 0.01]) {
metric_thread(diameter=thread_d-0.9, pitch=thread_spacing, thread_size=0.6, length=thread_l);
cylinder(r=shaft_r, h=shaft_l);
}
difference() {
    cylinder(r=cap_r, h = cap_t);
    translate([-slot_l/2, -slot_w/2, -1])
    cube(size=[slot_l, slot_w, cap_t/2 + 1]);
}