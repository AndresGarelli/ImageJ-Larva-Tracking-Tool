macro "Tracking White Light-Split Channel" {

print("Larva Tracking Tool - Andres Garelli");
path = File.openDialog("Open one picture to adjust settings");
open(path); // open the file

ID = getImageID();
nameGREEN = getTitle();
roiManager("reset")


chamber=false;

if (chamber==false){
setTool("freehand");
title = "Measure larval size";
msg = "Outline one larva using freehand selection tool\ndoesn't need to be perfect\njust to know the average larval size \nthen click \"OK\".";
waitForUser(title, msg);
run("Set Measurements...", "area display redirect=None decimal=2");
run("Measure");
larvalSize = getResult("Area");

close("results");
minLarvalSize =0.35*larvalSize;
maxLarvalSize = 1.50*larvalSize;
print("larval size: ",larvalSize,"  min: ", minLarvalSize,"  max: ",maxLarvalSize);
}

roiManager("Show None");
setTool("rectangle");

Dialog.create("How many larvae/areas?");
Dialog.addNumber("number: ",15); // Select another file format if desired
Dialog.show();
j = Dialog.getNumber();
print("number of larvae/areas: ",j);



for (i=0; i<j; i++) {
title = "Select Area";
msg = "Select the square area that contains the first larva \nand click \"OK\".\n\nRepeat the process for the rest of the larvae";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", i);
name = i+1;
roiManager("Rename", name);
}
roiManager("Show All with labels");
roiManager("Associate", "false");
roiManager("Centered", "false");
roiManager("UseNames", "true");

run("Clear Results");


if (chamber==false){
	
run("Split Channels");
selectWindow(nameGREEN +" (red)");
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

manualLow=lower;
manualUp=upper;  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////%#%$%$%$%$%///////////
print("Threshold values: ",lower,"-",upper);
}

input = getDirectory("Process images from: ");
fecha= File.getName(input);
carpetaResultados = getDirectory("Save results in: ");

selectWindow(nameGREEN +" (red)");
roiManager("Show All with labels");
run("Flatten");
saveAs("Jpeg", carpetaResultados+"AREAS.jpeg");
close("*.jpeg");
selectWindow(nameGREEN +" (red)");
close("\\Others");

//the following lines create one empty file for each area and name with sequential numbers
if (chamber==false){
run("Set Measurements...", "area centroid shape integrated display redirect=None decimal=2");   



for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
	
run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
IJ.deleteRows(0,10);

IJ.renameResults(nameResults+".xls");
path = ""+carpetaResultados+""+nameResults+".xls";
saveAs("results", path);
close(nameResults+".xls");
			
}

///BLUE
for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
run("Set Measurements...", "integrated display redirect=None decimal=2");
run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
IJ.deleteRows(0,10);

IJ.renameResults(nameResults+"BLUE.xls");
path = ""+carpetaResultados+""+nameResults+"BLUE.xls";
saveAs("results", path);
close(nameResults+"BLUE.xls");
	
}

///GREEN
for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
run("Set Measurements...", "integrated display redirect=None decimal=2");
run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
IJ.deleteRows(0,10);

IJ.renameResults(nameResults+"GREEN.xls");
path = ""+carpetaResultados+""+nameResults+"GREEN.xls";
saveAs("results", path);
close(nameResults+"GREEN.xls");
	
}

} else {
////the following lines create one empty file for each area and name with sequential numbers+"AREA"

run("Set Measurements...", "integrated display redirect=None decimal=2");
for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
run("Measure");
IJ.deleteRows(0,10);
//nameOfResults = i+1;
IJ.renameResults(nameResults+"AREA.xls");
path = ""+carpetaResultados+""+nameResults+"AREA.xls";
saveAs("results", path);
close(nameResults+"AREA.xls");

}
	
}
output = input; // Output images to the same directory as input (prevents second dialogue box, otherwise getDirectory("Output Directory"))
Dialog.create("Only process files with extension: ");
Dialog.addChoice("extension: ", newArray (".bmp", ".jpeg", ".tiff"));// Select another file format if desired
Dialog.show();

suffix = Dialog.getChoice();

setBatchMode(true);

processFolder(input);

// Scan folders/subfolders/files to locate files with the correct suffix

function processFolder(input) {
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
				if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
	
}

// Loop through each file

function processFile(input, output, file) {

// Do something to each file, first for the green channel, then blue and red
if(chamber==false){
open(file);
nameGREENbatch = getTitle();
run("Split Channels");
selectWindow(nameGREENbatch +" (red)");
ID3 = getImageID();
//close("\\Others");
//run("8-bit");

getThreshold(lower, upper);
setThreshold(manualLow, manualUp);
//run("Convert to Mask");

run("Set Measurements...", "area centroid shape integrated display redirect=None decimal=2");   

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
close(nameGREENbatch +" (red)");

//repeats the process for blue, measuring only integrated density

selectWindow(nameGREENbatch +" (blue)");
ID3 = getImageID();


getThreshold(lower, upper);
setThreshold(manualLow, manualUp);


run("Set Measurements...", "integrated display redirect=None decimal=2");

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
							path = ""+carpetaResultados+""+nameResults+"BLUE.xls";
				File.append (line,path);
			}
		run("Clear Results");
}


close(file);
close(nameGREENbatch +" (blue)");


//repeats the process for red, measuring only integrated density

selectWindow(nameGREENbatch +" (green)");
ID3 = getImageID();


getThreshold(lower, upper);
setThreshold(manualLow, manualUp);


run("Set Measurements...", "integrated display redirect=None decimal=2");

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
							path = ""+carpetaResultados+""+nameResults+"GREEN.xls";
				File.append (line,path);
			}
		run("Clear Results");
}


close(file);
close(nameGREENbatch +" (green)");
} else {
open(file);

for (i=0; i<j; i++) {
		roiManager("Select", i);
		nameResults = i+1;
		run("Measure");
		numResultados = nResults();
			for (b=0; b<numResultados; b++){
				
			headings = split(String.getResultsHeadings);
			row = b; // variable that tells you what row number to take. 0 is the first row.
			line = "";
				for (a=0; a<lengthOf(headings); a++){
				    line = line + getResultString(headings[a],row) + ",";}
							path = ""+carpetaResultados+""+nameResults+"AREA.xls";
				File.append (line,path);
			}
		run("Clear Results");
}


close(file);
	
}
}
}
