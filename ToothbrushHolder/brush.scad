//
// toothbrush holder
// wall-mount
//

use <chamfercyl.scad>

sizeX = 200;
sizeY = 10;
sizeZ = 40;

tall = 100;

mountZ = 6;
mountY = 50;

topDia = 20;
botDia = 10;

holes = 6;

holespc = sizeX/(holes+1);


module rack() {
     difference() {
	  cube( [sizeX, sizeY, sizeZ]);
	  for( i=[0:holes-1]) {
	       translate( [(i+1)*holespc, 0, sizeZ/2])
		    rotate( [270, 0, 0])
		    chamfercyl( topDia/2, sizeY, 2.5, 2.5);
	  }
     }
     translate( [0, -tall, 0]) {
	  difference() {
	       cube( [sizeX, sizeY, sizeZ]);
	       for( i=[0:holes-1]) {
		    translate( [(i+1)*holespc, 0, sizeZ/2])
			 rotate( [270, 0, 0])
			 chamfercyl( botDia/2, sizeY, 2.5, 2.5);
	       }
	  }
     }
	       
     
}

anglX = 10;
anglY = 20;

module angl() {
     rotate( [0, -90, 0])
	  linear_extrude( height=mountZ) {
	  polygon( points=[ [0,0], [anglX,0], [0,anglY], [0,0]]);
     }
}

 translate( [0, -tall, 0])
 difference() {
      cube( [sizeX, mountY+tall, mountZ]);
      translate( [mountZ, sizeY, -0.1])
 	  cube( [sizeX-2*mountZ, tall-sizeY, mountZ+0.2]);
      translate( [mountZ, tall+sizeY, -0.1])
 	  cube( [sizeX-2*mountZ, mountY-2*sizeY, mountZ+0.2]);
//     translate( [holespc/2, tall+mountY-5, 0])
//	  chamfercyl( 2.5, mountZ, 1, 1);
      translate( [sizeX-holespc/2, (tall+mountY)-5, 0])
 	  chamfercyl( 2.5, mountZ, 1, 1);
 }
translate( [0, 0, mountZ] )  rack();

translate( [mountZ, sizeY, mountZ])  angl();
translate( [sizeX, sizeY, mountZ])  angl();
translate( [mountZ, -tall+sizeY, mountZ])  angl();
translate( [sizeX, -tall+sizeY, mountZ])  angl();

