use <RailProfile.scad>
BoxWidth         = 100;
BoxLength        = 70;
BoxHeight        = 35;
BoxWallThickness = 2.5;
BoxCoverPCT      = 50;

//add_powerport_hole = true;

//$fn=60;


module _MultiBox_base_shell(w=10,l=50,h=20,r=1,off=0,zoff=1)
{
  hull(){
     translate([(w/2+off),   (l/2+off),   0]) cylinder(h=h,r=r,$fn=50);
     translate([(w/2+off)*-1,(l/2+off),   0]) cylinder(h=h,r=r,$fn=50);
     translate([(w/2+off),   (l/2+off)*-1,0]) cylinder(h=h,r=r,$fn=50);
     translate([(w/2+off)*-1,(l/2+off)*-1,0]) cylinder(h=h,r=r,$fn=50);
  }
}

module _MultiBox_single_skrew_hole(x=1,y=1,h=20)
{
  d=4.5;
  d2=7.5;

  union(){
     translate([x,y,    0.1]) cylinder(h=h+1,d=d,$fn=50);
     translate([x,y,    h-4]) cylinder(h=(d2-d)/2,d1=d,d2=d2,$fn=50);
     translate([x,y,    h-2.6]) cylinder(h=7,d=d2,$fn=50);
  }
}

module _MultiBox_single_base_nut(x=1,y=1,h=20,r=1,blk=0)
{
  off=blk;
  difference(){
     hull(){
         translate([x+blk/2,    y+blk/2,    0]) cylinder(h=h,r=r,$fn=50);
         translate([x+blk/2,    y+blk/2-off,0]) cylinder(h=h,r=r,$fn=50);
         translate([x+blk/2-off,y+blk/2-off,0]) cylinder(h=h,r=r,$fn=50);
         translate([x+blk/2-off,y+blk/2,    0]) cylinder(h=h,r=r,$fn=50);
      };
      translate([x,y, 10]) cylinder(h=h+1,r=2,$fn=50);
   }
}

module _MultiBox_cover_skrew_nuts(w=10,l=50,h=20,r=1)
{
  smellnut_dia=6.00;
  smellnut_blk=4;

  
  union(){
     _MultiBox_single_skrew_hole(x=(w/2)-smellnut_blk/2,
              y=(l/2)-smellnut_blk/2,
              h=h-1);
     _MultiBox_single_skrew_hole(x=(w/2)*-1+smellnut_blk/2,
              y=(l/2)-smellnut_blk/2,
              h=h-1);
     _MultiBox_single_skrew_hole(x=(w/2)*-1+smellnut_blk/2,
              y=(l/2)*-1+smellnut_blk/2,
              h=h-1);
     _MultiBox_single_skrew_hole(x=(w/2)-smellnut_blk/2,
              y=(l/2)*-1+smellnut_blk/2,
              h=h-1);
  };

}

module _MultiBox__MultiBox_base_shell_nuts(w=10,l=50,h=20,r=1)
{
  smellnut_dia=6.00;
  smellnut_blk=4;

  
  union(){
     _MultiBox_single_base_nut(x=(w/2)-smellnut_blk/2,
              y=(l/2)-smellnut_blk/2,
              h=h-1,
              blk=smellnut_blk,r=smellnut_dia/2);
     _MultiBox_single_base_nut(x=(w/2)*-1+smellnut_blk/2,
              y=(l/2)-smellnut_blk/2,
              h=h-1,
              blk=smellnut_blk,r=smellnut_dia/2);
     _MultiBox_single_base_nut(x=(w/2)*-1+smellnut_blk/2,
              y=(l/2)*-1+smellnut_blk/2,
              h=h-1,
              blk=smellnut_blk,r=smellnut_dia/2);
     _MultiBox_single_base_nut(x=(w/2)-smellnut_blk/2,
              y=(l/2)*-1+smellnut_blk/2,
              h=h-1,
              blk=smellnut_blk,r=smellnut_dia/2);
  };

}

