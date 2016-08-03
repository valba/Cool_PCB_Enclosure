//---------------------------------------------------------------
//-- Openscad Corner reinforcements used in Cool PCB Enclosure (http://www.thingiverse.com/thing:1665075).
//-- Version: 1.0
//-- Jul-2016
//---------------------------------------------------------------
//-- Released under the GPL3 license
//---------------------------------------------------------------

Box_Length = 300;
Box_Width = 100;
Box_Height = 50;
Fillet = 12;
honeycomb_height= 5;
rail_thickness = 3;
Shield_thickness = 2;
  external_XPos = Box_Width - 2*Fillet;
  external_YPos = Box_Height - 2*Fillet;
  external_Pos = square_vertices(external_XPos, external_YPos);

  internal_XPos = Box_Width - 2*Fillet - 2*honeycomb_height - 2*Shield_thickness;
  internal_YPos = Box_Height - 2*Fillet - 2*honeycomb_height - 2*Shield_thickness;
  internal_Pos = square_vertices(internal_XPos, internal_YPos);
  
function square_vertices(x, y) = [[ -x/2, -y/2, 0], [ -x/2, y/2, 0], [x/2, y/2, 0], [x/2, -y/2, 0]];

  difference(){  
     
    for (i = [0 : 3] ){
      translate([external_Pos[i][0], 0, external_Pos[i][1]]) 
        rotate([90, 360/16, 0])
          cylinder(r = Fillet, h = Box_Length - 4*rail_thickness - 2*Shield_thickness, center = true, $fn = 8);
    } //fo
     
    for (i = [0 : 3] ){
      translate([internal_Pos[i][0], 0, internal_Pos[i][1]]) 
        rotate([90, 360/16, 0])
          cylinder(r = Fillet + honeycomb_height/2, h = Box_Length + 1, center = true, $fn = 8);
    } //fo
  } //di
  