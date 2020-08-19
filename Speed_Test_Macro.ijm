var archivos=0;
macro "Speed Test Macro" {

///this macro is derived from "AspectRatio multichamber Tracking SPLIT CHANNELS in AREA or LARVA SET Measurements" contained in the file
//GCAMP_splitChannels_measureGREEN


path=getDirectory("macros");
open(path+"/SpeedTest/Test1.bmp");
           
ID = getImageID();
nameGREEN = getTitle();
roiManager("reset")



////measure the size of Peron to set max and min size values for a typical Peron
setTool("freehand");
title = "Measure Peron size";
msg = "Outline the head of one Peron using freehand selection tool\ndoesn't need to be perfect\njust to know the average size of Peron's head \nthen click \"OK\".";
waitForUser(title, msg);
run("Set Measurements...", "area display redirect=None decimal=2");
run("Measure");
larvalSize = getResult("Area");

close("results");
minLarvalSize =1575;
maxLarvalSize = 6750;

//minLarvalSize =0.35*larvalSize;
//maxLarvalSize = 1.5*larvalSize;
print("Head's size: ",larvalSize,"  min: ", minLarvalSize,"  max: ",maxLarvalSize);
//}

run("Split Channels");
selectWindow(nameGREEN +" (green)");
ID2 = getImageID();
close("\\Others");
//run("8-bit");
run("Threshold...");
  getThreshold(lower, upper);

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%#%$%$%$%$%///////////
manualLow=lower;
manualUp=upper;
print("Threshold values: ",lower,"-",upper);

roiManager("Show None");
setTool("rectangle");

j = 6;
print("number of Perons: ",j);



roiManager("Open", path+"/SpeedTest/RoiSet.zip");
roiManager("Show All with labels");
roiManager("Associate", "false");
roiManager("Centered", "false");
roiManager("UseNames", "true");

run("Clear Results");


pathfig=getDirectory("macros");
input = pathfig+"SpeedTest/";
//input = getDirectory("Process images from: ");
//print(input);
carpetaResultados = input;

selectWindow(nameGREEN +" (green)");
roiManager("Show All with labels");
run("Flatten");
saveAs("Jpeg", carpetaResultados+"AREAS.jpeg");
close("*.jpeg");
selectWindow(nameGREEN +" (green)");
close("\\Others");

run("Set Measurements...", "area centroid shape integrated display redirect=None decimal=2");   


for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
//run("Set Measurements...", "area shape integrated display redirect=None decimal=2");
run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
IJ.deleteRows(0,10);

IJ.renameResults(nameResults+".xls");
path1 = ""+carpetaResultados+""+nameResults+".xls";
saveAs("results", path1);
close(nameResults+".xls");
//run("Close");
//saveAs("results", path);
}
selectWindow(nameGREEN +" (green)");
close();


output = input; // Output images to the same directory as input (prevents second dialogue box, otherwise getDirectory("Output Directory"))


setBatchMode(true);
inicio = getTime();
processFolder(input);

// Scan folders/subfolders/files to locate files with the correct suffix

function processFolder(input) {
	list = getFileList(input);
//	archivos=0;
	for (i = 0; i < list.length; i++) {
				if(endsWith(list[i], ".bmp")){
					processFile(input, output, list[i]);
					archivos++;
					}
	}
	print("Total archivos bmp: ",archivos);
}



// Loop through each file


function processFile(input, output, file) {


// Do something to each file

//ArchivoInicio=getTime();
open(input+file);
nameGREENbatch = getTitle();
run("Split Channels");
selectWindow(nameGREENbatch +" (green)");
ID3 = getImageID();
close("\\Others");
//run("8-bit");

//run("Threshold...");
getThreshold(lower, upper);
setThreshold(manualLow, manualUp);


for (i=0; i<j; i++) {
		roiManager("Select", i);
		nameResults = i+1;
		run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
		numResultados = nResults();
			for (b=0; b<numResultados; b++){
				
			headings = split(String.getResultsHeadings);
			row = b; // variable that tells you what row number to take. 0 is the first row.
			line = "";
				for (a=0; a<lengthOf(headings); a++){
				    line = line + getResultString(headings[a],row) + ",";}
							path = ""+carpetaResultados+""+nameResults+".xls";
				File.append (line,path);
			}
		run("Clear Results");

}


close(file);
close(nameGREENbatch +" (green)");
//ArchivoFin=getTime();
//tiempoArchivo =ArchivoFin-ArchivoInicio;
//print(tiempoArchivo);
}
fin = getTime();
TiempoTotal = fin-inicio;
promedio = TiempoTotal/archivos;
print ("Tiempo total [min]: ",TiempoTotal/60000);
print ("Tiempo total [sec]: ",TiempoTotal/1000);
print ("Tiempo por archivo promedio[ms]: ",promedio);
}

