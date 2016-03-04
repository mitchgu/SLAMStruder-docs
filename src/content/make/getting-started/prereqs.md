---
title: Prerequisites
layout: make.jade
tagline: Things you'll need
order: 2
---

<p class="uk-alert uk-alert-warning">**Note**: This is not a full bill of materials. See the individual sections for detailed lists.</p>

## Fabrication tools

1. **Waterjet abrasive cutter**
 - Used to cut sheet metal for the extruder frame. If not available, a laser cutter may be used at the expense of frame rigidity
2. **3D Printer**
 - Used for the extruder motor mount and hotend mount. This could probably be milled, but who doesn't have a 3D printer nowadays?
3. **Soldering Iron**
4. **Lathe (optional)**
 - A lathe is handy to narrow the hotend nozzle to a slimmer profile. Otherwise, printing in tight corners without collisions will be difficult

## Robotics Equipment

1. **A 6 DOF robotic arm (KUKA or similar)**. 
 - As of now, SLAMStruder has only been tested with a [KUKA Agilus sixx](http://www.kuka-robotics.com/en/products/industrial_robots/small_robots/kr6_r900_sixx/) robotic arm, but it should be able to be adapted to similar industrial robotic arms. The most important requirements are the ability to connect to two digital outputs from the robot arm and a compatible tool changing system. (see next item)
2. **[ATI QC11](http://www.ati-ia.com/products/toolchanger/QC.aspx?ID=QC-11) tool changing system (or similar)**
 - Not essential, but handy to have for easy maintenance of the extruder. The SLAMStruder has mounting holes arranged in a 40mm square to be compatible with these tool changers, but this can be customized easily.
3. **A 24VDC power supply**
 - Used to power the extruder. At least 3A of current output is recommended. This could either come from the robot itself or a separate supply (recommended). 

## Raw Materials

1. **1/8" Aluminum sheet stock**
 - This is waterjet to form the frame of the extruder. If a waterjet is not available, laser cut plywood, MDF, or rigid plastic may suffice, but will be less rigid.
2. **3D printer filament**
 - For printing, of course
3. **Assorted metric hardware**
 - For fastening everything together

## Electromechanical parts

See the [hardware](/make/hardware) section.
