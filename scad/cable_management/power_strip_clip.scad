peg_h = 8;
peg_d = 6;
peg_bump_w = 3;
peg_bump_h = 3;
peg_r = peg_d / 2;
peg_spacing = 74.5;
clip_t = 2;
bar_w = 75.5;
bar_t = 19;
latch_t = 2;
latch_w = 8;
tol = 0.2;
$fn = 20;

module peg() {
    difference() {
        union() {
            cylinder(h = peg_h, r = peg_r);
            translate([0, -peg_bump_w, peg_h - peg_bump_h])
            cylinder(r=peg_r, h=peg_bump_h);
        }
        translate([-peg_r, 0, -1])
        cube([peg_d, peg_r, peg_h + 2]);
     }
}

module bar_latch() {
    translate([-peg_r, -clip_t / 2, -bar_t - clip_t * 4]){
    cube([peg_d, clip_t, bar_t + clip_t * 4]);
    difference() {
        cube([peg_d, latch_w + clip_t,  clip_t * 3]);
        translate([-1, latch_w - peg_d - tol, clip_t - tol])
        cube([peg_d + 2, peg_d + tol * 2, clip_t + tol * 2]);
    }
    }
}

module latch_clip() {
    translate([0, tol, 0]){
    cube([peg_d, bar_w - tol * 2, clip_t - tol]);
    cube([peg_d * 2, peg_d - tol * 2, clip_t - tol]);
    translate([0, bar_w - peg_d, 0])
    cube([peg_d * 2, peg_d - tol * 2, clip_t - tol]);
    }
}
translate([0, 0, peg_r])
rotate([0, 90, 0]) {
translate([0, -peg_spacing / 2, 0]){
translate([-peg_r, -0.1, 0])
cube([peg_d, peg_spacing, clip_t]);
peg();
translate([0, peg_spacing - 0.1, 0])
rotate([0, 0, 180])
peg();
}
    translate([0, bar_w / 2 + clip_t / 2, 0])
rotate([0, 0, 180])
    bar_latch();
translate([0, -(bar_w / 2 + clip_t / 2), 0])
    
    bar_latch();
}

translate([-bar_t * 2 - clip_t, -bar_w / 2, 0])
latch_clip();