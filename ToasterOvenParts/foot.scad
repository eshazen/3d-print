$fn = 32;
e = 0.1;

body_hgt = 20.0;
body_dia = 21.0;
wall_thk = 1.7;
screw_dia = 4.0;
base_thk = 2.2;

difference() {
     cylinder( h=body_hgt, r=body_dia/2);
     translate( [0, 0, base_thk])
	  cylinder( h=body_hgt, r=(body_dia/2)-wall_thk);
     translate( [0, 0, -e])
	  cylinder( h=base_thk+2*e, r=screw_dia/2);
}
