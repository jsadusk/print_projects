for (j = [-1:1]) {
for (i = [-3: 3]) {
    translate([36 * i, 47*j, 0])
    import("/home/joe/Downloads/Round_15mm.stl");
}
}