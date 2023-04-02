//
// dog food can lid for ~ 3in diam cans
//

//
//      +------------------------------------------------+
//      |                                                |
//      |  +---+    +------------------------+    +---+  |
//      |  |   +----+                        +----+   |  |
//      +--+                                          +--+
//     
//      OL      IL

$fn=64;

rim_dia = 75.2;			/* outer diameter of rim */
can_dia = 73.6;			/* can body dia below rim */
in_dia = 72.0;			/* inner diameter */
rim_hgt_o = 3.3;		/* rim height (outside) */
rim_hgt_i = 3.0;		/* rim height (inside) */

il_r = 2;			/* radius of inner lip */
ol_r = 3;			/* radius of outer lip */
il_z = rim_hgt_i;
ol_z = rim_hgt_o+2;

thick = 2.5;			/* thickness */

e = 0.1;

max_dia = rim_dia + 2*ol_r;

difference() {
     cylinder( r=max_dia/2, h=thick+ol_z);
     translate( [0, 0, thick]) {
	  cylinder( r=rim_dia/2, h=ol_z+e);
     }
}

translate( [0, 0, thick-e]) {
     difference() {
	  cylinder( r=in_dia/2, h=il_z+e);
	  cylinder( r=in_dia/2-il_r, h=il_z+2*e);
     }
}
