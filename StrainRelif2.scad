
module StrainRelif2(part="bottom",spacer=false){
   xlen=27;
   ylen=8;
   totalH=17;
   topH=6;
   holeDist=18;
   holeD=3.3;
   drilD=4.0;
   sinkD=5.5;
   sinkH=3.5;
   if (part=="bottom"){
      union(){
         difference(){
            union(){
               hull(){
                  translate([(xlen/2-1)*-1,(ylen/2-1)*-1,0])
                     cylinder(d=2,h=totalH-topH,$fn=40);
                  translate([(xlen/2-1),(ylen/2-1)*-1,0])
                     cylinder(d=2,h=totalH-topH,$fn=40);
                  translate([(xlen/2-1),(ylen/2-1),0])
                     cylinder(d=2,h=totalH-topH,$fn=40);
                  translate([(xlen/2-1)*-1,(ylen/2-1),0])
                     cylinder(d=2,h=totalH-topH,$fn=40);
               }
            }
            if (!spacer){
               translate([0,0,(holeDist*1.5)+(totalH-topH)-0.9])
                  rotate(a=[90,0,0])
                  cylinder(d=holeDist*3,h=totalH-topH,center=true,$fn=90);
            }
            if (!spacer){
               translate([holeDist/2,0,])
                  cylinder(d=drilD,h=totalH-topH,$fn=40);
               translate([(holeDist/2)*-1,0,0])
                  cylinder(d=drilD,h=totalH-topH,$fn=40);
            }
         }
         if (!spacer){
            translate([0,(ylen/2)-2.5,totalH-topH-0.8])
               rotate(a=[90,0,90])
               cylinder(d=1.2,h=holeDist-sinkD,center=true,$fn=90);
            translate([0,((ylen/2)-2.5)*-1,totalH-topH-0.8])
               rotate(a=[90,0,90])
               cylinder(d=1.2,h=holeDist-sinkD,center=true,$fn=90);
         }
      }
   }
   if (part=="top"){
      union(){
         difference(){
            union(){
               hull(){ 
                  translate([((xlen-0.4)/2-ylen/2)*-1,0,0])
                     cylinder(d=ylen,h=topH,$fn=60);
                  translate([((xlen-0.4)/2-ylen/2),0,0])
                     cylinder(d=ylen,h=topH,$fn=60);
               }
            }
            if (!spacer){
               translate([0,0,(holeDist*1.5)*-1+1])
                  rotate(a=[90,0,0])
                  cylinder(d=holeDist*3,h=totalH-topH,center=true,$fn=90);
            }
            if (!spacer){
               translate([holeDist/2,0,0])
                  cylinder(d=holeD,h=topH,$fn=40);
               translate([(holeDist/2)*-1,0,0])
                  cylinder(d=holeD,h=topH,$fn=40);

               sinkH2=0.6;
               echo("sinkH2=",sinkH2);

               translate([holeDist/2,0,topH-sinkH2-sinkH])
                  cylinder(d2=sinkD,d1=holeD,h=sinkH2,$fn=60);
               translate([holeDist/2,0,topH-sinkH])
                  cylinder(d=sinkD,h=sinkH,$fn=60);

               translate([(holeDist/2)*-1,0,topH-sinkH2-sinkH])
                  cylinder(d2=sinkD,d1=holeD,h=sinkH2,$fn=60);
               translate([(holeDist/2)*-1,0,topH-sinkH])
                  cylinder(d=sinkD,h=sinkH,$fn=60);
            }
         }
         translate([0,(ylen/2)-1.5,0.7])
            rotate(a=[90,0,90])
            cylinder(d=1,h=holeDist,center=true,$fn=90);
         translate([0,((ylen/2)-1.5)*-1,0.7])
            rotate(a=[90,0,90])
            cylinder(d=1,h=holeDist,center=true,$fn=90);
         translate([0,0,0.9])
            rotate(a=[90,0,90])
            cylinder(d=1,h=holeDist-sinkD,center=true,$fn=90);
      }
   }
}

//translate([0,0,60])
//   StrainRelif2(
//      part="top",
//      spacer=true
//   );
translate([0,10,30])
   StrainRelif2(
      part="top"
   );
translate([0,-10,0])
   StrainRelif2(
      part="bottom"
   );
//translate([0,0,-30])
//   StrainRelif2(
//      part="bottom",
//      spacer=true
//   );


