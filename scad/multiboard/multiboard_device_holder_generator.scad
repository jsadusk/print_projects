$fn = 50;
include <../components/multiboard.scad>;

module base(base_w, base_l, base_h, wall_t) {
    difference() {
        cube(size=[base_w, base_l, base_h]);
        translate([base_w / 2, base_l / 2, -0.01])
        multipoint_slots(base_w - wall_t * 2);
    }
}

module clip(clip_w, base_h, device_h, wall_t, clip_bump) {
    cube(size=[clip_w, wall_t, base_h + device_h + clip_bump / 2]);
    translate([0, wall_t, base_h + device_h])
    rotate([0, 90, 0])
    cylinder(d=clip_bump, h=clip_w);
}

module bottom_clip(
    clip_w, clip_off, 
    base_h, device_h, wall_t, clip_bump
) {
    translate([clip_off+ wall_t, 0, 0])
    clip(clip_w, base_h, device_h, wall_t, clip_bump);
}

module left_clip(
    clip_w, clip_off, 
    base_h, device_h, wall_t, clip_bump
) {
    translate([0, clip_w + clip_off + wall_t, 0])
    rotate([0, 0, -90])
    clip(clip_w, base_h, device_h, wall_t, clip_bump);
}

module right_clip(
    clip_w, clip_off, 
    base_w, base_h, device_h, wall_t, clip_bump
) {
    translate([base_w, clip_off + wall_t, 0])
    rotate([0, 0, 90])
    clip(clip_w, base_h, device_h, wall_t, clip_bump);
}

module top_clip(
    clip_w, clip_off,
    base_l, base_h, device_h, wall_t, clip_bump
) {
    translate([clip_w + clip_off + wall_t, base_l, 0])
    rotate([0, 0, 180])
    clip(clip_w, base_h, device_h, wall_t, clip_bump);
}

module place_clips(
    bottom_clips, top_clips, left_clips, right_clips,
    base_w, base_l, base_h, device_h, wall_t, clip_bump
) {
    for (clip_desc = bottom_clips) {
        bottom_clip(clip_desc[0], clip_desc[1], base_h, device_h, wall_t, clip_bump);
    }
    for (clip_desc = top_clips) {
        top_clip(clip_desc[0], clip_desc[1], base_l, base_h, device_h, wall_t, clip_bump);
    }
    for (clip_desc = left_clips) {
        left_clip(clip_desc[0], clip_desc[1], base_h, device_h, wall_t, clip_bump);
    }
    for (clip_desc = right_clips) {
        right_clip(clip_desc[0], clip_desc[1], base_w, base_h, device_h, wall_t, clip_bump);
    }
}

module multiboard_device_holder(
    device_w, device_l, device_h,
    bottom_clips, top_clips, left_clips, right_clips,
    layer_t = 0.2,
    floor_layers = 4,
    layer_w = 0.4,
    wall_layers = 4,
    clip_bump = 3
) {
    floor_t = layer_t * floor_layers;
    wall_t = layer_w * wall_layers;

    base_w = device_w + wall_t * 2;
    base_l = device_l + wall_t * 2;
    base_h = multipoint_h + floor_t;

    translate([-base_w / 2, -base_l / 2, 0]) {
        base(base_w, base_l, base_h, wall_t);
        place_clips(
            bottom_clips, top_clips, left_clips, right_clips,
            base_w, base_l, base_h, device_h, wall_t, clip_bump);
    }
}
