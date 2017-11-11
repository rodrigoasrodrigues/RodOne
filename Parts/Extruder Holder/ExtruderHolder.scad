width = 80;
height = 5;
length = 70;
bar = 9.5;
bardist = 58;
chl = 35;
chw = 18;
screw = 4;
screwspacing = 47.2+screw;
extruder = 25;
distance = 50;
fn = 150;

intersection(){
difference(){
    cube([width,length,height]);
    //bars
    spacing = (width-bardist)/2;
    translate([spacing,spacing,0]){
        cylinder(d=bar, h=height,$fn=fn);
        translate([bardist,0,0]) cylinder(d=bar,    h=height,$fn=fn);
    }
    //center hole
    translate([(width-chl)/2,0,0]){
        cube([chl,chw,height]);
        translate([chl/2,chw,0])
            scale([1,.3,1]) 
                cylinder(h=height, d = chl, $fn=fn);
        
    }
    //extruder
    translate([0,distance,0]){
        screwmargin = (width-screwspacing)/2;
        translate([screwmargin,0,0]){
            cylinder(d=screw,h=height,$fn=fn);
            translate([screwspacing,0,0])
            cylinder(d=screw,h=height,$fn=fn);
        }
        translate([width/2,0,0])
            cylinder(d=extruder,h=height,$fn=fn);
        
    }
}

translate([width/2,0,0]) 
cylinder(h=height,r=length, $fn=fn);
}