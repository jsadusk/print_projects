multiboard_cell_w = 25;

multipoint_slot_negative_file = "../components/Multipoint Slot - Negative.stl";
multipoint_h = 3.2;
multipoint_w = 22;
multipoint_l = 14;
default_multipoint_cell_spacing = 2;

module multipoint_slot() {
    import(multipoint_slot_negative_file);
}

module multipoint_slots(width, cell_spacing=default_multipoint_cell_spacing) {
    spacing = multiboard_cell_w * cell_spacing;
    num_multipoints = floor((width - multipoint_w) / spacing);
    span = spacing * num_multipoints;
    translate([-span / 2, 0, 0])
    for (i = [0 : 1 : num_multipoints]) {
        translate([i * spacing, 0, 0])
        multipoint_slot();
    }    
}