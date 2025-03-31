Length=80;
Width=13;
Height=10;
basethickness=1.8;

module RailProfile(g=1.2,l=20,bt=2,topw=5,h=0,
               brickl=10,top=false,w=0,
               pspace=-0.1,
               brick=true,
               spacer=false)
{
   topw=w>0 ? (w-(2*bt)-(3-g)) : topw;
   g=h>0 ? (h-bt)/4 : g;
   toothcount=floor((l-2*bt-brickl*1.5-brickl)/brickl/2);
   if (top){
      union(){
         difference(){
            translate([(topw+4*g)/2*-1,l/2*-1,0]) 
              cube([topw+4*g,l,4*g+bt]);
            if (!spacer){
               RailProfile(g=g,l=l,bt=bt,topw=topw,brickl=brickl,
                           top=false,pspace=pspace*-1,
                           brick=false);
               sbricklen=brickl*1.5+2*pspace;
               translate([0,(l/2)*-1+sbricklen/2+bt+pspace,
                          (3*g+pspace)/2]) 
                  cube([topw+2*g+pspace*2*-1,
                        sbricklen,
                        3*g+pspace],
                       center=true);
               for(i=[0:toothcount-1]){
                  translate(
                     [0,
                      (((l/2)*-1)+bt+((brickl)/2)+brickl*1.5+brickl)+
                       i*(brickl*2),
                      (2*g)/2]) 
                     cube([topw+2*g,(brickl+pspace*-1),2*g],center=true);
               }
            }
         }
         if (!spacer){
            translate([(topw/2+0.4)*-1,l/2-bt-1.5,g/2])
               cylinder(r=0.7,h=g,$fn=60,center=true);
            translate([(topw/2+0.4),l/2-bt-1.5,g/2])
               cylinder(r=0.7,h=g,$fn=60,center=true);
         }
      }
   }
   else{
      difference(){
         union(){
            translate([0,0,bt/2*-1]) cube([topw+4*g,l,bt],center=true);
            if (spacer){
               translate([0,0,(4*g+pspace)/2]) 
                  cube([topw+4*g,l,4*g+pspace],center=true);
            }
            if (!spacer){
               difference(){
                  rotate(90,[1,0,0]){
                     linear_extrude(l+pspace-2*bt,center=true) 
                     union(){
                        polygon([
                            [0,0],
                            [(topw/2+pspace),0],
                            [(topw/2+pspace),1*g],
                            [(1*g+topw/2+pspace),2*g],
                            [(1*g+topw/2+pspace),3*g],
                            [(topw/2+pspace),4*g+pspace],
                            [(topw/2+pspace)*-1,4*g+pspace],
                            [(1*g+topw/2+pspace)*-1,3*g],
                            [(1*g+topw/2+pspace)*-1,2*g],
                            [(topw/2+pspace)*-1,1*g],
                            [(topw/2+pspace)*-1,0],
                           ],
                           [[0,1,2,3,4,5,6,7,8,9,10,0]]
                        );
                     }
                  };
                  if (brick){
                     bricklen=brickl*1.5+abs(pspace);
                     translate([0,(l/2*-1)+(bricklen/2)+pspace,(4*g+pspace)/2]) 
                        cube([ topw+4*g,bricklen,4*g+pspace],center=true);
                  }
                  if (brick){
                     for(i=[0:toothcount]){
                        translate(
                           [0,
                            (((l/2)*-1)+bt+brickl*1.5+brickl/2+brickl*1.3)+
                             i*(brickl*2),
                            (4*g+pspace)/2+g]) 
                           cube([topw+2*g,
                                 brickl+2*(2*pspace*-1),
                                 4*g+pspace],center=true);
                     }
                  }
               }
               if (brick){
                  translate([topw/2*-1,(l/2)-brickl-bt,0]) 
                     cube([topw,brickl,g*2]);
               }
        
            }
         }
         translate([(topw/2+0.7)*-1,l/2-bt-1.5,g/2])
            cylinder(r=1.0,h=g,$fn=60,center=true);
         translate([(topw/2+0.7),l/2-bt-1.5,g/2])
            cylinder(r=1.0,h=g,$fn=60,center=true);
      }
   }
}


//translate([-30,0,-30]) 
//   color("red") 
//   RailProfile(h=Height,l=Length,w=Width,bt=basethickness,top=false,
//               spacer=true);

translate([-10,0,-10]) 
   color("green") 
   RailProfile(h=Height,l=Length,w=Width,bt=basethickness,top=false);

translate([10,0,10]) 
   color("blue") 
   RailProfile(h=Height,l=Length,w=Width,bt=basethickness,top=true);

//translate([30,0,30]) 
//   color("red") 
//   RailProfile(h=Height,l=Length,w=Width,bt=basethickness,top=true,
//               spacer=true);

