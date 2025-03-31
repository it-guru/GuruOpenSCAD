use <OpenSCAD_RailConnector.scad>

Height=7;
Length=40;
Hole_Count=2;
Drop_Test=20;  // [10:S, 20:M, 30:L]


if (false) 
   color("red")  
   translate([0,0,Height*1.5*-1]) 
   connector_rail(h=Height,baserail=true,spaceronly=true,l=Length,holecount=Hole_Count);

if (true) 
   color("blue")  
   connector_rail(h=Height,baserail=true,snapper=true,l=Length,openerhole=true,
                  holecount=Hole_Count);

if (true) 
   color("green") 
   translate([Height*2.5,0,Height*1.5]) 
   connector_rail(h=Height,baserail=false,snapper=true,l=Length);

if (false)
   color("red") 
   translate([0,0,Height*3]) 
   connector_rail(h=Height,baserail=false,spaceronly=true,l=Length);

