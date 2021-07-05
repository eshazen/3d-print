//
// soap tray with razor rack
//

include <soap_tray.scad>

// (all dim in mm)
head_wid = 55;
head_hgt = 25;
head_dep = 10;

handle_hgt = 127;
handle_wid = 17;

module razor_plan() {
        polygon( points = [ [0,0] ,
        		    [-handle_wid/2, 0],
        		    [-6, -34],
        		    [-12, -102],
        		    [-5, -127],
        		    [5, -127],
        		    [12, -102],
        		    [6, -34],
        		    [handle_wid/2, 0],
        		    [0,0] ]);
}     

module razor() {
     color("teal") {
     translate( [-head_wid/2, -head_hgt/2, -5])
	  rotate( [25, 0, 0])
	  cube( [head_wid, head_hgt, head_dep]);
     translate( [0, -head_hgt/2, 0])
          linear_extrude( height = 10) { razor_plan(); }
     }
}


rack_len = 30;

module rack() {
     union() {
	  cube( [5, 7, rack_len]);
	  translate( [0, 3.5, rack_len])
	  rotate( [0, 90, 0])
	  cylinder( h=5, d=7);
     }
}
     

rotate( [ 90, 0, 0]) {
     translate( [ 22, 25, 0])
     for( i=[0:2]) {
	  translate( [i*60, 0, 0]) {
//	       translate( [0, 0, 8]) razor();
	       translate( [-15, -25, 0]) {
		    rack();
		    translate( [25, 0, 0])
			 rack();
	       }
	  }
     }
}
