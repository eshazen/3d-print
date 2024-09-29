
$fn = 64;
e = 0.1;

function mm(x) = (x)*25.4;

prong_x = 8.7;
prong_y = 12;
prong_z = 20;

plate_x = 13;
plate_y = 42;
plate_z = 1.6;

plate_ang = 30;

prong_dy = (plate_y/2-prong_y/2)-2;

mount_x = mm(1.5);
mount_y = mm(2.5);
mount_z = 2.4;
mount_dy = -(mount_y/2+plate_y/2-e);

hole_dia = 4.5;

module hole_at(x,y) {
     translate( [x, y, -e])
	  cylinder( h=10, d=hole_dia);
}

module mount_top() {
     translate( [-mount_x/2, -mount_y+5, 0]) {
	  difference() {
	       cube( [mount_x, mount_y, mount_z]);
	       hole_at( mount_x*0.25, mount_y*0.25);
	       hole_at( mount_x*0.75, mount_y*0.75);
	  }
     }
}

module plate() {
     translate( [-plate_x/2, -plate_y/2, 0])
	  cube( [plate_x, plate_y, plate_z]);
     translate( [-prong_x/2, -prong_y/2+prong_dy, plate_z-e])
	  cube( [prong_x, prong_y, prong_z]);
	  translate( [0, -plate_y/2, 0])
     rotate( [0, 0, plate_ang])
	  mount_top();
}


plate();

