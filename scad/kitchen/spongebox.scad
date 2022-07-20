$fn = 100;

ridge_l = 98;
ridge_h = 5;
foot_r = ridge_h + 2;
foot_d = foot_r * 2;
height = 50;
width = 100;
length = ridge_l + foot_d * 2;
thickness = 3;
hole_r = 3;
hole_d = hole_r * 2;
vent_w = 2;
outer_fillet = foot_r;
inner_fillet = outer_fillet - thickness;

module foot() {
    translate([foot_r, foot_r, foot_r])
    union() {
      difference() {
          sphere(r=foot_r);
          translate([-foot_r - 1, -foot_r - 1, 0.1])
          cube(size=[foot_d + 1, foot_d + 1, foot_d]);
      }
      cylinder(r=foot_r, h=thickness);
  }
}

module fillet(radius, length) {
    translate([0, 0, -0.1])
    difference() {
        translate([-0.1, -0.1, 0])
        cube(size=[radius + 0.1, radius+ 0.1, length + 0.2]);
        translate([radius, radius, -1])
        cylinder(r=radius, h=length + 2);
    }
}

module holes() {
    num_x = round(length / (hole_d + thickness)) - 1;
    margin_x = (length - (num_x * (hole_d + thickness) - thickness)) / 2 + thickness;
    
    num_y = round(width / (hole_d + thickness)) - 1;
    margin_y = (width - (num_y * (hole_d + thickness) - thickness)) / 2 + thickness;
    
    for (i = [0: num_x - 1]) {
        x = margin_x + i * (hole_d + thickness);
        for (j = [0: num_y - 1]) {
            y = margin_y + j * (hole_d + thickness);
            translate([x, y, -1])
            cylinder(r=hole_r, h = thickness + 2);
        }
    }
}

module vents(width) {
    num = round((width - outer_fillet) / (vent_w + thickness)) - 2;
    margin = ((width - outer_fillet) - (num * (vent_w + thickness))) / 2 + outer_fillet - thickness /2;
    
    for (i = [0: num - 1]) {
        x = margin + i * (vent_w + thickness);
        translate([x, -1, thickness * 2])
        cube(size=[vent_w, thickness + 2, height - thickness * 3]);
    }
}

module cage() {
    difference() {
        cube(size=[length, width, height]);
        translate([thickness, thickness, thickness])
        cube(size=[length - thickness * 2, width - thickness * 2, height]);
        fillet(outer_fillet, height);
        
        translate([length, 0, 0])
        rotate([0, 0, 90])
        fillet(outer_fillet, height);
        
        translate([0, width, 0])
        rotate([0, 0, -90])
        fillet(outer_fillet, height);
        
        translate([length, width, 0])
        rotate([0, 0, 180])
        fillet(outer_fillet, height);
        
        holes();
        
        vents(length);
        translate([0, width - thickness, 0])
        vents(length);
        translate([thickness, 0, 0])
        rotate([0, 0, 90])
        vents(width);
        translate([length, 0, 0])
        rotate([0, 0, 90])
        vents(width);
    }
    translate([thickness, thickness, 0])
    fillet(inner_fillet, height);
    
    translate([length- thickness, thickness, 0])
    rotate([0, 0, 90])
    fillet(inner_fillet, height);
    
    translate([thickness, width - thickness, 0])
    rotate([0, 0, -90])
    fillet(inner_fillet, height);
    
    translate([length - thickness, width - thickness, 0])
    rotate([0, 0, 180])
    fillet(inner_fillet, height);
}

translate([0, 0, foot_r])
cage();

foot();
translate([length - foot_d, 0, 0])
foot();
translate([0, width - foot_d, 0])
foot();
translate([length - foot_d, width - foot_d, 0])
foot();
