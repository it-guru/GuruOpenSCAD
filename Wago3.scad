
module Wago(
  n=3,
  wagoY=18.13,
  wagoX=5.6,
  wagoH=8.0,
  wagoXwall=0.95,
  bt=1.8
){
   difference(){
      union(){
         difference(){
            translate([0,(wagoY+bt)/2,wagoH/2])
               cube([n*wagoX+2*wagoXwall+2*bt,wagoY+bt,wagoH],center=true);
            translate([0,wagoY/2,wagoH/2])
               cube([n*wagoX+2*wagoXwall,wagoY,wagoH],center=true);
         }
         translate([(n*wagoX+2*wagoXwall)/2*-1+0.1,9,4])
            cube([0.2,12,5.5],center=true);
         translate([(n*wagoX+2*wagoXwall)/2-0.1,9,4])
            cube([0.2,12,5.5],center=true);
         translate([0,(wagoY+bt)/2,bt/2*-1])
            color("blue")
            cube([n*wagoX+2*wagoXwall+2*bt,wagoY+bt,bt],center=true);
         translate([0,bt/4*-1,(bt-0.6)/2*-1])
            color("green")
            cube([n*wagoX+2*wagoXwall+2*bt,bt/1.5,bt+0.6],center=true);
         translate([0,wagoY+0.2,6])
            rotate(a=90,v=[0,1,0])
            cylinder(d=2,h=3,$fn=60,center=true);
      }
      translate([0,0,bt-0.5])
         color("green")
         cube([6,3,bt*2],center=true);

   }





}

Wago(n=3);
