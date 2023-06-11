//
// funnel for filling spice jars
//


e = 0.1;
$fn = 64;

topd = 70;			/* top funnel diam */
neck = 28;			/* neck diam */
toph = 32;			/* top funnel height */
neckh = 15;			/* neck height */

w = 1.6;				/* wall thickness */


module funnel() {

     difference() {
	  cylinder( h=32, d1=neck, d2=topd);
	  translate( [0, 0, -e])
	       cylinder( h=toph+2*e, d1=neck-2*w, d2=topd-2*w);
     }

     translate( [0, 0, -neckh]) {
	  difference() {
	       cylinder( h=neckh+e, d=neck);
	       translate( [0, 0, -e])
		    cylinder( h=neckh+4*e, d=neck-2*w);
	  }
     }
}

rotate( [180, 0, 0])
funnel();
