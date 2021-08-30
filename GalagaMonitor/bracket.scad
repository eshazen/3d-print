//
// monitor cover mounting bracket
//

$fn=32;

module bracket() {
     difference() {
	  cube( [24, 16, 4.8]);
	  translate( [24-6.5, 16/2, -0.1])
	       cylinder(h=5, d=4.6);
	  wedge();
	  cut();
	  step();
     }
}

module wedge() {
     rotate( [90, 0, 0]) {
	  translate( [0, 0, -17])
	  linear_extrude( height=18 ) {
	       polygon( [ [10, 4.9], [24.1, 1.5], [24.1, 4.9]] );
	  }
     }
}

module cut() {
     translate( [11.3, 1.6, 1.5])
	  cube( [13, 12.8, 4]);
}

module step() {
     translate( [-0.1, -0.1, -0.1])
	  cube( [10.1, 17, 3.3]);
}

bracket();



