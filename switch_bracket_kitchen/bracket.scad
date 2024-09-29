
$fn=32;
e=0.1;

function mm(x)=x*25.4;

sw_wid = 21;
sw_len = 15;

co_wid = 19.4;
co_len = 12.9;

thk = 1.6;

b_wid = mm(1.75);
b_len = mm(0.8);
b_hgt = mm(1);

hole_dia = mm(0.15);
hole_off = mm(0.25);

module side() {
     linear_extrude( height=thk) {
	  polygon( points = [[0,0], [b_hgt-5,0], [0, b_len]]);
     }
}

module bracket() {
     difference() {
	  cube( [b_wid, b_len, thk]);
	  translate( [(b_wid-co_wid)/2, (b_len-co_len)/2, -e])
	       cube( [co_wid, co_len, thk+2*e]);
     }
     rotate( [90, 0, 0]) {
	  translate( [0, 0, -thk])
	  difference() {
	       cube( [b_wid, b_hgt, thk]);
	       translate( [ hole_off, b_hgt/2, -e])
		    cylinder( h=thk+2*e, d=hole_dia);
	       translate( [ b_wid-hole_off, b_hgt/2, -e])
		    cylinder( h=thk+2*e, d=hole_dia);
	  }
     }
     rotate( [0, -90, 0]) {
	  translate( [0, 0, -thk]) side();
	  translate( [0, 0, -b_wid]) side();
     }
}

bracket();
