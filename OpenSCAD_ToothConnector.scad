Height=6;
Length=52;
Hole_Count=2;
//Drop_Test=20;  // [10:S, 20:M, 30:L]

module connector_tooth(
    baserail=1, snapper=false, spaceronly=false,
    wtop=10,  // limit, because bridge length is limited
    wbottom=7,
    toothlen=8,
    h=4,
    l=20,
    holecount=0, holewidth=5, 
    basethickness=1.2,basewidth=15)
{
   olap=(wtop-wbottom)*1.2;
   toothcount=floor(l/(2*toothlen));
   echo("toothcount=",toothcount);

   if (baserail==1 || baserail==2){
      l1=(h/2*-1)+basethickness*2;
      l2=(h/2*-1)+basethickness*4+0.4; // ensure to get more then 45 dec
      if (!spaceronly){
         difference(){
            translate([0,0,h/2]) union(){
               difference(){
                  union(){
                     hull(){
                        translate([0,l/2,l1]) 
                           cylinder(r1=wbottom/2,h=l2-l1,r2=wtop/2,$fn=60);
                        translate([0,l/2*-1,l1]) 
                           cylinder(r1=wbottom/2,h=l2-l1,r2=wtop/2,$fn=60);
                     };
                     translate([wbottom/2*-1,l/2*-1,h/2*-1]) 
                        cube([wbottom,l,h/2-l1]);
                     translate([wtop/2*-1,(l/2+wtop/2)*-1,l2]) 
                        cube([wtop,l+wtop,(h/2)-l2]);
//                     translate([0,l/2,(h/2)*-1]) 
//                        cylinder(r=wbottom/2,h=h/2,$fn=60);
                  }
                  translate([(wtop/2)*-1,(l/2+wtop-basethickness)*-1,h/2*-1]) 
                     cube([wtop,wtop,h]);
                  translate([(wtop/2)*-1,(l/2-basethickness),h/2*-1]) 
                     cube([wtop,wtop,h]);
                  if (baserail==1){
                     for(i=[0:toothcount]){
                        translate([wbottom,
                                   (l/2*-1)-(toothlen/2)+(toothlen*2*i),
                                   0]) 
                           cube([wbottom,toothlen,h],center=true);
                        translate([wbottom*-1,
                                   (l/2*-1)-(toothlen/2)+(toothlen*2*i),
                                   0]) 
                           cube([wbottom,toothlen,h],center=true);
                     }
                     translate([0,l/2-(toothlen)/2,0]) 
                        cube([wtop,toothlen*1.5,h],center=true);
                  }
              //    translate([0,
              //               (l/2*-1)+(toothlen*2*toothcount),
              //               0]) 
              //       cube([wtop,toothlen+0.2,h/2],center=true);
               };
               // BaseBlade
               translate([(basewidth/2)*-1,(l/2)*-1,(h/2+basethickness)*-1]) 
                  cube([basewidth,l,basethickness]);
//               if (snapper){
//                  for(i=[1:1]){
//                     translate([0-(wbottom/2-0.2),(l/2)*-1+i*3,(h/2)*-1]) 
//                        cylinder(r=0.7,h=h/2,$fn=60);
//                     translate([wbottom/2-0.2,(l/2)*-1+i*3,(h/2)*-1]) 
//                        cylinder(r=0.7,h=h/2,$fn=60);
//                   }
//               }
            }
//            if (holecount>0){
//               translate([0,0.5*wbottom+((l/holecount)/2)-(l/2),
//                          (basethickness)*-1]) 
//               for(i=[0:holecount-1]){
//                  hhole=h/2+basethickness;
//                  hsink=holewidth/3;
//                  sinkwidth=holewidth*1.8;
//                  translate([0,i*(l/holecount),0]) 
//                     cylinder(r=holewidth/2,h=hhole,$fn=60);
//                  translate([0,i*(l/holecount),hhole]) 
//                     cylinder(r1=holewidth/2,
//                              r2=sinkwidth/2,
//                              h=hsink,$fn=60);
//                  translate([0,i*(l/holecount),hhole+hsink]) 
//                     cylinder(r=sinkwidth/2,
//                              h=h,$fn=60);
//               }
//            }
         }
      }
      else{
         translate([(basewidth/2)*-1,(l/2)*-1,0]) 
            cube([basewidth,l+basewidth/2,basethickness+h]);
      }
   }
   else{
      difference(){
         translate([(basewidth/2)*-1,(l/2)*-1,0]) 
            cube([basewidth,l,basethickness+h]);
         if (!spaceronly){
            connector_tooth(baserail=2,
                           wtop=wtop+0.4,
                           snapper=snapper,
                           wbottom=wbottom+0.3,
                           h=h+0.2,l=l,
                           holecount=holecount);
         }
         for(i=[1:toothcount]){
            translate([0,
                       (l/2*-1)-(toothlen/2)+(toothlen*2*i),
                       h/2]) 
               cube([wtop,toothlen+0.4,h],center=true);
         }




      }

   }
}

if (false) 
   color("red")  
   translate([0,0,Height*1.5*-1]) 
   connector_tooth(h=Height,baserail=true,spaceronly=true,l=Length,holecount=Hole_Count);

if (true) 
   color("blue")  
   connector_tooth(h=Height,baserail=1,snapper=true,l=Length,
                  holecount=Hole_Count);

if (true) 
   color("green") 
   translate([Height*2.5,0,Height*1.5]) 
   connector_tooth(h=Height,baserail=0,snapper=true,l=Length);

if (false)
   color("red") 
   translate([0,0,Height*3]) 
   connector_tooth(h=Height,baserail=false,spaceronly=true,l=Length);

