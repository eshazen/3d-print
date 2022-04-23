

rod_r1 = (0.75*25.4)/2;
rod_r0 = rod_r1 - 2;
rod_len = (8*25.4);

wall_t = 2;

e = 0.1;

module rod() {
     difference() {
	  union() {
	       difference() {
		    cylinder( h=rod_len, r=rod_r1);
		    translate( [0, 0, -e]) cylinder( h=rod_len+2*e, r=rod_r0);
	       }
	       for( i = [0 : (rod_len-wall_t)/8 : rod_len-wall_t])
		    translate( [0, 0, i])
			 cylinder( h=wall_t, r=rod_r1);
	  }
	  translate( [0, 0, -e]) {
	       translate( [-rod_r1-e, 0, 0])
		    cube( [ (rod_r1+3)*2, rod_r1+e, rod_len+2*e]);
	  }
     }
}

rotate( [90, 0, 45])
rod();
