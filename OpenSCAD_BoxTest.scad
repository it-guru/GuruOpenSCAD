x=100;
y=80;
w=12;
r=4;
d=4;
h=20;
//thickness=1.6;
thickness=3;
pspace=1.0;
borderh=5;

module Corner(w=6,d=0,h=20,r=3,sinkd=0,sinkh=0){
   if (sinkd>0){
      union(){
         translate([0,0,(((sinkd/2)-(d/2))/2-sinkh/2)*-1])
            cylinder(r=d/2,h=h-sinkh-(sinkd-d)/2,
                     center=true,$fn=80);  // middle solid
         translate([0,0,((h/2)-((sinkd-d)/2+sinkh/2))*-1])
            cylinder(r2=d/2,r1=sinkd/2,h=(sinkd-d)/2,
                     center=true,$fn=80);  // middle solid
         if (sinkh>0){
            translate([0,0,h/2*-1-sinkh/2+(sinkd-d)/4])
               cylinder(r=sinkd/2,h=sinkh,
                        center=true,$fn=80);  // middle solid
         }
      }
   }
   else{
      difference(){
         hull(){
            translate([-w/2+r/2,-w/2+r/2,0]) cube([r,r,h],center=true,$fn=50);
            translate([w/2-r,-w/2+r,0])  cylinder(r=r,h=h,center=true,$fn=50);
            translate([-w/2+r,w/2-r,0])  cylinder(r=r,h=h,center=true,$fn=50);
            translate([w/2-r/2,w/2-r/2,0])   cube([r,r,h],center=true,$fn=50);
         }
         if (d>0){
            cylinder(r=d/2,h=h,center=true,$fn=80);  // middle hole
         }
      }
   }
}

module CornerMap( x=80, y=40, w=6, d=4, h=20, r=3, sinkd=0,sinkh=0)
{
   translate([x/2-w/2,-y/2+w/2,0])  
      Corner(w=w,d=d,h=h,r=r,sinkd=sinkd,sinkh=sinkh);
   translate([-x/2+w/2,y/2-w/2,0])  
      Corner(w=w,d=d,h=h,r=r,sinkd=sinkd,sinkh=sinkh);
   translate([-x/2+w/2,-y/2+w/2,0]) 
      rotate(90)
      Corner(w=w,d=d,h=h,r=r,sinkd=sinkd,sinkh=sinkh);
   translate([x/2-w/2,y/2-w/2,0])
      rotate(-90)
      Corner(w=w,d=d,h=h,r=r,sinkd=sinkd,sinkh=sinkh);
}


module box(x=10,y=10,
           w=5,d=3,r=3,h=5,thickness=3,
           sinkd=0,
           sinkh=0,
           borderh=2,pspace=1.0)
{
   union(){
      difference(){
         union(){
            hull(){
               CornerMap(x=x+thickness-pspace/2,y=y+thickness-pspace/2,
                         r=r-pspace/2+thickness/2,
                         w=w,d=d,h=h);
            }
//            difference(){
               hull() {
                  translate([0,0,-borderh/2])
                     CornerMap(x=x+2*thickness,y=y+2*thickness,
                               w=w,d=0,h=h-borderh);
               };
//               if (borderh<0){
//                  curPSpace=pspace/2;
//                  hull(){
//                     translate([0,0,h/2+abs(borderh)/2])
//                        CornerMap(x=x+thickness+curPSpace,
//                                  y=y+thickness+curPSpace,
//                                  w=w,d=d,r=r,
//                                  h=abs(borderh));
//                  }
//               }
//            }
         }
         hull(){ // innenraum leeren
            translate([0,0,0]) 
               CornerMap(x=x,
                         y=y,
                         r=r,
                         w=w,d=d,h=h*2);
         }
      };
      translate([0,0,-1]){  // final Eck Schmelzgewinde
         CornerMap(x=x,y=y,w=w,d=d,h=h-1); 
      }
      translate([0,0,-h/2-thickness/2]) hull(){  // boden
         CornerMap(x=x+2*thickness,y=y+2*thickness,w=w,d=0,h=thickness);
      }
   }
}

CornerMap( x=80, y=40, w=6, d=4, h=20, r=3, sinkd=6,sinkh=6);
//box(x=x,y=y,
//    w=w,d=d,h=h,r=r,
//    thickness=thickness,borderh=borderh,pspace=pspace);

//translate([0,0,h+40]) rotate([0,180,0]) box(w=w,d=d,h=h,x=x,y=y,thickness=thickness,borderh=-borderh);


//CornerMap( x=80, y=25, w=12, d=4, h=20, r=4);
//box(w=12,d=4,h=20,x=80,y=45,thickness=2,borderh=borderh);

