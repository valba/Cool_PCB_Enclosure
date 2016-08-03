//---------------------------------------------------------------
//-- Openscad Rounded poligon used in Cool PCB Enclosure (http://www.thingiverse.com/thing:1665075).
//-- This is an alternative of offset and or minkowski funcions.
//-- IMPORTANT NOTES:
//--   + The coordinate system is mostly center based in order to simplify the integration between different projects involved.
//-- Version: 1.0
//-- Jul-2016
//---------------------------------------------------------------
//-- Released under the GPL3 license
//---------------------------------------------------------------


//---------------------------------------------------------------
//-- MODULES
//---------------------------------------------------------------

module rounded_polig4(box, radius)
{
    length = box[0];
    width = box[1];
    height = box[2];
	vertices = square_vertices(height, width);
    
    A = vertices[0];
	B = vertices[1];
	C = vertices[2];
	D = vertices[3];

	rotate([0, 90, 90]) translate([0, 0, -length/2]) linear_extrude(height = length, $fn = 64)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate(roundvertex(A, B, C, radius)) circle(r = radius, center = true);
		translate(roundvertex(B, C, D, radius)) circle(r = radius, center = true);
		translate(roundvertex(C, D, A, radius)) circle(r = radius, center = true);
		translate(roundvertex(D, A, B, radius)) circle(r = radius, center = true);
	}
}


// polig6 - [x,y,z]
// radius - radius of corners
module rounded_polig6(polig6, height, radius)
{
	A = polig6[0];
	B = polig6[1];
	C = polig6[2];
	D = polig6[3];
	E = polig6[4];
	F = polig6[5];

	linear_extrude(height = height, center= true, $fn = 64)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate(roundvertex(A, B, C, radius)) circle(r = radius, center = true);
		translate(roundvertex(B, C, D, radius)) circle(r = radius, center = true);
		translate(roundvertex(C, D, E, radius)) circle(r = radius, center = true);
		translate(roundvertex(D, E, F, radius)) circle(r = radius, center = true);
		translate(roundvertex(E, F, A, radius)) circle(r = radius, center = true);
		translate(roundvertex(F, A, B, radius)) circle(r = radius, center = true);
	}
}



function square_vertices(x, y) = [[-x/2, -y/2, 0], [-x/2, y/2, 0], [x/2, y/2, 0], [x/2, -y/2, 0]];

function trapezoid_vertex(long_base, height, short_base, base_height) = [[-long_base/2, -height/2, 0], [-long_base/2, - height/2 + base_height, 0], [-short_base/2, height/2, 0], [short_base/2, height/2, 0], [long_base/2, - height/2 + base_height, 0], [long_base/2, -height/2, 0]];

function hexagon_vertices(r) = [[r * cos(2 * 180 * 0 / 6), r * sin(2 * 180 * 0/6), 0], [r * cos(2 * 180 * 1/6), r * sin(2 * 180 * 1/6), 0], [r * cos(2 * 180 * 2/6), r * sin(2 * 180 * 2/6), 0], [r * cos(2 * 180 * 3/6), r * sin(2 * 180 * 3/6), 0], [r * cos(2 * 180 * 4/6), r * sin(2 * 180 * 4/6), 0], [r * cos(2 * 180 * 5/6), r * sin(2 * 180 * 5/6), 0]];

//translate([-30, -30, 0]) rotate([90, 0, 90]) rounded_polig6(trapezoid_vertex(27.5, 19.4, 14, 12.4), 10, 2);
//translate([-30, -30, 0]) rotate([90, 0, 90]) rounded_polig6(hexagon_vertices(20), 10, 5);


//----------------------------------------
//-- FUNCTIONS FOR WORKING WITH VECTORS
//----------------------------------------

//-- Calculate the module of a vector
function mod(v) = (sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]));

//-- Calculate the cros product of two vectors
function cross(u,v) = [
  u[1]*v[2] - v[1]*u[2],
  -(u[0]*v[2] - v[0]*u[2]) ,
  u[0]*v[1] - v[0]*u[1]];

//-- Calculate the dot product of two vectors
function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];

//-- Return the unit vector of a vector
function unitv(v) = v/mod(v);

//-- Return the angle between two vectores
function anglev(u, v) = acos( dot(u,v) / (mod(u)*mod(v)) );

function distance(u, v) = mod(v - u);

function incenter(A, B, C) = (A * distance(B, C) + B * distance(C, A) + C * distance(A, B)) / (distance(B, C) + distance(C, A) + distance(A, B));

function roundvertex(A, B, C, r) = B + (unitv(incenter(A, B, C) - B) * r / sin(anglev(B - A, B - C)/2)); 



//---------------------------------------------------------------
//-- RENDERS
//---------------------------------------------------------------

difference(){
    rounded_polig6(hexagon_vertices(r = 25), 8 + 1, 5);  
    rounded_polig6(trapezoid_vertex(27.5, 19.5, 14, 12.5), 10, 2);
}      


