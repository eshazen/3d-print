
width = 300;
length = 550;
height = 90;

front_height = 60;

bottom_thick = 6;
wall_thick = 4;

e = 0.1;

module box() {

     cube( [width, length, bottom_thick]);
     cube( [wall_thick, length, height]);
     translate( [width-wall_thick, 0, 0])
	  cube( [wall_thick, length, height]);
     translate( [0, length-wall_thick, 0])
	  cube( [width, wall_thick, height]);
     difference() {
	  cube([width, wall_thick, front_height]);
	  translate( [width/4, -e, front_height/2]) {
	       translate( [0, 0, -front_height/4])
		    cube( [width/2, wall_thick+2*e, front_height/2]);
	       rotate( [-90,0,0]) {
		    cylinder( h=wall_thick+2*e, r=front_height/4);
		    translate( [width/2, 0, 0])
			 cylinder( h=wall_thick+2*e, r=front_height/4);
	       }
	  }
     }
}

box();

	  
