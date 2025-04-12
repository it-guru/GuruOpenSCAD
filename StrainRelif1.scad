

Relif_sz=20;
Relif_height=10;

module StrainRelif(sz=20,part="bottom",spacer=false){
   g=sz/20;
   h=10*g;
   if (part=="bottom"){
      h1=2*g;
      h2=8*g;
      difference(){
         translate([0,0,h/2])
            cube([sz,sz,h],center=true);
         if (!spacer){
            translate([0,0,(h1/2)+8*g+0.1])
               cylinder(r=8*g+0.1,h=h1,center=true,$fn=50);
            translate([0,0,(h2/2)+2*g+0.1])
               cylinder(r=6*g+0.1,h=h2,center=true,$fn=50);
            hull(){
               translate([0,6*g*-1,g*3.5])
                  rotate(a=[0,90,0])
                     cylinder(d=4*g,h=sz*2,center=true,$fn=50);
               translate([0,6*g*-1,g*10])
                  rotate(a=[0,90,0])
                     cylinder(d=4*g,h=sz*2,center=true,$fn=50);
            }
         }
      }
   }
   if (part=="skrew"){
      h1=5*g;
      h2=2*g;
      difference(){
         union(){ 
            translate([0,0,(h1/2)+2*g])
               cylinder(r=6*g,h=h1,center=true,$fn=50);
            translate([0,0,(h2/2)+g*7])
               cylinder(r=8*g,h=h2,center=true,$fn=50);
         }
         translate([0,5*g*-1,(5*g/2)+2*g])
            cube([sz,3*g,5*g],center=true);
         translate([0,0,h/2+3*g+1])
            cube([6.5*g,2*g,h],center=true);
         h4=4*g;
         difference(){
            translate([2*g*-1,2*g,(h4/2)+2*g])
               cylinder(r=20*g,h=h4,center=true,$fn=50);
            translate([2*g*-1,2*g,(h4/2)+2*g])
               cylinder(r=6.6*g,h=h4,center=true,$fn=50);
         }
      }
   }
}

translate([0,0,30])
   StrainRelif(
      part="skrew",
      sz=Relif_sz
   );
translate([0,0,0])
   StrainRelif(
      part="bottom",
      sz=Relif_sz
   );
//translate([0,0,-30])
//   StrainRelif(
//      part="bottom",
//      spacer=true,
//      sz=Relif_sz
//   );


