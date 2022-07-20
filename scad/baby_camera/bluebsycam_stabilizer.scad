slot_w = 26;
slot_h = 3.6;

height = 30;
wing_l = slot_w * 2;
filament_w = 0.4;
wall_t = filament_w * 4;
width = slot_h + wall_t * 2;
length = wing_l * 2 + slot_w;

translate([-length/2, -width/2, 0])
difference() {
    cube(size=[length, width, height]);
    translate([wing_l, wall_t, -1])
    cube(size=[slot_w, slot_h, height + 2]);
}