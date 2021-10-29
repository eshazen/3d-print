//
// plastic insert for Sara's luggage
// to mount leather belt replacement
//

use <roundedcube.scad>

bx = 60;			/* base length */
by = 25.6;			/* base width */
bz = 3.9;			/* base height */

cx = 43.4;			/* bolt hole spacing */

px = 52;			/* pedestal length */
py = 15.5;			/* pedestal width */
pz = 21;			/* pedestal height */

hx = 30;			/* cutout length */
hy = 12;			/* cutout width */
hz = 2;				/* cutout offset in z */

cr = 1.6;			/* base corner radius */

e = 0.1;

rad=3.3;

$fn = 32;

// base
module base() {
     $fn = 24;
     union() {
	  translate( [-bx/2, -by/2, 0])
	      roundedcube( [bx, by, bz], false, cr, "z");
         translate( [-px/2, -py/2, 0]) 
	      roundedcube( [px, py, pz], false, py/2, "z");
    }
}

module thing() {
     difference() {
	  base();
	  translate( [-cx/2, 0, -e])
	       cylinder( h=pz+2*e, r=rad);
	  translate( [cx/2, 0, -e])
	       cylinder( h=pz+2*e, r=rad);
	  translate( [-hx/2, -hy/2, hz])
	       cube( [hx, hy, px+2*e]);
     }

}

thing();
