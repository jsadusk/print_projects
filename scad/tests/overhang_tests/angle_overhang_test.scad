angle = 75;
thickness = 6;
width = 20;
length = 150;

rotate([0, 0, 90]) {
translate([0, 0, 4])
difference(){
translate([0, -thickness * cos(angle), -thickness * sin(angle)])
rotate([angle, 0, 0])
cube(size=[width, thickness, length], center=false);
translate([-1, -length, -thickness])
    cube(size=[width + 2, length + thickness, thickness], center=false);
translate([-1, -length, length * cos(angle) - thickness * sin(angle)])
    cube(size=[width + 2, length + thickness, thickness], center=false);
}
translate([0, -width/2, 0])
cube(size=[width, width/2, 4], center=false);
}