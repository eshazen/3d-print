//
// parameterized cutting board holder
//

mm = 25.4;
e = 0.1;

function list_sum( v, i=0, r=0) = i < len(v) ? list_sum( v, i+1, r+v[i]) : r;

// thicknesses of the boards
slots = [ 0.4*mm, 0.875*mm];
nslot = len( slots);		/* number of slots */

ntab = 2;			/* number of tabs into base */
kerf = 0.004*mm;		/* laser cutter kerf allowance */
//kerf = 1;

thk = 3.0;			/* material thickness */

spc = 1*mm;   // slot center-to-center
gap = 0.063*mm;   // extra slot width

depth = 2.5*mm;   // slot depth
base_dep = 0.75*mm; // base depth below slots

hgt = 12*mm;       // height (only for lean)
lean = 2*mm;       // distance to lean at height

base_wid = lean + spc * nslot + 0.5*mm;

// length for bottom piece
bottom_len = 8*mm;

tab_spc = base_wid/(ntab*2+1);

echo( "base_wid=", base_wid/mm);

base_hgt = depth + base_dep;

// slot angle
angl = atan(lean/hgt) - atan(gap/depth);
echo("angle = ", angl);

// draw slot# n
module slot_at( n) {
     w = slots[n];
     x = lean + n * spc;
     echo("Slot ", n, " w= ", w, " x= ", x);
     translate( [x, base_dep, -e])
	  rotate( [0, 0, angl])
	  cube( [w+gap, 1.2*depth, thk+2*e]);
}

//
// create a set of tabs or cutouts
// tabs project upwards "tthk" from y=0
// space numt tabs in total width twid
//   if tout = 1, generate tabs
//   if tout = 0, generate cutouts with tkerf space on all sides
//
module tabs( twid, numt, tthk, tkerf, tout) {
  tspc = twid/(numt*2+1);
  for( i=[0:numt-1]) {
    translate( [tspc+i*(tspc*2), 0, -e]) {
      if( tout == 1) {
	    cube( [tspc, tthk, 10]);
      } else {
	translate( [-tkerf, -tkerf, 0])
	  cube( [tspc+2*tkerf, tthk+2*tkerf, 10]);
      }
    }
  }
}

module side_outline() {
  cube( [base_wid, base_hgt, thk]);
  // draw tabs
  translate( [0, -thk, 0])
    tabs( base_wid, ntab, thk+e, kerf, 1);
}

module side() {
     difference() {
	  side_outline();
	  x = 0;
	  for( n = [0 : nslot-1]) {
	       slot_at( n);
	  }
     }
}

// tab slot offset from edge
tso = 1.5 * thk;
// space between side panels
tss = bottom_len - 2*tso - 2*thk;

module bottom() {
       difference() {
	 cube( [base_wid, bottom_len, thk]);
	  translate( [0, bottom_len-thk-tso, -e])
	    tabs( base_wid, nslot, thk, kerf, 0);
	  translate( [0, tso, -e])
	    tabs( base_wid, nslot, thk, kerf, 0);
	  rotate( [0, 0, 90]) {
	    translate( [tso+thk, -2*thk, 0])
	      tabs( tss, 2, thk, kerf, 0);
	    translate( [tso+thk, -base_wid+2*thk, 0])
	      tabs( tss, 2, thk, kerf, 0);
	  }
       }

}

module brace() {
  cube( [tss, base_dep, thk]);
  translate( [0, base_dep, 0])
    tabs( tss, 2, thk, kerf, 1);
}

part_spc = thk*3;

// pieces for cutting
projection() {
     side();
     translate( [base_wid + part_spc, 0, 0])
	  side();
     rotate( [0, 0, 90])
     translate( [-base_wid-part_spc, -bottom_len, 0])
	  bottom();
     translate( [tso+thk, -base_wid-40,  0]) {
       brace();
       translate( [0, -base_dep-part_spc, 0])
	 brace();
     }
       
}

// bottom();


