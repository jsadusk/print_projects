filament_w = 0.4;
overhang = 0.90;
support_h = 5;
outset = filament_w * overhang;
overlap = filament_w - outset;

translate([0, 0, 10])
cube(size=[20, 20, 10], center=true);

module shell(side) {
 translate([0, 0, support_h / 2])
 difference() {
  cube(size=[side, side, support_h], center=true);
  cube(size=[side - filament_w * 2, side - filament_w * 2, support_h + 1], center=true);
 }
}

shell(20 + filament_w * overhang * 2);
shell(20 - filament_w * 2 - filament_w * overhang * 2);


translate([0, 0, support_h / 2])
difference() {
cube(size=[20 + outset, 20 + outset, support_h], center=true);
cube(size=[20 - overlap, 20 - overlap, support_h], center=true);
}
translate([0, 0, support_h / 2])
difference() {
cube(size=[20 - filament_w * 2 - outset, 
	       20 - filament_w * 2 - outset, support_h], 
     center=true);
cube(size=[20 - filament_w - filament_w * 2 - overlap, 
           20 - filament_w - filament_w * 2- overlap, support_h], 
     center=true);
}
