/*
    focuser_v4.scad is the code to generate a 3D case for the ETX125 electric focuser.
    Copyright (C) 2016  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the etx125 electric focuser distribution

    focuser_v4.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    focuser_v4.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with focuser_v4.scad.  If not, see <http://www.gnu.org/licenses/>.

*/


$fn=100;

// constants
Base_h = 1.1683;
Nose_h = 0.95;
Case_t = 0.04; // case thickness

module standoff(xyz, height, radius, hole_radius)
{
  translate(xyz) 
  difference(){
    cylinder(h=height, r=radius);
    cylinder(h=1.5*height, r=hole_radius);
  };
}

module make_base()
{
  difference(){
    /* 
      draw a polygon and then add in the curved part
    */
    linear_extrude(height=Base_h){
      union(){
        polygon(points=[[-0.6734,-0.0903],[-0.94, 1.0610],[-0.94, 1.6534],
                        [0.6775,1.6534],[0.6775,-0.0515],[-0.6734,-0.0903]]);
        circle(r=0.6795);
      }
    }
 
  /*
    Create the holes
  */
    
    // the main body
    translate([0,0, Case_t]){
      linear_extrude(height=2*Base_h){
        union(){
          polygon(points=[[-0.5861,-0.1212],[-0.86, 1.061],[-0.86, 1.5734],
                          [0.5975,1.5734],[0.5975,-0.0864],[-0.5861,-0.1212]]);
          circle(r=0.5985);
        }
      }
    }
   
   // the hole for the nose
   translate([-0.86, 1.1010, -Nose_h+Case_t]){
     linear_extrude(height = 2*Nose_h){
       square([1.4575,0.4724], center=false);
     }    
   }
  
   // hole for the shoe and the gear to the focuser knob 
   cylinder(h=Case_t*3, r=0.525, center=true);
   
   // hole for the cylindrical gear
   translate([0,0.6413,0]){
     cylinder(h=Case_t*3, r=0.059, center=true);
   }
 /*
   // hole for motor pushout ?????
   translate([0,1.3449,-0.8250]){
     cylinder(h=1,d=0.08, center=true);
   }
   */
  
   // hole for the standoff going through the shoe dimple
   translate([-0.3781,0.6192,0]){
     cylinder(h=1, d=0.125, center=true);
   }
   
   // second hole for holding the cover. The hole size is enough for the nut
   translate([0.3975,0.7863,0]){
     cylinder(h=1, d=0.3, center=true);
   }
 
  }
  
}

module make_nose()
{
  difference(){
    // make the nose
    
    translate([-0.94,1.0610, -Nose_h]){
      linear_extrude(height=Nose_h){
        square([1.6175,0.5924], center=false);
      }
    }
   
    // then make the hole
    translate([-0.86, 1.1010, -Nose_h+Case_t]){
      linear_extrude(height = 2*Nose_h){
        square([1.4575,0.4724], center=false);
      }    
    }  
     
    //screw hole for attaching to telescope
    translate([-0.5331,1.3029,-Nose_h]){
      cylinder(h=Nose_h*3, r=0.069, center=true);
    }
   
    // hole for motor pushout
   translate([0,1.3372,-0.8250-0.5]){
     cylinder(h=2,d=0.08, center=true);
   }
   
  }
}

module make_gear1_stem()
{
  // the stem that mounts the first gear (cylinderical gear)
  difference(){
    translate([0,0.6413,0]){
      cylinder(0.1527, d=0.1805);
    }
    translate([0,0.6413,0]){
      cylinder(h=1, r=0.059, center=true);
    }
  }
}

module make_gear2_stem()
{
  // The stem that mounts the 2nd gear
  difference(){
    union(){  
      translate([0,1.0343,0]){
        cylinder(h=0.8032, r=0.0898, center=false);    
      }
      
    }
   
    // hole for the gear (not all the way through!)
    translate([0,1.0343,0.7105]){
      cylinder(h=1, r=0.0585, center=false);
    }
    
    // gap to allow gear to get close to the motor gear
    translate([-0.0357,1.0806,0]){
      cube(size=[0.0714,0.404,0.8032*2], center=false);   
    }
    
    translate([-0.0898,1.1010,0]){
      cube(size=[0.1795,0.0393,0.8032*2], center=false);   
    }
    
  }
}

module make_motor_holder()
{
  
