//
// cyclindrical chair support for
// broken hydraulic lift Staples chair
//
// two half-cylinders with some interlocking bits


id = 28;
hgt = 98;
wall = 3;

jag = 3;

e = 0.1;

$fn=128;

// basic hollow cylinder
module cylin() {
     difference() {
	  cylinder( h=hgt, r=id/2+wall);
	  translate( [0, 0, -e])
	  cylinder( h=hgt+2*e, r=id/2);
     }
}

// cutting surface (drawn as if in X-Z plane)

module cutpoly(flip) {
     polygon( points = [ [-jag, -e], [-jag, hgt/5], [jag, hgt/5],
			 [jag, 4*hgt/5], [-jag,4*hgt/5], [-jag, hgt+2*e],
			 [flip*id, hgt+2*e], [flip*id, -e], [-jag, e]]);
}

module cutsolid(flip) {
     translate( [0, id/2+e+wall, -e])
	  rotate( [90, 0, 0])
	  linear_extrude( height=id+2*(wall+e)) { cutpoly(flip); }
}

module left() {
     difference() {
	  cylin();
	  cutsolid(1);
     }
}


module right() {
     difference() {
	  cylin();
	  cutsolid(-1);
     }
}


rotate( [0, 270, 0]) {
     left();
}

rotate( [0, 90, 0])
     translate( [0, id+10, -hgt])
right();

