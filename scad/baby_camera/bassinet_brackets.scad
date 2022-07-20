$fn = 100;

dresser_w = 528;
bassinet_w = 381;

dresser_lip_d = 21;
bassinet_rod_d = 16.5;
dresser_back_l = 30;

dresser_lip_r = dresser_lip_d / 2;
bassinet_rod_r = bassinet_rod_d / 2;

filament_t = 0.4;
shells = 2;

wall_t = filament_t * shells * 2;

bracket_l = (dresser_w - bassinet_w) / 2;
bracket_w = 30;

rod_clip_ratio = 0.7;
dresser_clip_ratio = 0.4;

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

module bassinet_rod_clip() {
    translate([bassinet_rod_r + wall_t, 0]) {
        partial_ring(bassinet_rod_r, wall_t, rod_clip_ratio, rod_clip_ratio);
        translate([-bassinet_rod_r, 0])
        square(size=[bassinet_rod_r, wall_t]);
    }
}

module dresser_front_clip() {
    translate([-dresser_lip_r - wall_t, -dresser_lip_r])
    rotate([0, 0, -90])
    partial_ring(dresser_lip_r, wall_t, 0.5, dresser_clip_ratio);
}
module front_bracket_pattern() {
    translate([-bracket_l / 2, 0]) {
        square(size=[bracket_l + 2, wall_t]);
        dresser_front_clip();
    }
    translate([bracket_l / 2, 0])
    bassinet_rod_clip();
}

module back_bracket_pattern() {
    translate([-bracket_l / 2, 0]) {
        square(size=[bracket_l + 2, wall_t]);
        translate([0, -dresser_lip_d - wall_t - 1])
        square(size=[wall_t, dresser_lip_d + wall_t + 2]);
        translate([0, -dresser_lip_d - wall_t - 2])
        square(size=[wall_t * 2, wall_t]);
    }
    translate([bracket_l / 2, 0])
    bassinet_rod_clip();
}

module front_bracket() {
    linear_extrude(height=bracket_w)
    front_bracket_pattern();
}

module back_bracket() {
    linear_extrude(height=bracket_w)
    back_bracket_pattern();
}

translate([dresser_lip_r + wall_t * 2 + 2, -bassinet_clip_h - 1]) {
    front_bracket();
    translate([dresser_lip_r + wall_t * 2 + 1, -bassinet_clip_h - 1])
    front_bracket();
}

back_bracket();
translate([-wall_t - 2, bassinet_clip_h + wall_t + 1])
back_bracket();