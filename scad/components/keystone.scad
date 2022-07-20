keystone_lip_t = 3.5;
keystone_l = 16;
keystone_w = 14.8;
keystone_tab_l = 2;
keystone_bottom_gap_depth = 2;
keystone_tab_t = 2;
keystone_h = 10;
keystone_gap = keystone_h - keystone_tab_t * 2;
keystone_top_extra = 2;
keystone_outer_l = keystone_tab_t * 2 + keystone_l + keystone_top_extra;

module keystone_blank() {
    translate([keystone_bottom_gap_depth, 0, -1])
    cube([keystone_l, keystone_w, keystone_h + 2]);
    translate([0, 0, keystone_tab_t])//
    cube([keystone_bottom_gap_depth + 1, keystone_w, keystone_gap]);
    
    translate([keystone_l + keystone_bottom_gap_depth, 0, -1])
    cube([keystone_top_extra + 1, keystone_w, keystone_h - keystone_tab_t + 1]);
    
    translate([keystone_l + keystone_bottom_gap_depth + keystone_top_extra, 0, keystone_tab_t])
    cube([keystone_tab_t + 1, keystone_w, keystone_gap]);
    
    translate([0, keystone_w, 0])
    rotate([90, 0, 0])
    linear_extrude(keystone_w)
    polygon([[0,0], [keystone_tab_t,keystone_tab_t], [keystone_tab_t + 1, keystone_tab_t], [keystone_tab_t + 1, -1], [0, -1], [0, 0]]);
    
    translate([keystone_l + keystone_tab_t + keystone_top_extra + 1, keystone_w, 0])
    rotate([90, 0, 0])
    linear_extrude(keystone_w)
    polygon([[-1, -1], [-1, keystone_tab_t], [0, keystone_tab_t], [keystone_tab_t, 0], [keystone_tab_t, -1], [-1, -1]]);
    
    translate([keystone_l + keystone_tab_t, keystone_w, keystone_gap + keystone_tab_t])
    rotate([90, 0, 0])
    linear_extrude(keystone_w)
    polygon([[-1, -1], [-1, keystone_tab_t], [0, keystone_tab_t], [keystone_tab_t, 0], [keystone_tab_t, -1], [-1, -1]]);
    
    
}

module keystone_box_blank(keystone_box_wall = 1) {
    cube([keystone_outer_l + keystone_box_wall * 2 + 1, keystone_w + keystone_box_wall * 2, keystone_h]);
}

module keystone_box(keystone_box_wall = 1) {
    difference() {
        keystone_box_blank(keystone_box_wall);
        translate([keystone_box_wall, keystone_box_wall, 0])
        keystone_blank();
    }
}

//keystone_box(2);
