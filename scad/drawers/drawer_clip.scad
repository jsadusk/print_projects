runner_w = 10;
runner_l = 30;
runner_h = 50;
back_wall_t = 2;
side_wall_t = 3;
lip_t = 1;
side_lip = 2;
back_lip = 10;
tab_t = 3;
tab_h = 5;

cutout_w = lip_t + 2;
cutout_l = runner_l - side_lip * 2;
cutout_h = runner_h - back_lip;

outer_w = runner_w + back_wall_t + lip_t;
outer_l = runner_l + side_wall_t * 2;
outer_h = runner_h + back_wall_t;

tab_l = outer_w;

translate([0, 0, tab_h])
difference() {
cube(size=[outer_w, outer_l, outer_h], center=false);
translate([back_wall_t, side_wall_t, back_wall_t])
cube(size=[runner_w, runner_l, runner_h + 1],
    center=false);

translate([outer_w - lip_t - 1, side_wall_t + side_lip, side_wall_t + back_lip])
cube(size=[cutout_w, cutout_l, cutout_h],
    center=false);
}
translate([0, (outer_l - tab_t)/2, 0])
cube(size=[tab_l, tab_t, tab_h + 0.1], center=false);