  // top part of holder
  translate([-0.1305,1.5340,-0.6588]){
    difference(){
      cube(size=[0.2611,0.05,0.8060], center=false);
      linear_extrude(height=1.5){
        polygon(points=[[0,0],[0.0653,0.05],[0.1305,0],[0,0]]);
      }
      linear_extrude(height=1.5){
        polygon(points=[[0.1305,0],[0.1958,0.05],[0.2611,0],[0.1305,0]]);
      }
    }
  }
  
  //bottom part of holder
  // left triangle
  translate([-0.1305,1.1010,-0.6588]){
    linear_extrude(height=0.6988){
      polygon(points=[[0,0],[0,0.0393],[0.0514,0],[0,0]]);
    }
  }
  // middle triangle
  translate([-0.0514,1.1010,-0.6588]){
    linear_extrude(height=0.6988){
      polygon(points=[[0,0],[0.0514,0.0393],[0.1027,0],[0,0]]);
    }
  }
  // right triangle
  translate([0.0792,1.1010,-0.6588]){
    linear_extrude(height=0.6988){
      polygon(points=[[0,0],[0.0514,0.0393],[0.0514,0],[0,0]]);
    }
  }
  
  // base of motor bumper
  translate([0,1.3449,-0.95]){
    difference(){
      cylinder(h=0.2912,d=0.16,center=false);
      cylinder(h=1,d=0.08, center=true);
    }
  }
 
  // right part of the holder
   translate([0.1972,1.1010,-0.8250]){
    linear_extrude(height=1.3552){
        polygon(points=[
                [0,0],
                [0,0.1062],[0.089,0.1712],[0.0390,0.2362],
                [0.089,0.3012],[0,0.3662],
                [0.129,0.3662],[0.1290,0],
                [0,0]
        ]);    
      }
   }
   
   // left part of the holder
   mirror([1,0,0]){
  translate([0.1972,1.1010,-0.8250]){
    linear_extrude(height=1.3552){
        polygon(points=[
                [0,0],
                [0,0.1062],[0.089,0.1712],[0.0390,0.2362],
                [0.089,0.3012],[0,0.3662],
                [0.129,0.3662],[0.1290,0],
                [0,0]
        ]);    
      }   
   }
  }

}

module make_shoe_dimple()
{
  // make the dimple that sets the angle of the shoe
  translate([-0.3781,0.6192,-0.103]){
    difference(){
      cylinder(h=0.103,d=0.375,center=false);
      cylinder(h=2, d=0.375-2*0.06, center=false);
    }
  }
}

module make_standoffs()
{
  standoff([-0.3781,0.6192,0], height=1.04, 
           radius=0.125, hole_radius=0.0625);
  // for the second standoff for the cover
  // first make the standoff that can contain the nut
  standoff([0.3975,0.7863,0], height=0.125,
           radius=0.2, hole_radius = 0.15);
  // then cover the top but with a 0.125 hole
  standoff([0.3975,0.7863,0.125], height=0.125, 
           radius=0.2, hole_radius=0.0625);
  // finally the standoff that reaches the cover
  standoff([0.3975,0.7863,0.25], height=1.04-0.25, 
           radius=0.125, hole_radius=0.0625);
  
  // standoff for the screw to telescope 
  standoff([-0.5331, 1.3029, -Nose_h], height=1.22, 
           radius=0.125, hole_radius=0.0690);
  
}

module make_pcb_holder()
{
  difference(){
    linear_extrude(height=0.08){
      polygon(points=[[-0.749,0.8625],[-0.7906,1.1125],
                      [-0.6473,1.1125],[-0.6056,0.8625],
                      [-0.749,0.8625]]);
    }
    translate([0,0,Case_t]){
      linear_extrude(height=0.1){
        polygon(points=[[-0.7506,1.1125],[-0.6873,1.1125],
                        [-0.6456,0.8625],[-0.7090,0.8625],
                        [-0.7506,1.1125]]);
      }
    }
  }
  
  difference()
  {
    linear_extrude(height=0.08){
      polygon(points=[[-0.6372,0.1921],[-0.6856,0.4821],
                      [-0.5422,0.4821],[-0.4939,0.1921],
                      [-0.6372,0.1921]]);
    }
    
    translate([0,0,Case_t]){
      linear_extrude(height=0.1){
        polygon(points=[[-0.6039,0.2321],[-0.6456,0.4821],
                        [-0.5822,0.4821],[-0.5405,0.2321],
                        [-0.6039,0.2321]]);
      }
    }
  }

}

