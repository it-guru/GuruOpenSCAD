


module ShellyRGBW2(
   _inner=false,
   drillholes=false,
   bt=1.8,
   shellyX=42.8,
   shellyY=38.0,
   shellyTopW=20, 
   shellyThick=14.5,
   shellyPinFieldX=36
){

   if (!_inner){
      difference(){
         union(){
            difference(){
               hull(){
                  translate([(shellyX/2+0.8),1,shellyThick/2-bt]) 
                     cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
                  translate([(shellyX/2+0.8)*-1,1,shellyThick/2-bt]) 
                     cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
                  translate([(shellyTopW/2),shellyY+2,shellyThick/2-bt]) 
                     cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
                  translate([(shellyTopW/2)*-1,shellyY+2,shellyThick/2-bt]) 
                     cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
        
                  translate([(shellyTopW/2+0.8)+(shellyX-shellyTopW)/2,
                              shellyY-(shellyX-shellyTopW)/2+0.8,shellyThick/2-bt]) 
                     cylinder(h=shellyThick+bt+3,r1=1,center=true,$fn=50);
                  translate([((shellyTopW/2+0.8)+(shellyX-shellyTopW)/2)*-1,
                             shellyY-(shellyX-shellyTopW)/2+0.8,shellyThick/2-bt]) 
                     cylinder(h=shellyThick+bt+3,r1=1,center=true,$fn=50);
               }
               translate([(shellyX/4+1)*-1,0,2])
                  cube([shellyX/2+2,bt*2,shellyThick]);
               translate([(shellyX/2-1)*-1-0.5,0,-0.5])
                  cube([shellyX/4-1,bt*2,shellyThick+3]);
               translate([(shellyX/4)+0.5,0,-0.5])
                  cube([shellyX/4-1,bt*2,shellyThick+3]);
        
               translate([0,shellyY/2+1,12])
                  cube([shellyX+8,shellyY/1.5,8],center=true);
        
               ShellyRGBW2(bt=bt,_inner=true);
            }
            if (drillholes){
               hull(){
                  translate([shellyX/2+shellyY/6+1,shellyY/2,bt*-1])
                      cylinder(h=bt,r=shellyY/6,center=true,$fn=50);
                  translate([(shellyX/2+shellyY/6+1)*-1,shellyY/2,bt*-1])
                      cylinder(h=bt,r=shellyY/6,center=true,$fn=50);
               }
            }
         }
         if (drillholes){
            translate([(shellyX/2+shellyY/6+1),shellyY/2,bt*-1])
                cylinder(h=bt,d=4.5,center=true,$fn=50);
            translate([(shellyX/2+shellyY/6+1),shellyY/2,bt/1.4*-1])
                cylinder(h=bt/2,d1=4.5,d2=6,center=true,$fn=50);
            translate([(shellyX/2+shellyY/6+1)*-1,shellyY/2,bt*-1])
                cylinder(h=bt,d=4.5,center=true,$fn=50);
            translate([(shellyX/2+shellyY/6+1)*-1,shellyY/2,bt/1.4*-1])
                cylinder(h=bt/2,d1=4.5,d2=6,center=true,$fn=50);
         }
      }

   }
   else{
      union(){
         hull(){
            //rechts
            translate([(shellyX/2-1),2,shellyThick-1]) 
               cylinder(h=2,r1=1,r2=0,center=true,$fn=50);
            translate([(shellyX/2-1),2,1]) 
               cylinder(h=2,r1=0,r2=1,center=true,$fn=50);
        
            //links
            translate([(shellyX/2-1)*-1,2,shellyThick-1]) 
               cylinder(h=2,r1=1,r2=0,center=true,$fn=50);
            translate([(shellyX/2-1)*-1,2,1]) 
               cylinder(h=2,r1=0,r2=1,center=true,$fn=50);
        
            //oben rechts
            translate([(shellyTopW/2-1),shellyY+1,shellyThick-1]) 
               cylinder(h=2,r1=1,r2=0,center=true,$fn=50);
            translate([(shellyTopW/2-1),shellyY+1,1]) 
               cylinder(h=2,r1=0,r2=1,center=true,$fn=50);
        
            //oben links
            translate([(shellyTopW/2-1)*-1,shellyY+1,shellyThick-1]) 
               cylinder(h=2,r1=1,r2=0,center=true,$fn=50);
            translate([(shellyTopW/2-1)*-1,shellyY+1,1]) 
               cylinder(h=2,r1=0,r2=1,center=true,$fn=50);
        
        
            //mitte rechts
            translate([(shellyTopW/2-1)+(shellyX-shellyTopW)/2,
                        shellyY-(shellyX-shellyTopW)/2,shellyThick-1]) 
               cylinder(h=2,r1=1,r2=0,center=true,$fn=50);
            translate([(shellyTopW/2-1)+(shellyX-shellyTopW)/2,
                        shellyY-(shellyX-shellyTopW)/2+0.5,1]) 
               cylinder(h=2,r1=0,r2=1,center=true,$fn=50);
        
            //mitte links
            translate([((shellyTopW/2-1)+(shellyX-shellyTopW)/2)*-1,
                       shellyY-(shellyX-shellyTopW)/2,shellyThick-1]) 
               cylinder(h=2,r1=1,r2=0,center=true,$fn=50);
            translate([((shellyTopW/2-1)+(shellyX-shellyTopW)/2)*-1,
                        shellyY-(shellyX-shellyTopW)/2+0.5,1]) 
               cylinder(h=2,r1=0,r2=1,center=true,$fn=50);
        
         }

         hull(){
            translate([(shellyX/2-2.5),1,shellyThick]) 
               cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
            translate([(shellyX/2-2.5)*-1,1,shellyThick]) 
               cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
            translate([(shellyTopW/2)-1.2,shellyY-1,shellyThick]) 
               cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
            translate([(shellyTopW/2-1.2)*-1,shellyY-1,shellyThick]) 
               cylinder(h=shellyThick+bt+3,r=1,center=true,$fn=50);
        
            translate([(shellyTopW/2-2.5)+(shellyX-shellyTopW)/2,
                        shellyY-(shellyX-shellyTopW)/2,shellyThick]) 
               cylinder(h=shellyThick+bt+3,r1=1,center=true,$fn=50);
            translate([((shellyTopW/2-2.5)+(shellyX-shellyTopW)/2)*-1,
                       shellyY-(shellyX-shellyTopW)/2,shellyThick]) 
               cylinder(h=shellyThick+bt+3,r1=1,center=true,$fn=50);
         }
       }
   }


}

ShellyRGBW2();

