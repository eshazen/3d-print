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

depth = 2*mm;   // slot depth
base_dep = 0.75*mm; // base depth below slots

hgt = 12*mm;       // height (only for lean)
lean = 2*mm;       // distance to lean at height

base_wid = lean + spc * nslot + 0.5*mm;

// length for bottom piece
bottom_len = 5*mm;

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

module side_outline() {
  cube( [base_wid, base_hgt, thk]);
  // draw tabs
  for( i=[0:ntab-1]) {
       translate( [tab_spc+i*(tab_spc*2), -thk, 0])
	    cube( [tab_spc, thk+e, thk]);
  }
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

module tab_slots() {
     for( n = [0 : nslot-1]) {
	  translate( [tab_spc+n*(tab_spc*2)-kerf, 0, 0])
	       cube( [tab_spc+2*kerf, thk+2*kerf, thk+2*e]);
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
	       tab_slots();
	  translate( [0, tso, -e])
	  tab_slots();
     }
}

module brace() {
  cube( [tss, base_dep, thk]);
}

part_spc = thk*2;

// 3 pieces for cutting
projection() {
     side();
     translate( [base_wid + part_spc, 0, 0])
	  side();
     rotate( [0, 0, 90])
     translate( [-base_wid-part_spc, -bottom_len, 0])
	  bottom();
     translate( [bottom_len+part_spc, -base_dep-part_spc, 0]) {
       brace();
       translate( [0, -base_dep-part_spc, 0])
	 brace();
     }
       
}

