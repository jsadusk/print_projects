$fn = 100;
bassinet_rod_d = 16.5;


bassinet_rod_r = bassinet_rod_d / 2;

filament_t = 0.4;
shells = 2;

wall_t = filament_t * shells * 2;

clip_w = 30;

rod_clip_ratio = 0.7;

rod_angle = 11;
clip_center_spacing = 30;

slot_w = 27;
slot_h = 3.6;
slot_l = 35;

bassinet_clip_h = bassinet_rod_d * rod_clip_ratio;
module partial_ring(radius, thickness, left_ratio, right_ratio) {
    diameter = radius * 2;
    translate([0, radius + thickness])
    difference() {
        circle(r=radius + thickness);
        circle(r=radius);
        
        translate([-1, -radius + (diameter)*right_ratio])
        square(size=[radius + thickness + 2, diameter + thickness + 1]);
        translate([-radius - thickness - 1, -radius + (diameter)*left_ratio])
        square(size=[radius + thickness + 2, diameter + thickness + 1]);
        
    }
}

module bassinet_rod_clip_pattern() {
    translate([bassinet_rod_r + wall_t, 0]) {
        partial_ring(bassinet_rod_r, wall_t, rod_clip_ratio, rod_clip_ratio);
        translate([-bassinet_rod_r - wall_t, 0])
        square(size=[bassinet_rod_r + wall_t, wall_t]);
    }
}

module bassinet_rod_clip() {
    rotate([0, 0, rod_angle/2])
    translate([-clip_center_spacing, 0, 0]) {
        rotate([90, 0, -90])
        linear_extrude(height=clip_w)
        bassinet_rod_clip_pattern();
        translate([-1, -bassinet_rod_r - wall_t, 0])
        cube(size=[clip_center_spacing + 1, bassinet_rod_r + wall_t, wall_t]);
    }
}

module rod_clips() {
    bassinet_rod_clip();
    
    mirror([1, 0, 0])
    bassinet_rod_clip();
}

module slot_housing() {
    translate([-slot_w / 2, -3.5, 0]) 
    difference() {
        union() {
            cube(size=[slot_w + wall_t * 2, slot_l + wall_t, wall_t * 2 + slot_h]);
            translate([slot_w/2 + 5, slot_l - 11, 0])
            rotate([0, 0, -40])
            cube(size=[sqrt(slot_l * slot_l + (clip_center_spacing + clip_w) * (clip_center_spacing + clip_w)), bassinet_rod_d, wall_t]);
        }
        translate([wall_t, wall_t, wall_t])
        cube(size=[slot_w, slot_l + 1, slot_h]);
    }
}

module bracket() {
    rod_clips();
    slot_housing();
}

bracket();