Cover_offset = Base_h+0.25; // offset location to place the cover onscreen.
module make_top_cover()
{
  difference(){
    // cover
    union(){
      translate([0,0,Cover_offset]){
        linear_extrude(height=Case_t){
          union(){
            polygon(points=[[-0.6734,-0.0903],[-0.94, 1.0610],[-0.94, 1.6534],
                        [0.6775,1.6534],[0.6775,-0.0515],[-0.6734,-0.0903]]);
            circle(r=0.6795);
          }
        }
      }
      // lip
      translate([0,0,-Case_t+Cover_offset]){
        linear_extrude(height=Case_t){
          union(){
            polygon(points=[[-0.5812,-0.0559],[-0.84, 1.061],[-0.84, 1.5534],
                          [0.5775,1.5534],[0.5775,0.0864],[-0.5812,-0.0559]]);
            circle(r=0.5839);
          }
        } 
      }
      
      // add a nose
      translate([-0.94,1.061,Cover_offset]){    
          cube(size=[1.6175,0.5924,0.54], center=false);            
      }
    }
    
    // hole in the nose       
    translate([-0.8,1.1008,-0.54+Cover_offset]){
      cube(size=[1.3375,0.4262,1.00], center=false);
    }
    
    // holes for mounting screws
    translate([-0.3781,0.6192,Cover_offset]){
      cylinder(h=1,d=0.125,center=true);
    }
    translate([0.3975,0.7863,Cover_offset]){
      cylinder(h=1,d=0.125,center=true);
    }
    
    // hole for gear1 cylindrical gear
    translate([0,0.6413,Cover_offset]){
      cylinder(h=1,d=0.118,center=true);
    }
    
    // hole for gear2
    translate([0,1.0343,Cover_offset]){
      cylinder(h=1,d=0.118,center=true);
    }   
    // hole for control cable
    translate([-0.4531,1.3206, Cover_offset+0.1]){
    difference(){
      cylinder(h=1,d=0.4,center=false);
      
      // remove the sides
      translate([-0.0872,-0.18*2,0]){
        cube(size=[0.1774,0.18,1], center=false);
      }
      
      translate([-0.0872,0.18,0]){
        cube(size=[0.1774,0.18,1], center=false);
      }
      
    }   
  }
  }
}

module make_wire_protector()
{
  translate([0,0,Cover_offset]){
    difference(){
      union(){
        difference(){
          translate([-0.4531,1.3206,-0.3133-Case_t]){
            cylinder(h=0.8880,d=0.5460,center=false);
          }
      
          translate([-0.4531,1.3206,-0.3133-Case_t]){
            cylinder(h=2,d=0.4,center=true);
          }     
        }
      }
      translate([-0.4531,1.3206,-0.3133-Case_t]){
        linear_extrude(height=2){
          polygon(points=[
                [0.1414,0.1414],
                [0.3328,0.3328],[-0.4869,0.3328],
                [-0.4869,-0.3328],[0.3328,-0.3328],
                [0.1414,-0.1414],
                [0.1414,0.1414]
          ]);
        }
      }
    }
  }
}

module make_gear1_cover_stem()
{
  // the stem that mounts the first gear (cylinderical gear)
  translate([0,0,Cover_offset]){
    difference(){
      translate([0,0.6413,-0.1145+0.01]){
        cylinder(h=0.1145-0.01, d=0.1805);
      }
      translate([0,0.6413,-0.1145]){
        cylinder(h=1, r=0.059, center=true);
      }
    }
  }
}

module make_gear2_cover_stem()
{
   // the stem that mounts the second gear
  translate([0,0,Cover_offset]){
    difference(){
      translate([0,1.0343,-0.1634]){
        cylinder(h=0.1634+0.54, d=0.2276);
      }
      translate([0,1.0343,-0.1634]){
        cylinder(h=2*0.12, d=0.1175, center=true);
      }
    }
  }
}

module make_cover_standoffs()
{
  translate([0,0,Cover_offset]){
   standoff([-0.3781,0.6192,-(0.1682-0.06)], height=0.14, 
           radius=0.125, hole_radius=0.0625);
  }
  
  translate([0,0,Cover_offset]){
   standoff([0.3975,0.7863,-(0.1682-0.06)], height=0.14, 
           radius=0.125, hole_radius=0.0625);
  }
  
}



// make the housing that contains the gears etc.
union(){
  make_base();
  make_nose();
  make_gear1_stem();
  make_gear2_stem();
  make_motor_holder();
  make_shoe_dimple();
  make_standoffs();
  make_pcb_holder();
}


// make the cover
union(){
  make_top_cover();
  make_wire_protector();
  make_gear1_cover_stem();
  make_gear2_cover_stem();
  make_cover_standoffs();
}

