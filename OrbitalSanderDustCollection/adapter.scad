//
// adapter for Master Mechanic orbital sander bag mount point to 2-1/4 inch hose
//

mm = 25.4;
e = 0.1;
$fn = 64;

module rounded_rectangle( width, length, radius_corner ) {

     w = width - 2*radius_corner;
     l = length - 2*radius_corner;

     translate( [ radius_corner, radius_corner, 0 ] )
	  minkowski() {
	  polygon( points = [[0,0],[w,0],[w,l],[0,l],[0,0]]); 
	  circle( radius_corner );
     }
}

// dimensions of bag mount snout

s_x2 = 2.38*mm;			/* width of outside of snout */
s_y2 = 1.35*mm;			/* height of outside of snout */
s_x1 = 1.975*mm;		/* width of inside of snout */
s_y1 = 0.975*mm;		/* height of inside of snout */

s_x3 = 1.5*mm;			/* size of inner opening */

s_r1 = 0.150*mm;		/* inner snout curve radius */
s_r2 = 0.375*mm;		/* outer snout curve radius */

s_hole_dx = 1.875*mm;		/* mounting hole spacing */

s_z = 0.25*mm;			/* length of snout */
wall = 1.6;

hose_dia = 2.25*mm;		/* hose OD (it's tapered a bit) */
hose_len = 1.5*mm;		/* length of hose connection */

module hole_at( x, y, dia) {
     translate( [x, y, -2])
	  cylinder( d=dia, h=30);
}

sm_thk = 0.125*mm;

module snout_base() {
     linear_extrude( height=s_z) rounded_rectangle( s_x2, s_y2, s_r2);
     translate( [0, 0, s_z-e]) {
	  linear_extrude( height=sm_thk) rounded_rectangle( s_x2, s_y2, s_r2);
	  translate( [s_x2/2, s_y2/2, 0])
	       cylinder( h=sm_thk, d=hose_dia+2*wall);
     }
}

module snout() {
     ho = (s_x2-s_hole_dx)/2;
     difference() {
	  snout_base();
	  hole_at( ho, s_y2/2, 0.15*mm);
	  hole_at( s_x2-ho, s_y2/2, 0.15*mm);
	  translate( [(s_x2-s_x1)/2, (s_y2-s_y1)/2, -e])
	       linear_extrude( height=s_z+2*e) rounded_rectangle( s_x1, s_y1, s_r1);
	  translate( [(s_x2-s_x3)/2, (s_y2-s_y1)/2, s_z-2*e])
	       linear_extrude( height=sm_thk+2*e) rounded_rectangle( s_x3, s_y1, s_r1);
     }
}

module tube( leng) {
     difference() {
	  cylinder( h=leng, d=hose_dia+2*wall);
	  translate( [0, 0, -e])
	       cylinder( h=leng+2*e, d=hose_dia);
     }
}

translate( [-s_x2/2, -s_y2/2, 0])
snout();
translate( [0, 0, s_z+sm_thk-e]) tube( hose_len);
