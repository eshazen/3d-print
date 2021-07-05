/*
Customizable Soap Tray
Version 1.0
Written by @kenwebart
info@kenweb.art
https://kenweb.art

Please update your settings below.

License: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode

You are free to:
Share — copy and redistribute the material in any medium or format
Adapt — remix, transform, and build upon the material
The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms: Attribution — You must give appropriate
credit, provide a link to the license, and indicate if changes were
made. You may do so in any reasonable manner, but not in any way that
suggests the licensor endorses you or your use.  NonCommercial — You
may not use the material for commercial purposes.  ShareAlike — If you
remix, transform, or build upon the material, you must distribute your
contributions under the same license as the original.  No additional
restrictions — You may not apply legal terms or technological measures
that legally restrict others from doing anything the license permits.

Notices: You do not have to comply with the license for elements of
the material in the public domain or where your use is permitted by an
applicable exception or limitation.  No warranties are given. The
license may not give you all of the permissions necessary for your
intended use. For example, other rights such as publicity, privacy, or
moral rights may limit how you use the material.
*/

/*
Use at your own risk.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/


//
// Added mounting pegs for brackets
// E. Hazen - hazen@bu.edu - 2021-07-04
//

//width in mm.
//trayX = 115;			// 115 is good for dial soap
                                // (inside dim ~105)

//trayX = 95;                     // 95 for Face soap
trayX = 165;

//depth in mm.
trayY = 70; 

//height in mm.
trayZ = 10;

//wall thickness in mm.
wallThickness = 5;

//line thickness in mm. 
lineThickness = 3;

//Min. line gap in mm.
lineGap = 10;

//foot in mm.
foot = 0;

//wall in mm.
wall = 7;

//line length
lineLength = trayY-(wallThickness*2);


// module for lines
module line(start, end, height, thickness) {
	color("blue")
	hull() {
		translate(start) linear_extrude(height = height) square(thickness); 
		translate(end) linear_extrude(height = height) square(thickness); 
	}
}

line([0,0], [0,trayY-wallThickness], trayZ+foot+wall, wallThickness);
line([trayX-wallThickness,trayY-wallThickness], [trayX-wallThickness,0], trayZ+foot+wall, wallThickness);
line([0,0], [trayX-wallThickness,0], trayZ+foot+wall, wallThickness);
line([0,trayY-wallThickness], [trayX-wallThickness,trayY-wallThickness], trayZ+foot+wall, wallThickness);

//Calc how many lines possible
countX = floor(((trayX-(wallThickness*2))/(lineThickness+lineGap)));
echo("countX:", countX);
calcGapX = ((trayX-(wallThickness*2))-((lineThickness+lineGap)*countX)+lineGap)/(countX-1);
echo("calcGapX:", calcGapX);

gap = (lineGap+calcGapX)*(countX-1)/(countX+1);
echo("gap:", gap);

// padding = lineThickness+lineGap+calcGapX;
// echo("padding:", padding);

padding = lineThickness+gap;
echo("padding:", padding);


for (i=[0:countX-1]) {
	color("Fuchsia")
	translate([wallThickness+(padding*i),wallThickness,0]) 
	translate([gap,0,foot])        
	cube([lineThickness,lineLength,trayZ]);
}


// add mounting pegs for snap-on brackets

$fn=37;

bracket_thickness = 3.35;	// bracket is 0.125 in (3.2mm) thick
peg_diam = 10;

module peg() {
     rotate( [0, 90, 0]) {
	  cylinder( h=bracket_thickness*2, d=peg_diam);
	  cylinder( h=bracket_thickness, d=peg_diam+5);
     }
}

module pegs() {
     translate( [-bracket_thickness*2, 10, (trayZ+foot+wall)/2]) {
	  peg();
	  translate( [0, trayY-20, 0])
	       peg();
     }
}

pegs();
translate( [trayX, 0, trayZ+foot+wall])
rotate( [0, 180, 0])
pegs();

