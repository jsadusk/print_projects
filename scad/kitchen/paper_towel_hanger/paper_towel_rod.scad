use <threads.scad>

fil_w = 0.4;
rod_d = 27;
rod_r = rod_d / 2;
wall_t = fil_w * 4;
inner_r = rod_r - wall_t;
inner_d = inner_r * 2;
rod_l = 98;
thread_p = 3;
thread_l = thread_p * 3;
thread_inner_r = inner_r - thread_p - wall_t;
cap_r = rod_r + 10;
cap_h = thread_l + wall_t * 2;

module hollow_rod() {
  difference() {
    cylinder(r=rod_r, h=rod_l);
    translate([0, 0, -1])
      cylinder(r=inner_r, h=rod_l + 2);
  }
}

module inner_thread() {
  metric_thread(diameter=inner_d, pitch=thread_p, length=thread_l + 2, internal=true);
}

module outer_thread() {
  metric_thread(diameter=(inner_d - inner_d * 0.05), pitch=thread_p, length=thread_l + 0.1, internal=false);
}

module rod_segment() {
hollow_rod();
translate([0, 0, wall_t])
difference() {
  cylinder(r=rod_r, h=thread_l);
  translate([0, 0, -1])
    inner_thread();
}

translate([0, 0, rod_l - wall_t - (inner_r -thread_inner_r)])
difference() {
 union() {
  translate([0, 0, wall_t * 2 - 0.1 + (inner_r - thread_inner_r)])
  outer_thread();
  cylinder(r=(inner_r - inner_r * 0.05), h=wall_t * 2 + (inner_r - thread_inner_r));
  cylinder(r=inner_r + 0.1, h=inner_r - thread_inner_r + wall_t);
 }
 translate([0, 0, -1])
 cylinder(r=thread_inner_r, h=thread_l + wall_t * 2 + 2 + (inner_r - thread_inner_r));
 translate([0, 0, 0])
 cylinder(r1=inner_r, r2=thread_inner_r, h = (inner_r - thread_inner_r) );
}
}

module cap() {
 cylinder(r=cap_r, h=cap_h);
}

module inner_thread_cap() {
  difference() {
    cap();
    translate([0, 0, -1])
    cylinder(r=inner_r, h=cap_h + 2);
  }
  difference() {
    cylinder(r=rod_r, h=thread_l);
    translate([0, 0, wall_t])
      inner_thread();
  }
}

module outer_thread_cap() {
  difference() {
  union(){
  cap();
  translate([0, 0, cap_h - 1]) {
    cylinder(r=inner_r - inner_r *   0.05,
       h=wall_t + 1.1);
    translate([0, 0, wall_t + 1])
    outer_thread();
  }
  }
  translate([0, 0, wall_t])
  cylinder(r=thread_inner_r, h=cap_h + thread_l + wall_t + 1);
  }
}    
//rod_segment();
//inner_thread_cap();
outer_thread_cap();
/*
translate([0, 0, 30])
metric_thread (diameter=30, pitch=3, length=12);
cylinder(r=15, h=30);
*/