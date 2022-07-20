angle = 82;
thickness = 5;
width = 20;
length = 60;

difference(){
translate([0, 0, -thickness * sin(angle)])
rotate([angle, 0, 0])
cube(size=[width, thickness, length], center=false);
translate([-1, -length, -thickness])
    cube(size=[width + 2, length + thickness, thickness], center=false);
translate([-1, -length, length * cos(angle) - thickness * sin(angle)])
    cube(size=[width + 2, length + thickness, thickness], center=false);
}