//
// new bracket for etsy cupholder
//
$fn = 32;
e = 0.1;
es = 0.05;

passenger = 0;			/* 0 for driver, 1 for passenger side */

// generate a profile for an isosceles trapezoid
// with an arch on the top
// w1 is base width; w2 is top width, h is height
// r is arch radius, ry is center point y coord
// (0,0) is center of base

module arch_profile(r,ry,w1,w2,h) {

     union() {
	  polygon( points = [ [-w1/2, 0], [w1/2, 0],
			      [w2/2, h+e], [-w2/2, h+e]], convexity = 2);
	  // cut the part of the circle we want
	  intersection() {
	       translate( [0, h-ry, 0])
		    circle( r=r);
	       polygon( points = [ [-w2/2-1, h], [w2/2+1, h],
				   [w2/2+1, h+r], [-w2/2-1, h+r] ], convexity = 2);
	  }
     }
}

//
// make a scaled arch profile with offset for smoothing
//
// so with w1=25.4 and w2=19 we measure
//         w1=27.0 and w2=21.2
//    diff:    1.6         2.2
// new:       23.8        16.8

module scaled_arch_profile(s) {
//     arch_profile( 11.6-s, 6.66, 25.4-s*2, 19-s*2, 43.2);
     arch_profile( 10.6-s, 6.66, 23.8-s*2, 16.8-s*2, 43.2);     
}

//
// create the arch-shaped bit which mates with the cupholder
// center at base of arch with Z=0 on cup-facing plane
//
// it has an s-curved profile with height 5 (each S radius is 5/4)

s_height = 5.0;
s_rad = s_height/4;
a_nstep = 8;
a_step = 90/a_nstep;			/* angle step */

module mating_arch() {

     echo("Quadrant 1");
     // top quadrant
     for( a=[90:-a_step:0]) {
	  x = cos(a)*s_rad;
	  y = sin(a)*s_rad;
	  echo("a=",a," x=",x," y=",y);
	  if( a != 90) {
	       translate( [0, 0, y-s_rad]) {
		    h = abs(y - sin(a+a_step)*s_rad);
		    linear_extrude( height=h+es) {		    
			 scaled_arch_profile( -x);
		    }
	       }
	  }
	  y0=y;
     }

     echo("Quadrant 2");
     // next quadrant
     for( a=[270:a_step:360]) {
	  x = cos(a)*s_rad;
	  y = sin(a)*s_rad;
	  if( a != 270) {
	       translate( [0, 0, y-s_rad]) {
		    h = abs(y - sin(a+a_step)*s_rad);
		    linear_extrude( height=h+es) {		    
			 scaled_arch_profile( -x);
		    }
	       }
	  }
     }

     echo("Quadrant 3");
     // next quadrant
     for( a=[90:a_step:180]) {
	  x = cos(a)*s_rad;
	  y = sin(a)*s_rad;
	  if( a != 270) {
	       translate( [0, 0, y-s_rad*3]) {
		    h = abs(y - sin(a+a_step)*s_rad);
		    linear_extrude( height=h+es) {		    
			 scaled_arch_profile( -x);
		    }
	       }
	  }
     }

     echo("Quadrant 4");
     // next quadrant
     for( a=[180:a_step:270]) {
	  x = cos(a)*s_rad;
	  y = sin(a)*s_rad;
	  if( a != 270) {
	       translate( [0, 0, y-s_rad*3]) {
		    h = abs(y - sin(a+a_step)*s_rad);
		    linear_extrude( height=h+es) {		    
			 scaled_arch_profile( -x);
		    }
	       }
	  }
     }


     
}


//
// side profile
//
module side_profile() {
     polygon( points = [ [0,0], [51, 0], [55.2, 17],
			 [55.2-7, 15.3], [55.2-7, 13.3],
			 [0, 5]], convexity=3);
}

module main_body() {
     linear_extrude( height=30) {
	  side_profile();
     }
}

module body_arch() {
     mating_arch();
     translate( [-15, 51, -4.8])
	  rotate( [270, 0, 270])
	  main_body();
}

rota = 104;

// cut bottom
module body_cut() {
     difference() {
	  translate( [0, 0, -1.3]) rotate( [rota, 0, 0]) body_arch();
	  translate( [-50, -50, -10])
	       cube( [100, 100, 10]);
     }
}

// boss
boss_h = 5;			/* boss height on high side */
boss_h1 = 3;			/* boss height on low side */

boss_d = 14;			/* really it's oval */
boss_l = 16.2;			/* this is the long axis */
boss_o = (boss_l-boss_d)/2;
boss_y = 20;			/* Y position */

// boss slant angle
boss_slant = atan( (boss_h-boss_h1)/(boss_l));


// oval boss
module bossy() {
     translate( [boss_o, boss_y, -boss_h])
	  cylinder( d=boss_d, h=boss_h+e);
     translate( [-boss_o, boss_y, -boss_h])
	  cylinder( d=boss_d, h=boss_h+e);
}

// oval boss with angle cutoff
module boss() {
     difference() {
	  bossy();
	  if( passenger) {
	       translate( [-boss_l/2, boss_y-boss_l/2, -boss_h-20])
		    rotate( [0, -boss_slant, 0])
		    cube( [20, boss_l, 20]);
	  } else {
	       translate( [boss_l/2, boss_l+boss_y-boss_l/2, -boss_h-20])
		    rotate( [0, -boss_slant, 180])
		    cube( [20, boss_l, 20]);
	  }
     }
}

module body_boss()
{
     boss();
     translate( [0, 0, 18])
	  rotate( [-114, 0, 0])
	  body_cut();
}

// mounting hole
module body_hole() {
     difference() {
	  body_boss();
	  translate( [0, boss_y, -boss_h+2.5])
	       cylinder( d=12, h=50);
	  translate( [0, boss_y, -10])
	       cylinder( d=4.7, 50);
     }
}

rotate( [114, 0, 0])
body_hole();
