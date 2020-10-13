Download all the files and folders as a zip file clicking on the green "Code" button on the right hand side of the main page

Extract the zip file to the macros folder in imagej fiji.app/macros (or imagej.app/macros).

Confirm that you want to replace the startupMacros.fiji file with the new one. If you do not want to do so, you will have to some lines to that file, please see at the end of this text (*).

Next time you open imageJ, there will be an LTT button (larva tracking tools)

A menu with 5 options will be dislplayed when clicking on that button:

- 1-GCamp-LARVA 
- 2-GCamp-Area-Larva 
- 3-White Light 
- 4- Speed test 
- 5- open czi


1-GCamp-LARVA: this macro will track the larva and measure the intensity of the green channel in each larva in each area of the arena you select.

2-GCamp-Area-Larva: This one is similar to the previous one, but it has the additional option to track the larva or measure the intensity of the whole area. This is a deprecated version of the macro that I keep here just in case we need to use it in the future.

3-White Light: This macro is intented to be used to track larvae with white light illumination. It tracks the larva using the red channel and also measures the intensity of red and blue channels. The intensity of the red channel is almost constant during pupariation, but the intensity of the green channel slowly decreases as the pupa tans. It can be used to detect the moment when the larva becomes brown.

4- Speed Test: performs a speed test under standardized conditions. Typical speed values obtained are 50-60 ms per image.

5-open czi: to scan folders and subfolders and transform czi files into jpeg.

The three macros work in the same way. They ask to open one image of the series (prefereably not the initial ones, when the illumination and camera had not yet stabilized) to set the Areas in which to track larvae and the Threshold values. Older versions had a bug. Despite the idea was to use the same threshold value for every image, a new one was calculated every time. This have been fixed.

IMPORTANT NOTICE The optimal threshold value is the one that segments the larva from the background. It is not always possible to find the optimal value for all the arenas. In that case, the simplest solution is to select one threshold value and the areas for which it is optimal and run the macro. Then repeat the process with the remaining areas. This takes more time, but produces better quality data.

Here https://github.com/AndresGarelli/ImageJ-Larva-Tracking-Tool_example-files you will find the instructions to run the GCAMP-Larva macro, a set of example pictures and the expected results of the analysis.


* If you do not want to replace the startup macros file, the following lines have to be added at the end of it to create the button and menus of LTT:

var lttCmds = newMenu("LarvaTracking Menu Tool",
      newArray("GCamp-LARVA","GCamp-Area-Larva","-", "White Light","Speed Test","-","Open czi"));
      
macro "LarvaTracking Menu Tool - C037T0b11LT7b10TTcb10T" {
       cmd = getArgument();
       if (cmd=="GCamp-LARVA")
       		runMacro("GCAMP_ONLY LARVA_splitChannels_measureGREEN.ijm");
       else if (cmd=="GCamp-Area-Larva")
           runMacro("GCAMP_splitChannels_measureGREEN.ijm");
       else if (cmd=="White Light")
           runMacro("Tracking White Light-Split Channel.ijm");
       else if (cmd=="Speed Test")
       	   runMacro("Speed_Test_Macro.ijm");
       else if (cmd=="Open czi")
       		runMacro("open_czi.ijm");
       else if (cmd!="-")
            run(cmd);
  }
