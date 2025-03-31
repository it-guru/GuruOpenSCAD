module rail_clip(h=10)
{
   wall=2.4;
   x=16.5;
   outerx=x+wall;

   difference(){
      union(){
         translate([outerx/2*-1,outerx/2*-1,h/2*-1]) 
           cube([outerx,outerx,h]);
         translate([x/2+wall/4,x/2+wall/4,0]) 
            rotate(-45)
            cube([outerx,4,h],center = true);
      }
 //     translate([outerx/2*-1,outerx/2*-1,h/2*-1]) 
 //        cube([x,x,h]);
      hull(){
         translate([x/2-wall,(x/2)*-1,0]) 
            rotate(-45)
            cube([3,3,h],center = true);
         translate([(x/2)*-1,x/2-wall,0]) 
            rotate(45)
            cube([3,3,h],center = true);
         translate([x/2-4,x/2-4,0]) 
            cylinder(r=4,h=x,center=true,$fn=60);
         translate([x/2*-1,x/2*-1,0]) 
            cylinder(r=4,h=x,center=true,$fn=60);
      }
   }
}

rail_clip();
