use <MCAD/regular_shapes.scad>

diag_bar_w = 8;
horiz_bar_w = 15;



module keypad_bracket(bar_w) {
    $fn=50;
    bar_d = 15;
    filament_w = 0.4;
    bracket_w = 15;
    nut_t = 3.2;
    nut_s = 7;
    nut_r = nut_s / 2 / cos(30);
    nut_d = nut_r * 2;
    wall_t = nut_t * 2;
    outer_w = bar_d + filament_w * 2;
    outer_l = bar_w + wall_t * 2;
    screw_d = 3.5;
    screw_r = screw_d / 2;
    
    translate([-outer_l/2, -outer_w/2, 0])
    difference() {
        cube([outer_l, outer_w, bracket_w]);
        translate([wall_t, -1, -1])
        cube([bar_w, bar_d + 1, bracket_w + 2]);
        
        translate([wall_t - nut_t, nut_s / 2 + (bar_d - nut_s)/2 , nut_r + (bracket_w - nut_d)/2])
        rotate([90, 90, 90])
        linear_extrude(height=nut_t + 1)
        hexagon(across_flats=nut_s);
        
        translate([-1, screw_r + (bar_d - screw_d)/2, screw_r + (bracket_w - screw_d)/2])
        rotate([0, 90, 0])
        cylinder(h=wall_t + 1, r=screw_r);
    }
}


keypad_bracket(horiz_bar_w);

//

