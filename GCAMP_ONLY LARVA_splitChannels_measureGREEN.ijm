var archivos=0;
macro "AspectRatio multichamber Tracking SPLIT CHANNELS ONLY larva SET Measurements" {

///this macro is derived from "AspectRatio multichamber Tracking SPLIT CHANNELS in AREA or LARVA SET Measurements" contained in the file
//GCAMP_splitChannels_measureGREEN
print("Larva Tracking Tool - Andres Garelli");
path = File.openDialog("Open one picture to adjust settings");
open(path); // open the file
//setTool("rectangle");
ID = getImageID();
nameGREEN = getTitle();
roiManager("reset")



////measure the size of one larva to set max and min size values for a typical larva
setTool("freehand");
title = "Measure larval size";
msg = "Outline one larva using freehand selection tool\ndoesn't need to be perfect\njust to know the average larval size \nthen click \"OK\".";
waitForUser(title, msg);
run("Set Measurements...", "area display redirect=None decimal=2");
run("Measure");
larvalSize = getResult("Area");

close("results");
minLarvalSize =0.35*larvalSize;
maxLarvalSize = 1.5*larvalSize;
print("larval size: ",larvalSize,"  min: ", minLarvalSize,"  max: ",maxLarvalSize);
//}

run("Split Channels");
selectWindow(nameGREEN +" (green)");
ID2 = getImageID();
close("\\Others");
//run("8-bit");
getThreshold(lower, upper);
if (lower==-1) 
title = "Adjust Threshold";
msg = "Open Image>Adjust>Threshold \noptimize Min y Max with slider\nthen click \"OK\".";
waitForUser(title, msg);
  selectImage(ID2);  //make sure we still have the same image
  getThreshold(lower, upper);

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%#%$%$%$%$%///////////
manualLow=lower;
manualUp=upper;
print("Threshold values: ",lower,"-",upper);

roiManager("Show None");
setTool("rectangle");

Dialog.create("How many larvae/areas?");
Dialog.addNumber("number: ",6); // Select another file format if desired
Dialog.show();
j = Dialog.getNumber();
print("number of larvae/areas: ",j);

input = getDirectory("Process images from: ");
//fecha= File.getName(input);
carpetaResultados = getDirectory("Save results in: ");

Dialog.create("");
Dialog.addMessage("If you want to repeat the analysis\nusing saved areas, mark the checkbox.\nLeave unchecked to select new Areas")
Dialog.addCheckbox("Load saved Areas",false); 
Dialog.show();
chamber=Dialog.getCheckbox();
if (chamber==false){

for (i=0; i<j; i++) {
title = "Select Area";
msg = "Select the area that contains the first larva \nand click \"OK\".\n\nRepeat the process for the rest of the larvae";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", i);
name = i+1;
roiManager("Rename", name);
roiManager("save",input+"Roiset1.zip");
}
} else {
	roiManager("Open", input+"RoiSet1.zip");
}
roiManager("Show All with labels");
roiManager("Associate", "false");
roiManager("Centered", "false");
roiManager("UseNames", "true");

run("Clear Results");



//input = getDirectory("Process images from: ");
//carpetaResultados = getDirectory("Save results in: ");


selectWindow(nameGREEN +" (green)");
roiManager("Show All with labels");
run("Flatten");
saveAs("Jpeg", carpetaResultados+"AREAS.jpeg");
close("*.jpeg");
selectWindow(nameGREEN +" (green)");
close("\\Others");



run("Set Measurements...", "area centroid shape integrated display redirect=None decimal=2");   

title = "Set Measurements";
msg = "You will be prompted to set measurements\n \n	Select\n	-Area: to measure larval size\n	-Integrated density: to measure brightness\n	-Shape descriptors: to calculate Aspect Ratio\n	-Centroid: to track position\n \n	Display label MUST be checked\n \nClick 'OK' to go to 'Set Measurements' menu ";
waitForUser(title, msg);
run("Set Measurements...");

for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
//run("Set Measurements...", "area shape integrated display redirect=None decimal=2");
run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
IJ.deleteRows(0,10);

IJ.renameResults(nameResults+".txt");
path = ""+carpetaResultados+""+nameResults+".txt";
saveAs("results", path);
close(nameResults+".txt");
//run("Close");
//saveAs("results", path);
}


output = input; // Output images to the same directory as input (prevents second dialogue box, otherwise getDirectory("Output Directory"))
Dialog.create("Only process files with extension: ");
Dialog.addChoice("extension: ", newArray (".bmp", ".jpeg", ".tiff"));// Select another file format if desired
Dialog.show();

suffix = Dialog.getChoice();

setBatchMode(true);
inicio = getTime();
processFolder(input);

// Scan folders/subfolders/files to locate files with the correct suffix

function processFolder(input) {
	list = getFileList(input);
//	archivos=0;
	for (i = 0; i < list.length; i++) {
				if(endsWith(list[i], suffix)){
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
open(file);
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
							path = ""+carpetaResultados+""+nameResults+".txt";
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
print ("Total time [min]: ",TiempoTotal/60000);
print ("Total time [sec]: ",TiempoTotal/1000);
print ("Time per file[ms]: ",promedio);
}

