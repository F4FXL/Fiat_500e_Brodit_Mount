use <MCAD/2Dshapes.scad>;


rotate([270,0,0])
{
    clip(33, 50, 7, 3, 5);
    translate([0,0,0]) rotate([0,90,0]) ampplate(36, 50, 5, false);
    translate([0,50,-36]) rotate([0,180,180]) bottomclip();
    //translate([0,0,-36]) rotate([270,180,270]) ampextender();
}



module bottomclip()
{
    translate([0,25,0]) rotate([3,0,0]) 
    {
        translate([0,0,-2]) cube([5,25,2], false);
        clip(44.5, 25, 3, 7, 15);
        translate([41.5,25,0]) color("grey") cube([4.5,5,3], false);
        translate([41.5,25,0]) linear_extrude(3) pieSlice(size=5, start_angle=90, end_angle=180, $fn=360);
    }
    clip(44.5, 25, 3, 7);
    translate([44.5-2-15,0,0]) color("lime") cube([2,10,9], false);
}

 module ampplate(length, width, height, landscape)
 {
     translate([length/2, width/2, height/2]) color("green") difference()
     {
        cube([length,width,height], true);
        rotate([0,0,landscape?0:90]) ampholes();
     }
 }
 
  module ampholes() {
    translate([-19,15,-5])cylinder(h=10, d=3.5, center=false, $fn=360);
    translate([19,15,-5]) cylinder(h=10, d=3.5, center=false, $fn=360);
    translate([-19,-15,-5])cylinder(h=10, d=3.5, center=false, $fn=360);
    translate([19,-15,-5]) cylinder(h=10, d=3.5, center=false, $fn=360);
 }

module clip(length, width, ring_diameter=7, ring_extension_len=2.5, flat_space=20)
{
    translate([5.5,0,0])
    {
        cube([length, width, 3], center=false);
        translate([length,0, ring_diameter]) rotate([270,90,0]) ring(width, ring_diameter, 3 , 270,360);
        translate([length + ring_diameter - 3, 0, ring_diameter]) color("green") cube([3, width, ring_extension_len], center=false);
        translate([length-flat_space,0,3]) rotate([0,0,90]) color("red") prism(width,length-flat_space,2.5);
        translate([0,width,0]) rotate([90,90,0]) linear_extrude(width) pieSlice(size=5.5, start_angle=180, end_angle=270, $fn=360);
    }
}

module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
 }
 
 module ring(height, exterior_diameter, thickness, start_angle_, end_angle_) 
{
    difference()
    {
        linear_extrude(height) pieSlice(size=exterior_diameter, start_angle=start_angle_, end_angle=end_angle_, $fn=360);
        translate([0, 0, height/2]) color("red") cylinder(h=height*1.2, d=(exterior_diameter-thickness)*2, center=true, $fn=360);
    }
}

