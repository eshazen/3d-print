//
// bracket to secure ~ 40mm dia pads of child safety gate
//

thick = 6;
diam = 42;
edge = 12;
wide = diam + 2*edge;

mtg_dia = 3.8;

$fn=32;

difference() {
     translate( [-wide/2, -wide/2, 0])
	  cube( [wide, wide, thick]);
     translate( [0, 0, -1])
	  cylinder( h=thick+2, d=diam);
     translate( [-diam/2, -(wide/2+1), -1])
	  cube( [diam, diam/2+edge+1, thick+2]);
		
     translate( [-(diam/2+edge/2), (diam/2+edge/2), -1])
	  cylinder( h=thick+2, d=mtg_dia);
     translate( [(diam/2+edge/2), (diam/2+edge/2), -1])
	  cylinder( h=thick+2, d=mtg_dia);

     translate( [-(diam/2+edge/2), -(diam/2+edge/2), -1])
	  cylinder( h=thick+2, d=mtg_dia);
     translate( [(diam/2+edge/2), -(diam/2+edge/2), -1])
	  cylinder( h=thick+2, d=mtg_dia);

}
