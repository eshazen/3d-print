//
// Support bracket for soap dish on towel rack
// towel bar is 3/4 in square, rotated 45 degrees
// closest point is 1-3/4 in from wall
//
// Built a few 6/3/21, all OK
//

function mm(i) = (i*25.4);
function inch(m) = (m/25.4);

bar_size = 0.75;
bar_distance = 1.75;
bar_diag = sqrt( (0.75*0.75)/2);

bracket_thickness = 0.125;	/* 1/8 inch */

// draw the bar and wall for reference
// origin is on the wall in the center of the bar
wall_size = 24;			/* arbitrary wall size */
wall_thick = 0.5;

module wall() {
     translate( [-wall_size/2, -wall_size/2, -wall_thick])
	  %cube( [wall_size, wall_size, wall_thick]);
}

// draw towel bar
bar_len = 17;
module bar() {
     translate( [-bar_len/2, 0, bar_distance])
	  rotate( [45, 0, 0])
	  %cube( [bar_len, bar_size, bar_size]);
}

// bracket
bracket_overhang = 0.5;		// bracket overhang beyond bar
bracket_height = 3.0;		// bracket height
bracket_top = 1.5;
bracket_foot = 0.75;

bracket_width = bar_distance+bar_diag*2+bracket_overhang;
echo( "width=", bracket_width);

// draw a flat floor plan for the bracket
module bracket_plan() {
polygon( points = [ [0,0], [bracket_foot,0],
		   [bar_distance, bracket_height],
		   [bar_distance+bar_diag, bracket_height+bar_diag],
		   [bar_distance+bar_diag*2, bracket_height],
		   [bar_distance+bar_diag*2, bracket_height-0.5],
		   [bracket_width, bracket_height-0.5],
		   [bracket_width, bracket_height+bracket_top],
		   [0, bracket_height+bracket_top],
//		   [bar_distance-bracket_foot, bracket_height+bracket_top],
		   [0,0] ] );
}

peg_diam=inch(10);

$fn = 32;

module peg_hole() {
     translate( [ 0, 0, -0.1]) {
	  cylinder( h=bracket_thickness+0.3, d=peg_diam);
	  translate( [-peg_diam/2, 0, 0])
	  cube( [peg_diam, 2, bracket_thickness+0.3]);
     }
}

module open_hole(dia) {
     translate( [ 0, 0, -0.1]) {
	  cylinder( h=bracket_thickness+0.3, d=dia);
     }
}


module hole_at( x, y, dia) {
     translate( [ x, y, -0.1]) {
	  cylinder( h=bracket_thickness+0.3, d=dia);
     }
}

module hole_array( x0, y0, dx, dy, nx, ny, dia) {
     for( ix=[0:nx-1]) for( iy=[0:ny-1]) hole_at( x0+dx*ix, y0+dy*iy, dia);
}



module bracket() {
     translate( [0, -(bracket_height), 0]) rotate([ 0, 270, 0]) {
	  difference() {
	       linear_extrude( height=bracket_thickness) { bracket_plan(); };
	       translate( [ 1, bracket_height+bracket_top-inch(7), 0]) {
		    peg_hole();
		    translate( [ inch(50), 0, 0])
			 peg_hole();
	       }

//	       hole_array( 0.2, 0.25, 0.4, 0.4, 2, 12, 0.3);
//	       hole_array( 0.95, 0.85, 0.4, 0.4, 1, 8, 0.3);
//	       hole_array( 1.35, 1.55, 0.4, 0.4, 1, 7, 0.3);
//	       hole_array( 1.75, 2.2, 0.4, 0.4, 1, 5, 0.3);
//	       hole_array( 2.15, 2.9, 0.4, 0.4, 1, 4, 0.3);
//	       hole_array( 2.55, 3.5, 0.4, 0.4, 1, 2, 0.3);
//
//	       hole_array( 3.4, 3.6, 0.4, 0.4, 1, 2, 0.3);
//	       hole_array( 3.8, 2.9, 0.4, 0.4, 1, 4, 0.3);


	       for( i = [0:3]) {
		    dia = 0.35 + 0.25*i;
		    dist =  pow(1.55,i);
		    translate( [bracket_foot/2-0.3 + dist/4,
				dist-0.5])
			 open_hole(dia);
	       }


//	       hole_at( 0.2, 0.2, 0.2);
//	       hole_at ( 0.6, 0.2, 0.25);
//	       hole_at( 0.2, 0.77, 0.2);
//	       hole_at( 0.8, 0.55, 0.3);
//	       hole_at( 1.1, 1, 0.27);
//	       hole_at( 0.25, 1.5, 0.35);
//	       hole_at( 1, 1.3, 0.2);
//	       hole_at( 1.3, 1.4, 0.3);
//	       hole_at( 0.15, 1.05, 0.2);
//	       hole_at( 0.23, 1.95, 0.3);
//	       for( i=[0:4] ) hole_at( 0.25, 2.4+i*0.45, 0.35);
//	       for( i=[0:6] ) hole_at( 0.57, 2.4+i*0.3, 0.2);
//	       for( i=[0:7] ) hole_at( 1.45+i*0.16, 1.7+i*0.32, 0.25);
	  }
     }
}

// wall();
// bar();
rotate( [0, 90, 0])
scale( [25.4, 25.4, 25.4])
bracket();
