//
// fuse/switch bracket
//



wid = 75;
len = 55;
thk = 1.6;
wall = 15;

e = 0.1;

hole_dia = 4.0;

module hole( x, y, dia=4) {
  translate( [x, y, -e])
    cylinder( h=thk+2*e, d=dia);
}

module slot( x, y, wid, hgt) {
  translate( [x, y, -e])
     cube( [wid, hgt, thk+2*e]);
}

module righty( w, h, t) {
  linear_extrude( height=t, convexity=10) {
       polygon( [ [0,0], [w, 0], [0, h], [0, 0]]);
  }
}

module bracket() {
  difference() {
    cube( [wid, len, thk]);	/* plate */
    hole( 10, 14);
    hole( 10+40, 14);
    slot( (40-29)/2+10, 14-21/2, 29, 21);
    hole( 65, 14, 6.5);
    hole( 30, 40, 15);		/* fuse holder */
    translate( [55, 3, thk/2])
	 linear_extrude( height=thk) {
	     text( "OFF", size=6);
    }
    translate( [55, 20, thk/2])
	 linear_extrude( height=thk) {
	     text( "ON", size=6);
    }
    
		 
  }
  difference() {
    translate( [0, 0, -wall])
     cube( [wid, thk, wall+e]);
    rotate( [90, 0, 0])
      translate( [0, 0, -thk]) {
	 hole( 7, -wall/2);
	 hole( wid-7, -wall/2);
      }
  }
  translate( [0, 0, e])
  rotate( [0, 90, 0]) {
       righty( wall, wall, thk);
       translate( [0, 0, wid-thk])
	           righty( wall, wall, thk);
  }
}

bracket();