module MultiBox(
   part="bottom",
   fastening="none",
   closure="screw",
   width=50,
   length=80,
   wall_thickness=2.5,
   height=40,
   ventilation=true,
   cover_pct=50
){
   box_corner_radius =4;
   box_lid_height    =5;
   rail_w            =10;
   rail_h            =8;
   box_width=width-2*box_corner_radius;
   box_length=length-2*box_corner_radius;
   box_height=height;
   box_wall_thickness=wall_thickness;
   box_cover_pct=cover_pct;
   if (part=="bottom"){
      union(){
         difference(){
            union(){
               difference(){
                  union(){
                     _MultiBox_base_shell(
                            w=box_width,l=box_length,
                            h=box_height*(100-box_cover_pct)/100-box_lid_height+
                              box_lid_height,
                            r=box_corner_radius,
                            off=0
                        );
                     color("blue")
                     _MultiBox_base_shell(
                            w=box_width,l=box_length,
                            h=box_height*(100-box_cover_pct)/100-box_lid_height,
                            r=box_corner_radius,
                            off=box_wall_thickness/2
                        );
                  }
                  translate([0,0,box_wall_thickness])
                     _MultiBox_base_shell(
                            w=box_width,l=box_length,
                            h=box_height*(100-box_cover_pct)/100+1,
                            r=box_corner_radius,
                            off=(box_wall_thickness/2)*-1
                     );
        
               };
               _MultiBox__MultiBox_base_shell_nuts(
                     w=box_width,l=box_length,
                     h=box_height*(100-box_cover_pct)/100,
                     r=box_corner_radius
               );
            };
            if (fastening=="rail"){
               translate([(width/2-rail_w/2-rail_w),0,0])
                  RailProfile(
                        h=rail_h,w=rail_w,l=length,
                        top=true,spacer=true
                  );
               translate([(width/2-rail_w/2-rail_w)*-1,0,0])
                  RailProfile(
                        h=rail_h,w=rail_w,l=length,
                        top=true,spacer=true
                  );
            }
         }
         if (fastening=="rail"){
            translate([(width/2-rail_w/2),0,0])
               RailProfile(
                     h=rail_h,w=rail_w,l=length,
                     top=true,spacer=true
               );
            translate([(width/2-rail_w/2)*-1,0,0])
               RailProfile(
                     h=rail_h,w=rail_w,l=length,
                     top=true,spacer=true
               );
            translate([(width/2-rail_w/2-rail_w),0,0])
               RailProfile(
                     h=rail_h,w=rail_w,l=length,
                     top=true,spacer=false
               );
            translate([(width/2-rail_w/2-rail_w)*-1,0,0])
               RailProfile(
                     h=8,w=rail_w,l=length,
                     top=true,spacer=false
               );
         }
      }
   }
   if (part=="cover"){
      difference(){
         union(){
            difference(){
               color("blue")
                  _MultiBox_base_shell(w=box_width,l=box_length,
                             h=box_height*(box_cover_pct)/100,
                             r=box_corner_radius,
                             off=0);
               translate([0,0,-0.1])
                  _MultiBox_base_shell(w=box_width,l=box_length,
                             h=box_lid_height,
                             r=box_corner_radius,
                             off=box_wall_thickness/2*-1);
               translate([0,0,box_wall_thickness])
                  _MultiBox_base_shell(w=box_width,l=box_length,
                             h=box_height*(box_cover_pct)/100-
                               box_wall_thickness-box_lid_height,
                             r=box_corner_radius,
                             off=box_wall_thickness*-1);
            }
            translate([0,0,box_lid_height])
               _MultiBox__MultiBox_base_shell_nuts(w=box_width,l=box_length,
                             h=box_height*(box_cover_pct)/100-
                               box_wall_thickness-box_lid_height,
                             r=box_corner_radius);
         }
         _MultiBox_cover_skrew_nuts(w=box_width,l=box_length,
                          h=box_height*(box_cover_pct)/100);

         if (ventilation){
            vent_border=10;
            vent_len=box_length-(2*vent_border);
            vent_width=1.8;
            vent_step=10;  // space between lines
            vent_deg=45;
            n=floor((box_width-2*vent_border)/vent_step);
        
            for(i=[0:n]){
               translate([(box_width-2*vent_border)/2*-1+(i*vent_step),
                           0,box_height*(box_cover_pct)/100]){
                  rotate(a=[0,vent_deg,0]) hull(){
                     translate([0,vent_len/2,0]) 
                        cylinder(d=vent_width,h=20,$fn=20,center=true); 
                     translate([0,(vent_len/2)*-1,0]) 
                        cylinder(d=vent_width,h=20,$fn=20,center=true); 
                  }
               }
            }
         }
      }
   }
}






translate([0,0,50]) 
   MultiBox(
      part="cover",
      fastening="rail",
      width=BoxWidth,
      length=BoxLength,
      wall_thickness=BoxWallThickness,
      height=BoxHeight,
      cover_pct=BoxCoverPCT
   );
//translate([0,0,0]) 
//   MultiBox(
//      part="bottom",
//      fastening="rail",
//      width=BoxWidth,
//      length=BoxLength,
//      wall_thickness=BoxWallThickness,
//      height=BoxHeight,
//      cover_pct=BoxCoverPCT
//   );

