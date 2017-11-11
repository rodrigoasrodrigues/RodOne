//global 
fn = 250;

//structure block
holder_w = 32;
holder_h = 8;
carriage_length = 92;
center_h = 10;
center_base = 25;
center_top = 18;

//hotend
he_outer_diameter = 16;
he_base_h = 2.4;
he_top_h = 4.15;
he_spacing = 5;
he_filament_feed_d = 3.5;
he_center_d = 12;
he_center_h = he_top_h+he_base_h+he_spacing;
he_filament_feed_h = center_h;

//bowden
bowden_d = 9.2;
bowden_h= 5.6;
bowden_o =13;
bowden_o_h = 0.5;
bowden_t = center_h-bowden_h-bowden_o_h;
bowden_rubber = 1.2;

//fixation
cut_w = 35;
screw_w = 3.5;
screw_h =100;
screw_head_d = 6.2;
screw_head_h = 2.7;
nut_d= 6.5;
nut_h= 6.5;

//carriage
carriage_distance = 48.5;
carriage_screw = 4.5;

//tool
tool_h = 10;
tool_w = 5;

translate([50,0,0]){
    difference(){
    piece();
    //cut
    translate([0,-cut_w/2,0]) cube([holder_w/2,cut_w,center_h]);
    }
}


    intersection(){
        piece();
        //cut
        translate([0,-cut_w/2,0]) cube([holder_w/2,cut_w,center_h]);
    }


module piece(){
difference(){
    group(){
        translate([-holder_w/2,-carriage_length/2,0]){
            cube([holder_w,carriage_length,holder_h]);
        }
        cylinder(d1=center_base,d2=center_top,h=center_h,$fn=fn);
        translate([-holder_w/2,carriage_length/2-tool_w,0])
            toolfix();
        translate([-holder_w/2,-carriage_length/2,0])
            toolfix();
    }
    HotEnd();
   
    
    //screws
    translate([screw_h/2,-cut_w/3,holder_h/2]){
        rotate([0,-90,0]) cylinder(d=screw_w,h=screw_h,$fn=fn);
        translate([0,cut_w*2/3,0])
            rotate([0,-90,0]) cylinder(d=screw_w,h=screw_h,$fn=fn);
    }
    
    //bowden
    translate([0,0,bowden_t]){
        cylinder(d=bowden_d,h=bowden_h,$fn=fn);
        translate([0,0,bowden_h]){
            cylinder(d=bowden_o,h=bowden_o_h,$fn=fn);
            //rubber
            translate([0,0,-bowden_rubber/2]){
                
                cylinder(d=bowden_d+bowden_rubber*2,h=bowden_rubber,$fn=fn);
            }
        }
    }
    //carriage
    translate([0,-carriage_distance/2,0]){
        cylinder(d=carriage_screw,h=holder_h,$fn=fn);        
        translate([0,carriage_distance,0]){
            cylinder(d=carriage_screw,h=holder_h,$fn=fn);
        }
    }
    
    //nuts
    translate([-holder_w/2,-cut_w/3,holder_h/2]){
        rotate([0,90,0]) nut();
    }
    translate([-holder_w/2,cut_w/3,holder_h/2]){
        rotate([0,90,0]) nut();
    }
    
    //screw_heads
    translate([holder_w/2,-cut_w/3,holder_h/2]){
        rotate([0,-90,0]) screwhead();
    }
    translate([holder_w/2,cut_w/3,holder_h/2]){
        rotate([0,-90,0]) screwhead();
    }
}
}

//hotend
module HotEnd(){
    cylinder(d=he_center_d,h=he_center_h,$fn=fn);
    cylinder(d=he_outer_diameter,h=he_base_h,$fn=fn);
    translate([0,0,he_spacing+he_base_h]) cylinder(d=he_outer_diameter,h=he_top_h,$fn=fn);
    cylinder(d=he_filament_feed_d,h=he_filament_feed_h,$fn=fn);
}

module toolfix(){
    difference(){
        cube([holder_w,tool_w,holder_h+tool_h]);
        translate([holder_w/4,0,holder_h+tool_h/2])
            rotate([-90,0,0])
                cylinder(d=screw_w,h=screw_h,$fn=fn);
        
        translate([holder_w*3/4,0,holder_h+tool_h/2])
            rotate([-90,0,0])
                cylinder(d=screw_w,h=screw_h,$fn=fn);
    }
}

module nut(){
    rotate([0,0,30])
    cylinder(h=nut_h,d=nut_h,$fn=6);
}
module screwhead(){
    cylinder(h=nut_h,d=nut_h,$fn=fn);
}