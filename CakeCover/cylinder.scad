//
// cake cover - cylinder section
//

pmax = 220;			/* max print size */

mm = 25.4;			/* mm/inch */
$fn = 128;

// real dims
id = 203;			/* close to 8 inches */
high = 2.5*mm;
join = 10;			/* shiplap joint height */

// // for testing
// id = 20;			/* close to 8 inches */
// high = 15;
// join = 5;

taper = 5;

wall = 2;			/* wall thickness */
gap = 0.2;			/* non-interference for joint */

e = 1;

module cyl() {
     difference() {
	  // main cylinder and top joint
	  union() {
	       // main cylinder
	       cylinder( h=high-join, d=id+2*wall);
	       // top lip
	       translate( [0, 0, high-join-e])
		    cylinder( h=join+e, d=id+wall-2*gap);
	  }
	  translate( [0, 0, -e]) {
	       cylinder( h=high+2*e, d=id);
	       // shelf for flange to fit it
	       cylinder( h=e+join, d=id+wall);
	       // taper
	       translate( [0, 0, e+join-0.01])
		    cylinder( h=taper, d2=id, d1=id+wall);
	  }
     }
}

pthick = 2;
pdiam = 210;

module plat() {
     difference() {
	  union() {
	       cylinder( h=pthick, d=pdiam);
	       cylinder( h=pthick*2, d=id+2*wall-3*e);
	  }
	  translate( [0, 0, pthick])
	       cylinder( h=pthick-3, d=id-10);
	  // cut out to speed fab
//	  translate( [0, 0, -5])
//	       cylinder( h=20, d=pdiam-10);
     }
}

module top() {
     union() {
	  difference() {
	       cylinder( h=pthick*4, d=id+2*wall);
	       translate( [0, 0, pthick])
		    cylinder( h=pthick*4, d=id+wall);
	       
	  }
	  difference() {
	       cylinder ( h=pthick*2, d=id-e);
	       translate( [0, 0, pthick])
		    cylinder( h=pthick*4, d=id-5);
	  }
     }
}


module drawit() {
//     color("blue") plat();
//     translate([0,0,3]) cyl();
//     translate( [0, 0, high+2.5])
//	  rotate( [180, 0, 0])
//	  cyl();
     top();
}

// // cross-section
// difference() {
//      drawit();
//      translate( [-id/2-5, 0, -e])
//      cube( [id+25, 2*id+25, high+20]);
// }

drawit();
