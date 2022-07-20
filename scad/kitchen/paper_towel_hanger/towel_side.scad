magnet_d = 40;
magnet_r = magnet_d / 2;
base_t = 3;
magnet_gap = 1;

hole_d = 30;
hole_r = hole_d / 2;
rim_d = hole_d + 10;
rim_r = rim_d / 2;
insert_h = 5;
insert_t = 2;
insert_r = hole_r + insert_t;


module base() {
    hull(){
    cylinder(r=magnet_r, h=base_t);
    translate([magnet_d + magnet_gap, 0, 0])
    cylinder(r=magnet_r, h=base_t);
    }
}

module ring() {
    difference() {
        union() {
            cylinder(r=rim_r, h=base_t);
            cylinder(r=insert_r, h=insert_h + base_t);
        }
        translate([0, 0, -1])
        cylinder(r=hole_r, h=base_t + insert_h + 2);
    }
}

ring();