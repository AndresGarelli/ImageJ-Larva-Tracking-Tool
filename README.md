Download these files 

- GCAMP_Area.ijm
- GCAMP_Larva.ijm
- StartupMacros.fiji.ijm
- Tracking Whit Light-Split Channel.ijm
- open_czi.ijm
- Speed_Test_Macro.ijm
- Files for speed test (can be omitted)

or all the files in one single "tracking macros FiJi.rar" file

Extract "tracking macros FiJi.rar" to the macros folder in imagej fiji.app/macros (or imagej.app/macros).

Confirm that you want to replace the startupMacros.fiji file with the new one. Next time you open imageJ, there will be an LTT button (larva tracking tools)

A menu with 5 options will be dislplayed when clicking on that button:

- 1-GCamp-LARVA 
- 2-GCamp-Area-Larva 
- 3-White Light 
- 4- speed test 
- 5- open czi


1-GCamp-LARVA this macro will track the larva and measure the intensity of the green channel in each larva in each area of the arena you select.

2-GCamp-Area-Larva This one is similar to the previous one, but it has the additional option to track the larva or measure the intensity of the whole area. This is a deprecated version of the macro that I keep here just in case we need to use it in the future.

3-White Light This macro is intented to be used to track larvae with white light illumination. It tracks the larva using the red channel and also measures the intensity of red and blue channels. The intensity of the red channel is almost constant during pupariation, but the intensity of the green channel slowly decreases as the pupa tans. It can be used to detect the moment when the larva becomes brown.

4- performs a speed test

5-open czi: to scan folders and subfolders and transform czi files into jpeg.

The three macros work in the same way. They ask to open one image of the series (prefereably not the initial ones, when the illumination and camera had not yet stabilized) to set the Areas in which to track larvae and the Threshold values. Older versions had a bug. Despite the idea was to use the same threshold value for every image, a new one was calculated every time. This have been fixed.

IMPORTANT NOTICE The optimal threshold value is the one that segments the larva from the background. It is not always possible to find the optimal value for all the arenas. In that case, the simplest solution is to select one threshold value and the areas for which it is optimal and run the macro. Then repeat the process with the remaining areas. This takes more time, but produces better quality data.
