//
// Vanity bracket
//
//


len = 0.5;			/* length in X */

hole_dia = 0.130;		/* 4-40 clearance */

nut_dia = 0.255;		/* hex cutout for 4-40 nut */
nut_clear = 0.300;		/* clearance for nut */
nut_thick = 0.100;		/* nut thickness */

$fn=64;

// triangular prism from web
module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}


// experimentally, this seems to produce correct output
// for the cura slicer
scal = 0.254;


scale( [scal, scal, scal]) {
  difference() {
       cube( [len, 1, .5]);
       translate( [-0.1, 0.2, 0.125])
  	  cube( [len + 0.2, 0.235, .5]);


       translate( [len/2, 0.8, -0.1]) {
	  $fn = 6;
	  cylinder( h=nut_thick+0.1, d=nut_clear);
       }

       translate( [len/2, 0.8, -0.1]) {
  	  cylinder( h=1.2, d=hole_dia);
	  translate( [0, 0, 0.5])
	  cylinder( h=nut_thick+0.1, d=nut_clear);
       }
  }
  
  rotate( [0, 0, 270])
      prism( len, .25, .5);
      translate( [len, 1, 0])
  rotate( [0, 0, 90])
      prism( len, .25, .5);
}
