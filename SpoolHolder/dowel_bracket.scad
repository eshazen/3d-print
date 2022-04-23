$fn=32;

body_x0 = 90;
body_x1 = 25;
body_y = 50;
thick = 4;

wall = thick + 2;

body_dx = body_x0-body_x1;

screw_r = 5/2;

bracket_z = 12.7+thick;

e = 0.1;

dowel_r = (0.77 * 25.4)/2;

module dowel_hole() {
     linear_extrude( height=thick+2*e) {
     polygon( points =[  [-dowel_r, -dowel_r], [dowel_r, -dowel_r],
			 [dowel_r, dowel_r], [-dowel_r, dowel_r],
			 [-dowel_r, -dowel_r] ]);
     }
//     cylinder( h=thick+2*e, r=dowel_r);
}

module body_plan() {
     difference() {
	  polygon( points = [ [0,0], [body_x0,0],
			      [body_dx/2+body_x1, body_y],
			      [body_dx/2, body_y],
			      [0,0] ]);
//	  polygon( points = [ [wall, wall],
//			      [body_x0-wall, wall],
//			      [body_dx/4+((body_x1+body_x0)/2)-wall, body_y/2],
//			      [body_dx/4+wall, body_y/2],
//			      [wall, wall], ]);
			      
     }
}


module body() {
     difference() {
	  linear_extrude( height=thick) body_plan();
	  translate( [body_x0/2, body_y-dowel_r-5, -e])
	       dowel_hole();
     }
}


module bracket_plan() {
     difference() {
	  cube( [body_x0, bracket_z, thick]);
	  translate( [bracket_z/2, (bracket_z+thick)/2, -e])
	       cylinder( r=screw_r, h=thick+2*e);
	  translate( [body_x0-bracket_z/2, (bracket_z+thick)/2, -e])
	       cylinder( r=screw_r, h=thick+2*e);
     }
}

body();
translate( [0, e, 0])
rotate( [90, 0, 0]) bracket_plan();





