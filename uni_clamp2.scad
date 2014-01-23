//All Units are in mm, Import as STL with Unit=mm
R=1.9; //Radius of Pipe in Inches
R_mm=R*25.4; //Converted to mm!
S=1.2; //Determines Strength of Clamp in Percentage


//Pipe Model for Visualization
//translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);

hc=union();
{
minkowski() //Fillet
{
	union()
	{
		cube([R_mm*S,R_mm/2*S, R_mm*S]);
		translate([R_mm*S/2,R_mm*S/2,0]) cylinder(R_mm*S,R_mm*S/2,R_mm*S/2);
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Comment to Speed Up Compilation
}

minkowski() //Fillet
{
	difference() //Hard Chamfer
	{
		translate([-R_mm/4,0,(R_mm/2)-(R_mm*5/48)]) cube([R_mm/2,R_mm,R_mm*5/12]);
		translate([-R_mm/4,R_mm*7/8,(R_mm/2)-(R_mm*5/24)]) rotate([0,0,22]) cube([R_mm/2,R_mm,2*R_mm*5/12]);
	}
	sphere([R_mm/2,R_mm,R_mm*5/12]); //Comment to Speed Up Compilation
}
}

difference() //Pipe Hole
{
hc;
//Pipe Model for Visualization
translate([R_mm*S/2,R_mm*S/2,-R_mm*6]) cylinder(R_mm*10,R_mm/2,R_mm/2);
}
