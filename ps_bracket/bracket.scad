//
// power supply/disk bracket for retro-z80
//

wid = 140;
len = 70;
thk = 1.6;
wall = 5;

e = 0.1;

hole_dia = 4.0;

$fn = 32;

module hole( x, y) {
  translate( [x, y, -e])
    cylinder( h=thk+2*e, d=hole_dia);
}

module bracket() {
  difference() {
    cube( [wid, len, thk]);	/* plate */
    hole( 7, 55+6.5);		/* holes */
    hole( 127,55+6.5);
    hole( 127-102, 6.5);
    hole( 127, 6.5);
  }
  translate( [0, 0, -e]) {	/* walls, stiffener */
       cube( [wid, thk, wall+e]);
       translate( [0, len-thk, 0])
  	  cube( [wid, thk, wall+e]);
       cube( [thk, len, wall]);
       translate( [wid-thk, 0, 0])
  	  cube( [thk, len, wall]);
       translate( [wid/2, 0, 0])
	  cube( [thk, len, wall]);
  }
//  translate( [0, 26, -wall])
//       cube( [wid, thk, wall+e]);	    
}

bracket();
