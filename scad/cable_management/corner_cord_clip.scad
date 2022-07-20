bend_d = 10;
arm_t = 1.6;
clip_w = 12.7;
fudge = 0.01;
clearance = 2;
side_len = bend_d * 2 - arm_t;

bend_r = bend_d / 2;
fillet_r = arm_t / 2;

module half_hollow() {
  difference() {
    cylinder(r=bend_r, h = clip_w, center=true, $fn = 50);
    cylinder(r=bend_r - arm_t, h = clip_w + fudge*2, center=true, $fn = 50);
    translate([0, -bend_r, 0])
      cube(size=[bend_d + fudge, bend_d, clip_w + fudge], center=true);
  }
}

module wave() {
  half_hollow();
  translate([bend_d - arm_t, 0, 0]) rotate([0, 0, 180]) half_hollow();
  translate([bend_d - arm_t + bend_r - fillet_r, 0, 0])
    cylinder(r=fillet_r, h=clip_w, center=true, $fn=50);
}

module ell_side(flip_fillet, flip_cut) {
  translate([0, 0, -clip_w/2]){
    cube(size=[arm_t, side_len, clip_w], center=false);
    difference() {
      translate([flip_fillet * arm_t, side_len, 0])
        cylinder(r=arm_t, h=clip_w, center=false, $fn=50);
      translate([arm_t * flip_cut, side_len - arm_t, 0])
        cube(size=[arm_t, arm_t *2, clip_w], center=false);
    }
  }
}

module corner(radius) {
  translate([radius, radius, -clip_w / 2])
  difference() {
    translate([-radius, -radius, 0])
      cube(size=[radius, radius, clip_w], center=false);
    cylinder(r=radius, h=clip_w, center=false, $fn=50);   
  }
}

module ell() {
  translate([-bend_r, -bend_r - clearance, 0]) {
   difference() {
    union() {
      ell_side(0, -1);
	    rotate([0, 0, -90]) ell_side(1, 1);
      translate([arm_t, 0, 0])
        corner(arm_t);
    }
   translate([0, -arm_t, 0])
   corner(arm_t * 2);
   }
  }
}




wave();
ell();