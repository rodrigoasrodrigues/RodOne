//global 
fn = 250;

//structure block
holder_w = 32;
holder_h = 8;

//fixation
screw_w = 3.5;
screw_h =100;

//tool
tool_h = 25;
tool_w = 5;

//sensor
//sensor 8mm
sensor_d=8.5;
sensor_depth = 45;

//sensor 18mm

//sensor_d=18;
//sensor_depth = 15;

sensor_h=30;

sensor_margin = 3;
//sensor_distance = 20;
sensor_distance=10;

difference(){
group(){
    translate([-holder_w/2,0,0]){
        //fixation
        translate([0,0,sensor_depth]) toolfix();
        cube([holder_w,tool_w,sensor_depth]);
        //support
        translate([holder_w,0,0])
        rotate([0,0,180]) 
            trapezoid(holder_w, sensor_d+sensor_margin*2, sensor_distance,tool_w);
        
        translate([holder_w,0,sensor_depth/4])
        rotate([0,0,180]) 
            trapezoid(holder_w, sensor_d+sensor_margin*2, sensor_distance,tool_w);
    }
    //rouded support
    translate([0,-sensor_distance,0])
        cylinder(d=sensor_d+sensor_margin*2,h=tool_w,$fn=fn);
    
    translate([0,-sensor_distance,sensor_depth/4])
        cylinder(d=sensor_d+sensor_margin*2,h=tool_w,$fn=fn);
}
    
//sensor
translate([0,-sensor_distance,0])
    sensor();


//sensor cable

translate([0,0,sensor_depth*3/4])
    rotate([-90,0,0])
        sensor();



}


module sensor(){
    cylinder(h=sensor_h, d=sensor_d, $fn=fn);
}


module toolfix(){
    difference(){
        cube([holder_w,tool_w,holder_h+tool_h]);
        //lower holes
        translate([holder_w/4,0,holder_h+tool_h/4])
            rotate([-90,0,0])
                cylinder(d=screw_w,h=screw_h,$fn=fn);
        
        translate([holder_w*3/4,0,holder_h+tool_h/4])
            rotate([-90,0,0])
                cylinder(d=screw_w,h=screw_h,$fn=fn);
        
        
        //higher holes
        translate([holder_w/4,0,holder_h+tool_h*3/4])
            rotate([-90,0,0])
                cylinder(d=screw_w,h=screw_h,$fn=fn);
        
        translate([holder_w*3/4,0,holder_h+tool_h*3/4])
            rotate([-90,0,0])
                cylinder(d=screw_w,h=screw_h,$fn=fn);
    }
}

module trapezoid(width_base, width_top,height,thickness) {

  linear_extrude(height = thickness) polygon(points=[[0,0],[width_base,0],[width_base-(width_base-width_top)/2,height],[(width_base-width_top)/2,height]], paths=[[0,1,2,3]]); 
  
}