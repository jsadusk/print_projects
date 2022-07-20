shelly_d = 42.5;
shelly_r = shelly_d / 2;
shelly_h = 20;
shelly_cut = 8;
power_w = 30;
power_l = 66;
power_h = 20;
spacing = 5;
shell = 2;
terminal_l = 126;
terminal_w = 22;
terminal_h = 15;
usb_l = 46;
usb_w = 14;
usb_cut = 4;
usb_h = shelly_h;

switch_d = 20;
switch_r = switch_d / 2;
switch_outer_r = switch_r + shell;
switch_outer_d = switch_outer_r * 2;
switch_cut = 4;
box_h = shelly_h;
switch_h = 26;
switch_notch_w = 2.5;
switch_notch_t = 1;
screw_d = 4.5;
screw_r = screw_d / 2;

//box_inner_l = shelly_d * 2 + spacing + 3 + shell * 5 + power_w;
box_inner_l = terminal_l + spacing * 3;
//box_inner_w = shelly_d + spacing + terminal_w;
box_inner_w = power_w + shelly_d - shelly_cut + terminal_w + spacing * 5 + shell * 3;

box_outer_l = box_inner_l + shell * 2;
box_outer_w = box_inner_w + shell * 2;

module switch() {
    translate([switch_outer_r + shell, switch_outer_r + shell, 0])
    difference() {
        cylinder(r = switch_outer_r, h = switch_h);
        cylinder(r = switch_r, h = switch_h + 1);
        translate([-switch_cut / 2, -switch_d, 0])
        cube([switch_cut, switch_d * 2, switch_h - 1.5]);
        translate([-switch_r - switch_notch_t, -switch_notch_w / 2, 0])
        cube([switch_notch_t * 2, switch_notch_w, switch_h * 2]);
    }
}

module box() {
  difference() {
    cube([box_outer_l, box_outer_w, box_h]);
    translate([shell, shell, shell])
    cube([box_inner_l, box_inner_w, box_h]);
    
    translate([shell * 3 + spacing, -0.1, shell]) 
    cube([terminal_l - shell * 2, shell * 2, box_h]);
  }
}

module shelly() {
    difference() {
        cylinder(h=shelly_h, r=shelly_r + shell);
        translate([0, 0, shell])
        cylinder(h=shelly_h, r=shelly_r);
        
    translate([-shelly_d, -shelly_r - shell, 0])
        cube([shelly_d * 2, shelly_cut, shelly_h + 1]);
    }
}

module power() {
    difference() {
        translate([0, -shell, 0])
        cube([power_w + shell * 2, power_l + shell, power_h]);
        translate([shell, 0, 0])
        cube([power_w, power_l + 2, power_h + 1]);
        translate([shell * 2, -power_l, 0])
        cube([power_w - shell * 2, power_l * 2, power_h + 1]);
    }
}

module terminal() {
    difference() {
        cube([terminal_l + shell * 2 , terminal_w + shell * 2, terminal_h]);
        translate([shell, -1, 0])
        cube([terminal_l, terminal_w + shell + 1, terminal_h + 1]);
        translate([shell * 2, -1, 0])
        cube([terminal_l - shell * 2, terminal_w + shell * 4, terminal_h + 1]);
    }
}

module usb() {
    difference() {
        cube([usb_w + shell * 2, usb_l + shell * 2, usb_h]);
        translate([shell, shell, 0])
        cube([usb_w, usb_l, usb_h * 2]);
        translate([usb_w - shell, -1, 0])
        cube([usb_cut, usb_l * 2, usb_h * 2]); 
    }
}

module screw_tab() {
    difference() {
        union() {
            translate([spacing, screw_r + shell, 0])
            cylinder(r=screw_r + shell, shell);
            cube([spacing, screw_d + + shell * 2, shell]);
        }
        
        translate([spacing, shell + screw_r, -1])
        cylinder(r=screw_r, h = shell + 2);
    }
}

translate([-box_outer_l / 2, -box_outer_w / 2, 0]) {
box();
translate([shelly_r + shell + spacing, terminal_w + power_w + shelly_r + shell * 4 + spacing * 4.5 - shelly_cut, 0]){
    shelly();
    translate([shelly_d + spacing + shell, 0, 0])
    shelly();
}


translate([power_l, terminal_w + shell * 2 + spacing * 2, 0])
rotate([0, 0, 90])
power();

translate([shell + spacing, 0, 0])
terminal();

translate([box_inner_l - switch_outer_d - spacing * 3 - usb_w, box_inner_w / 2 - switch_r - spacing * 2, 0])
switch();

translate([box_inner_l - usb_w, (box_inner_w - usb_l) / 2 + spacing, 0])
usb();

translate([box_outer_l, box_outer_w / 2 - screw_r - shell, 0])
screw_tab();

translate([0, box_outer_w / 2 + screw_r + shell, 0])
rotate([0, 0, 180])
screw_tab();
}

