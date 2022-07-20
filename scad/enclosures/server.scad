adapter_h = 22;
adapter_w = 13.8;
adapter_l = 72.5;
adapter_sata_t = 4;
adapter_sata_l = 40.5;
adapter_sata_h = 10;
adapter_sata_r_off = 20;
adapter_sata_l_off = adapter_l - adapter_sata_l - adapter_sata_r_off;
adapter_sata_front_off = 7.9;
adapter_sata_back_off = adapter_w - adapter_sata_front_off - adapter_sata_t;
adapter_usb_l = 13.6;
adapter_usb_t = 3.2;
adapter_usb_h = 6.5;
adapter_usb_r_off = 30.5;
adapter_usb_l_off = adapter_l - adapter_usb_l - adapter_usb_r_off;
adapter_usb_front_off = 5.4;
adapter_usb_back_off = adapter_w - adapter_usb_t - adapter_usb_front_off;

usb_outer_adapter_gap = 1;
usb_outer_h = 17;
usb_outer_l = 18;
usb_outer_w = 9.5;
usb_outer_l_off = adapter_usb_l_off - (usb_outer_l - adapter_usb_l) / 2;
usb_outer_front_off = adapter_usb_front_off - usb_outer_w / 2;
usb_cable_d = 7;
usb_cable_r = usb_cable_d / 2;

power_d = 6;
power_r = power_d / 2;
power_outer_d = 12;
power_outer_r = power_outer_d / 2;
power_outer_h = 19.4;
power_adapter_gap = 1;
adapter_power_r_off = 2.7;
adapter_power_l_off = adapter_l - adapter_power_r_off - power_r;
adapter_power_outer_l_off = adapter_power_l_off - (power_outer_r - power_r);
adapter_power_front_off = 4.2;
adapter_power_outer_front_off = adapter_power_front_off - (power_outer_r - power_r);

drive_l = 101.5;
drive_w = 26;
drive_h = 110;
adapter_drive_overhang = 1.5;
drive_adapter_gap = 1.4;

filament_w = 0.4;

wall_t = filament_w * 4;

base_h = power_outer_h + power_adapter_gap + adapter_h + drive_adapter_gap;
base_l = wall_t * 2 + adapter_drive_overhang + drive_l;
base_w = wall_t * 2 + adapter_drive_overhang + drive_w;

side_lip = 10;
screw_d = 3.2;
screw_r = screw_d / 2;
screw_front_off = 5;
screw_a_off = 26.8;
screw_b_off = 68.4;
screw_c_off = 128.3;

base_spacing = 5;

pcb_l = 83;
pcb_w = 59;
pcb_screw_off = 3.5;
pcb_screw_d = 2.5;
pcb_screw_r = pcb_screw_d / 2;
pcb_stud_r = pcb_screw_r + wall_t;
pcb_stud_d = pcb_stud_r * 2;
pcb_stud_l = base_spacing;

main_power_w = 13.2;
main_power_h = 15;
main_power_l = 34.4;
main_power_access_off = -3;
main_power_plug_d = 8.2;
main_power_plug_r = main_power_plug_d / 2;
main_power_lip_t = 3;
main_power_access_l = 14;
main_power_access_w = main_power_w + wall_t * 2 - main_power_lip_t;
main_power_access_h = main_power_h - wall_t * 2;

power_converter_upper_spacing = 53.8;
power_converter_lower_spacing = 38.8;
power_converter_upper_to_lower = 25.5;
power_converter_lower_off = 8;

$fn = 100;
module adapter_cutout() {
    translate([-1, base_w - wall_t - adapter_w, 0]){
        translate([0, 0,  base_h - drive_adapter_gap - adapter_h]) {
            cube(size=[adapter_l + wall_t + 1, adapter_w, adapter_h]);
            translate([-1, adapter_sata_front_off, adapter_h - 1])
            cube(size=[adapter_l - adapter_sata_r_off + 1, adapter_sata_t, adapter_sata_h + 1]);
        }
        usb_cutout();
        power_cutout();
    }
}

