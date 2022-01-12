//
// test print for 3D printer diagnosis

width = 160;
height = 160;

thick = 1.6;
radius = 5;

e = 0.1;


$fn=32;

module disc( r, t) {
     cylinder( h=t, r=r);
}


module plate( w, h, r, t) {
     disc( r, t);
     translate( [w, 0, 0])  disc( r, t);
     translate( [w, h, 0]) disc( r, t);
     translate( [0, h, 0]) disc( r, t) ;
     translate( [-r, 0, 0])
	  cube( [w+2*r, h, t]);
     translate( [0, -r, 0])
	  cube( [w, h+2*r, t]);
}

module plate_hole() {
     difference() {
	  plate( width, height, radius, thick);
	  translate( [thick/2, thick/2, -e])
	       plate( width-thick, width-thick, radius-thick, thick+2*e);
     }
}


plate_hole();
translate( [-radius/2, -radius/2, 0]) rotate( [0, 0, 45]) cube( [width*1.414+1.5*radius, thick, thick]);
translate( [-radius/2, height+radius/2, 0]) rotate( [0, 0, -45]) cube( [width*1.414+1.5*radius, thick, thick]);


