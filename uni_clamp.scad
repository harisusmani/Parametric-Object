//All Units are in mm, Import as STL with Unit=mm

R=1.9; //Radius of Pipe in Inches [2.375,1.9,1.660,1.315]
R_mm=R*25.4; //Converted to mm!
S=1.2; //Determines Strength of Clamp in Percentage-FIXED!
T=3; //Space for Tightening [0:5]
M=5; //Nut Type M[4,5,6]

/////////////////////////////////////////////////////////////////////////////
//Hexagonal Module from shapes.scad, http://svn.clifford.at/openscad/trunk/libraries/shapes.scad by Catarina Mota
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
/////////////////////////////////////////////////////////////////////////////

//Pipe Model for Visualization
//translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);

difference() //Pipe Hole
{
union()
{
minkowski() //Fillet
{
	union()
	{
		cube([R_mm*S,R_mm/2*S, R_mm*S]); //Main Body
		translate([R_mm*S/2,R_mm*S/2,0]) cylinder(R_mm*S,R_mm*S/2,R_mm*S/2); //Curved Edge
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Fillet Object
}

minkowski() //Fillet
{
	difference() //Hard Chamfer
	{
		translate([-R_mm/4,0,(R_mm/2)-(R_mm*5/48)]) cube([R_mm/2,R_mm,R_mm*5/12]);
		translate([-R_mm/4,R_mm*7/8,(R_mm/2)-(R_mm*5/24)]) rotate([0,0,22]) cube([R_mm/2,R_mm,2*R_mm*5/12]);
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Fillet Object
}
}
	union()
	{
		translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);//Pipe
		translate([-R_mm,R_mm*S*5/12,-R_mm]) cube([R_mm*2,R_mm/(15-T),R_mm*4]);//Tightning Space
		translate([-R_mm/9,R_mm*2,(R_mm*S/2)]) rotate([90,0,0]) cylinder((R_mm*4),M/2,M/2); //Screw Space
		if (M==4) translate([-R_mm/9,R_mm*1.3,(R_mm*S/2)]) rotate([90,0,0]) hexagon(7.66,50); //NUTS
		if (M==5) translate([-R_mm/9,R_mm*1.3,(R_mm*S/2)]) rotate([90,0,0]) hexagon(8.79,50);
		if (M==6) translate([-R_mm/9,R_mm*1.3,(R_mm*S/2)]) rotate([90,0,0]) hexagon(11.05,50);
	}
}