module usb_cutout() {
    translate([usb_outer_l_off, usb_outer_front_off, -1]){
        cube(size=[usb_outer_l, usb_outer_w, base_h - adapter_h - usb_outer_adapter_gap]);
        translate([(usb_outer_l - adapter_usb_l) / 2, (usb_outer_w - adapter_usb_t) / 2, usb_outer_h - 1])
        cube(size=[adapter_usb_l, adapter_usb_t, adapter_usb_h + 1]);
        translate([-usb_outer_l_off - 1, usb_outer_w / 2, 0]){
            translate([0, 0, base_h - adapter_h - usb_outer_h - usb_outer_adapter_gap + usb_cable_r])
            rotate([0, 90, 0])
            cylinder(r=usb_cable_r, h=usb_outer_l_off + 2);
            translate([0, -usb_cable_r, - 1])
            cube(size=[usb_outer_l_off + 2, usb_cable_d, base_h - adapter_h - usb_outer_h - usb_outer_adapter_gap + usb_cable_r + 1]);
        }
    }
}

module power_cutout() {
    translate([adapter_power_l_off, adapter_power_outer_front_off + power_outer_r, -1]) {
        cylinder(r=power_outer_r, h=base_h - drive_adapter_gap - adapter_h + 1 - power_adapter_gap);
        cylinder(r=power_r, h = base_h - drive_adapter_gap - adapter_h + 2);
        translate([0, 0, base_h - drive_adapter_gap - adapter_h - power_outer_h + power_outer_r]) {
            rotate([0, 90, 0])
            cylinder(r=power_outer_r, h=adapter_l);
            translate([0, -power_outer_r, -power_outer_d])
            cube(size=[adapter_l, power_outer_d, power_outer_d + 1]);
        }
    } 
}

module base() {
    difference() {
        union() {
            cube(size=[base_l, base_w, base_h]);
            translate([0, 0, base_h]) {
                sides();
                braces();
            }
        }

        adapter_cutout();
    }
}

module test_base() {
    difference() {
        union() {
            cube(size=[base_l, base_w, base_h]);
            /*translate([0, 0, base_h]) {
                sides();
                braces();
            }*/
            power_converter_mount();
            //translate([base_l/2, 0, base_h + drive_h - pcb_l - pcb_stud_r])
        //pcb_mount();

        }

        adapter_cutout();
        main_power_cutout();
    }
}

module screw() {
    rotate([0, 90, 0])
    cylinder(r=screw_r, h=wall_t + 2);
}

module side() {
    difference() {
        cube(size=[side_lip + wall_t, drive_w + wall_t * 2, drive_h]);
        translate([wall_t, wall_t, -1])
        cube(size=[side_lip + wall_t, drive_w, drive_h + 2]);
        translate([-1, drive_w - screw_front_off, screw_r + screw_a_off])
        screw();
        translate([-1, drive_w - screw_front_off, screw_r + screw_b_off])
        screw();
        translate([-1, drive_w - screw_front_off, screw_r + screw_c_off])
        screw();
    }
}

module sides() {
    side();
    translate([base_l, 0, 0])
    mirror([1, 0, 0])
    side();
}

module brace() {
    intersection() {
        union() {
            angle = atan2(drive_l, drive_h);
            length = 1/cos(angle) * drive_h;
            lift = sin(angle) * side_lip;
            translate([0, 0, lift/2])
            rotate([0, angle, 0])
            cube(size=[side_lip, wall_t, length]);
            translate([drive_l, 0, -lift/2])
            rotate([0, -angle, 0])
            cube(size=[side_lip, wall_t, length]);
            cube(size=[drive_l, wall_t, side_lip]);
            translate([0, 0, drive_h - side_lip])
            cube(size=[drive_l, wall_t, side_lip]);
        }
        cube(size=[drive_l, wall_t, drive_h]);
    }
}

