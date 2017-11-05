# STEP Calibration Piece by voltivo
From thingverse: [195604](https://www.thingiverse.com/thing:195604)

To get dimensionally accurate printouts the printer has to be calibrated appropriately. I found that my Ultimaker had some issues reproducing technical models accurately leading to issues with fit of screw holes, etc.

This calibration piece allows to adjust the X,Y and Z-STEPS appropriately.

Just print this piece and then carefully measure the 3 sides with a Caliper. Make sure you don't include the first layers as they usually come out slightly wider.

The calibration object is 100mm on X and Y axis and 50mm on the Z-Axis.

You can then calibrate your STEPS using this formula:
```
X,Y-Axis: 100 / [measured length in mm] [current STEPS]
Z-Axis: X,Y-Axis: 50 / [measured height in mm] [current STEPS]
```

For example my X Axis X-STEPS were 78.4 and I measured the side to be 99.27:
```
100/99.27 * 78.4 = 78.97
```
I repeated this for all Axis.

You then can set these values either in the printer itself, or in my case I compiled my MARLIN firmware myself and configured it right in the source code in "Configuration/h":
```
#define DEFAULT_AXIS_STEPS_PER_UNIT {78.97,79.26,535.44,760*1.1} // default steps per unit for Ultimaker
```
After a second print with the new settings my object measured a correct 100.07 x 100.05 x 50.02mm.

Be aware that PLA and ABS loose volume when cooling at different ratios. So that calibration will only be 100% accurate for the material you have done it for. ABS typically has a shrinkage ratio of 0.5% to 0.9% depending on the raw ABS material used by the manufacturer. PLA typically much less. For ExcelFil ABS Filament that shrinkage factor is a low 0.5%.

A good way to account for that would be to calibrate your printer to the material you use most first and then print the other material and measure the deviation. Most slicers allow for scaling the source model. Apply the measured scaling factor before slicing and you are all set.

## Instructions 


Print with whatever speed is comfortable for your printer to get accurate measurements. I print this at 120mm/s with my Ultimaker.
Took about 35 minutes to print

An infill of 10% is sufficient.

Make sure you don't confuse X and Y axis after the print as some printers have them reversed.