module braces() {
    brace();
    translate([0, drive_w + wall_t, 0])
    brace();
}

//sides();
//braces();
module chasis() {
    translate([-drive_l / 2, 0, 0]){
        translate([0, base_spacing, 0])
        base();
        translate([0, -base_w, 0])
        difference() {
            base();
            main_power_cutout();
         }
        links();
        translate([base_l/2, -base_w, base_h + drive_h - pcb_l - pcb_stud_r])
        pcb_mount();
        translate([0, -base_w, 0])
        power_converter_mount();
    }
}

module links() {
    translate([0, -0.1, 0])
    cube(size=[side_lip, base_spacing + 0.2, side_lip]);
    translate([base_l - side_lip, -0.1, 0])
    cube(size=[side_lip, base_spacing + 0.2, side_lip]);
    translate([base_l - side_lip, -0.1 - adapter_drive_overhang, base_h + drive_h - side_lip])
    cube(size=[side_lip, base_spacing + adapter_drive_overhang + 0.2, side_lip]);
    translate([0, -0.1 - adapter_drive_overhang, base_h + drive_h - side_lip])
    cube(size=[side_lip, base_spacing + adapter_drive_overhang + 0.2, side_lip]);

}

module mount_stud() {
    rotate([90, 0, 0])
    difference() {
        cylinder(r=pcb_stud_r, h=base_spacing);
        translate([0, 0, -1])
        cylinder(r=pcb_screw_r, h=base_spacing + 2);
    }
}

module pcb_mount() {
    translate([-(pcb_w / 2 - pcb_screw_off), 0, pcb_screw_off])
    mount_stud();
    translate([pcb_w / 2 - pcb_screw_off, 0, pcb_screw_off])
    mount_stud();
    translate([-(pcb_w / 2 - pcb_screw_off), 0, pcb_l - pcb_screw_off])
    mount_stud();
    translate([pcb_w / 2 - pcb_screw_off, 0, pcb_l - pcb_screw_off])
    mount_stud();
    //translate([-(pcb_w /2), -wall_t, 0])
    //cube(size=[pcb_w, wall_t, pcb_l]);
}

module main_power_cutout() {
    translate([base_l - main_power_l - wall_t, wall_t, 0]){
        translate([0, 0, -1])
        cube(size=[main_power_l, main_power_w, main_power_h + 1]);
        translate([main_power_l - 1, main_power_w / 2, 0]) {
            translate([0, 0, main_power_h / 2])
            rotate([0, 90, 0])
            cylinder(r=main_power_plug_r, h=wall_t + 2);
            translate([0, -main_power_plug_d * 0.9 / 2, -1])
            cube(size=[wall_t + 2, main_power_plug_d * 0.9, main_power_plug_d * 0.9 + 1]);
        }
        translate([-main_power_access_l - main_power_access_off, -main_power_lip_t, wall_t]){
            cube([main_power_access_l, main_power_access_w, main_power_access_h]);
            translate([0, wall_t * 2, -wall_t - 1])
            cube([main_power_access_l, main_power_access_w - wall_t * 2, main_power_access_h + wall_t * 2+ 1]);
        }
        
    }
}

module power_converter_mount() {
    translate([pcb_stud_r, 0, power_converter_lower_off + power_converter_upper_to_lower])
    mount_stud();
    translate([pcb_stud_d + power_converter_upper_spacing, 0, power_converter_lower_off + power_converter_upper_to_lower])
    mount_stud();
    translate([pcb_stud_r + (power_converter_upper_spacing - power_converter_lower_spacing) / 2, 0, power_converter_lower_off])
    mount_stud();
    translate([pcb_stud_d + power_converter_upper_spacing - (power_converter_upper_spacing - power_converter_lower_spacing) / 2, 0, power_converter_lower_off])
    mount_stud();
}

chasis();
//test_base();