// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.txt") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.

//  About the drawing tools.
//
//  This is a set of drawing tools similar to the pencil, paintbrush,
//  eraser and flood fill (paint bucket) tools in NIH Image. The
//  pencil and paintbrush draw in the current foreground color
//  and the eraser draws in the current background color. The
//  flood fill tool fills the selected area using the foreground color.
//  Hold down the alt key to have the pencil and paintbrush draw
//  using the background color or to have the flood fill tool fill
//  using the background color. Set the foreground and background
//  colors by double-clicking on the flood fill tool or on the eye
//  dropper tool.  Double-click on the pencil, paintbrush or eraser
//  tool  to set the drawing width for that tool.
//
// Icons contributed by Tony Collins.

// Global variables
var pencilWidth=1,  eraserWidth=10, leftClick=16, alt=8;
var brushWidth = 10; //call("ij.Prefs.get", "startup.brush", "10");
var floodType =  "8-connected"; //call("ij.Prefs.get", "startup.flood", "8-connected");

// The macro named "AutoRunAndHide" runs when ImageJ starts
// and the file containing it is not displayed when ImageJ opens it.

// macro "AutoRunAndHide" {}

function UseHEFT {
	requires("1.38f");
	state = call("ij.io.Opener.getOpenUsingPlugins");
	if (state=="false") {
		setOption("OpenUsingPlugins", true);
		showStatus("TRUE (images opened by HandleExtraFileTypes)");
	} else {
		setOption("OpenUsingPlugins", false);
		showStatus("FALSE (images opened by ImageJ)");
	}
}

UseHEFT();

// The macro named "AutoRun" runs when ImageJ starts.

macro "AutoRun" {
	// run all the .ijm scripts provided in macros/AutoRun/
	autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
	if (File.isDirectory(autoRunDirectory)) {
		list = getFileList(autoRunDirectory);
		// make sure startup order is consistent
		Array.sort(list);
		for (i = 0; i < list.length; i++) {
			if (endsWith(list[i], ".ijm")) {
				runMacro(autoRunDirectory + list[i]);
			}
		}
	}
}

var pmCmds = newMenu("Popup Menu",
	newArray("Help...", "Rename...", "Duplicate...", "Original Scale",
	"Paste Control...", "-", "Record...", "Capture Screen ", "Monitor Memory...",
	"Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));

macro "Popup Menu" {
	cmd = getArgument();
	if (cmd=="Help...")
		showMessage("About Popup Menu",
			"To customize this menu, edit the line that starts with\n\"var pmCmds\" in ImageJ/macros/StartupMacros.txt.");
	else
		run(cmd);
}

macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
	setKeyDown("Esc");
}

var xx = requires138b(); // check version at install
function requires138b() {requires("1.38b"); return 0; }

var dCmds = newMenu("Developer Menu Tool",
newArray("ImageJ Website","News", "Documentation", "ImageJ Wiki", "Resources", "Macro Language", "Macros",
	"Macro Functions", "Startup Macros...", "Plugins", "Source Code", "Mailing List Archives", "-", "Record...",
	"Capture Screen ", "Monitor Memory...", "List Commands...", "Control Panel...", "Search...", "Debug Mode"));

macro "Developer Menu Tool - C037T0b11DT7b09eTcb09v" {
	cmd = getArgument();
	if (cmd=="ImageJ Website")
		run("URL...", "url=http://rsbweb.nih.gov/ij/");
	else if (cmd=="News")
		run("URL...", "url=http://rsbweb.nih.gov/ij/notes.html");
	else if (cmd=="Documentation")
		run("URL...", "url=http://rsbweb.nih.gov/ij/docs/");
	else if (cmd=="ImageJ Wiki")
		run("URL...", "url=http://imagejdocu.tudor.lu/imagej-documentation-wiki/");
	else if (cmd=="Resources")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/");
	else if (cmd=="Macro Language")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/macros.html");
	else if (cmd=="Macros")
		run("URL...", "url=http://rsbweb.nih.gov/ij/macros/");
	else if (cmd=="Macro Functions")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/functions.html");
	else if (cmd=="Plugins")
		run("URL...", "url=http://rsbweb.nih.gov/ij/plugins/");
	else if (cmd=="Source Code")
		run("URL...", "url=http://rsbweb.nih.gov/ij/developer/source/");
	else if (cmd=="Mailing List Archives")
		run("URL...", "url=https://list.nih.gov/archives/imagej.html");
	else if (cmd=="Debug Mode")
		setOption("DebugMode", true);
	else if (cmd!="-")
		run(cmd);
}



var dCmds = newMenu("LarvaTracking Menu Tool",
      newArray("GCamp-LARVA","GCamp-Area-Larva","-", "White Light","Speed Test"));
      
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
       else if (cmd!="-")
            run(cmd);
  }







var sCmds = newMenu("Stacks Menu Tool",
	newArray("Add Slice", "Delete Slice", "Next Slice [>]", "Previous Slice [<]", "Set Slice...", "-",
		"Convert Images to Stack", "Convert Stack to Images", "Make Montage...", "Reslice [/]...", "Z Project...",
		"3D Project...", "Plot Z-axis Profile", "-", "Start Animation", "Stop Animation", "Animation Options...",
		"-", "MRI Stack (528K)"));
macro "Stacks Menu Tool - C037T0b11ST8b09tTcb09k" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

var luts = getLutMenu();
var lCmds = newMenu("LUT Menu Tool", luts);
macro "LUT Menu Tool - C037T0b11LT6b09UTcb09T" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}
function getLutMenu() {
	list = getLutList();
	menu = newArray(16+list.length);
	menu[0] = "Invert LUT"; menu[1] = "Apply LUT"; menu[2] = "-";
	menu[3] = "Fire"; menu[4] = "Grays"; menu[5] = "Ice";
	menu[6] = "Spectrum"; menu[7] = "3-3-2 RGB"; menu[8] = "Red";
	menu[9] = "Green"; menu[10] = "Blue"; menu[11] = "Cyan";
	menu[12] = "Magenta"; menu[13] = "Yellow"; menu[14] = "Red/Green";
	menu[15] = "-";
	for (i=0; i<list.length; i++)
		menu[i+16] = list[i];
	return menu;
}

function getLutList() {
	lutdir = getDirectory("luts");
	list = newArray("No LUTs in /ImageJ/luts");
	if (!File.exists(lutdir))
		return list;
	rawlist = getFileList(lutdir);
	if (rawlist.length==0)
		return list;
	count = 0;
	for (i=0; i< rawlist.length; i++)
		if (endsWith(rawlist[i], ".lut")) count++;
	if (count==0)
		return list;
	list = newArray(count);
	index = 0;
	for (i=0; i< rawlist.length; i++) {
		if (endsWith(rawlist[i], ".lut"))
			list[index++] = substring(rawlist[i], 0, lengthOf(rawlist[i])-4);
	}
	return list;
}

macro "Pencil Tool - C037L494fL4990L90b0Lc1c3L82a4Lb58bL7c4fDb4L5a5dL6b6cD7b" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(pencilWidth);
}

macro "Paintbrush Tool - C037La077Ld098L6859L4a2fL2f4fL3f99L5e9bL9b98L6888L5e8dL888c" {
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0)
		setColorToBackgound();
	draw(brushWidth);
}

macro "Flood Fill Tool -C037B21P085373b75d0L4d1aL3135L4050L6166D57D77D68La5adLb6bcD09D94" {
	requires("1.34j");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	if (flags&alt!=0) setColorToBackgound();
	floodFill(x, y, floodType);
}

function draw(width) {
	requires("1.32g");
	setupUndo();
	getCursorLoc(x, y, z, flags);
	setLineWidth(width);
	moveTo(x,y);
	x2=-1; y2=-1;
	while (true) {
		getCursorLoc(x, y, z, flags);
		if (flags&leftClick==0) exit();
		if (x!=x2 || y!=y2)
			lineTo(x,y);
		x2=x; y2 =y;
		wait(10);
	}
}

function setColorToBackgound() {
	savep = getPixel(0, 0);
	makeRectangle(0, 0, 1, 1);
	run("Clear");
	background = getPixel(0, 0);
	run("Select None");
	setPixel(0, 0, savep);
	setColor(background);
}

// Runs when the user double-clicks on the pencil tool icon
macro 'Pencil Tool Options...' {
	pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);
}

// Runs when the user double-clicks on the paint brush tool icon
macro 'Paintbrush Tool Options...' {
	brushWidth = getNumber("Brush Width (pixels):", brushWidth);
	call("ij.Prefs.set", "startup.brush", brushWidth);
}

// Runs when the user double-clicks on the flood fill tool icon
macro 'Flood Fill Tool Options...' {
	Dialog.create("Flood Fill Tool");
	Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);
	Dialog.show();
	floodType = Dialog.getChoice();
	call("ij.Prefs.set", "startup.flood", floodType);
}

macro "Set Drawing Color..."{
	run("Color Picker...");
}

macro "-" {} //menu divider

macro "About Startup Macros..." {
	title = "About Startup Macros";
	text = "Macros, such as this one, contained in a file named\n"
		+ "'StartupMacros.txt', located in the 'macros' folder inside the\n"
		+ "Fiji folder, are automatically installed in the Plugins>Macros\n"
		+ "menu when Fiji starts.\n"
		+ "\n"
		+ "More information is available at:\n"
		+ "<http://imagej.nih.gov/ij/developer/macro/macros.html>";
	dummy = call("fiji.FijiTools.openEditor", title, text);
}

macro "Save As JPEG... [j]" {
	quality = call("ij.plugin.JpegWriter.getQuality");
	quality = getNumber("JPEG quality (0-100):", quality);
	run("Input/Output...", "jpeg="+quality);
	saveAs("Jpeg");
	close()
}

macro "Save Inverted FITS" {
	run("Flip Vertically");
	run("FITS...", "");
	run("Flip Vertically");
}

macro "Medir6Areas" {
	path = File.openDialog("Abrir Foto para establecer areas");
open(path); // open the file
//setTool("rectangle");
ID = getImageID();
roiManager("reset")

title = "Seleccionar Area 1";
msg = "Marcar rectangulo de Area 1\n then click \"OK\".";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", "1");

title = "Seleccionar Area 2";
msg = "Marcar rectangulo de Area 2\n then click \"OK\".";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", "2");

title = "Seleccionar Area 3";
msg = "Marcar rectangulo de Area 3\n then click \"OK\".";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "3");

title = "Seleccionar Area 4";
msg = "Marcar rectangulo de Area 4\n then click \"OK\".";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "4");

title = "Seleccionar Area 5";
msg = "Marcar rectangulo de Area 5\n then click \"OK\".";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", 4);
roiManager("Rename", "5");

title = "Seleccionar Area 6";
msg = "Marcar rectangulo de Area 6\n then click \"OK\".";
waitForUser(title, msg);
roiManager("Add");
roiManager("Select", 5);
roiManager("Rename", "6");

roiManager("Select", newArray(0,1,2,3,4,5));
run("Clear Results");
input = getDirectory("Procesar fotos de: ");
fecha= File.getName(input);
carpetaResultados = getDirectory("Guardar Resultados en: ")
Dialog.create("Guardar resultados como: ");
Dialog.addString("Nombre: ", fecha, 20); // Select another file format if desired
Dialog.show();
nombreResultados = Dialog.getString();
path = ""+carpetaResultados+""+nombreResultados+".xls";
print(path);

output = input; // Output images to the same directory as input (prevents second dialogue box, otherwise getDirectory("Output Directory"))
Dialog.create("Sólo procesar archivos: ");
//Dialog.addString("File Suffix: ", ".bmp"); 
Dialog.addChoice("extension: ", newArray (".bmp", ".jpeg", ".tiff"));// Select another file format if desired
Dialog.show();

suffix = Dialog.getChoice();


setBatchMode(true);

processFolder(input);

// Scan folders/subfolders/files to locate files with the correct suffix

function processFolder(input) {
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + list[i]))
			processFolder("" + input + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}
// Loop through each file
function processFile(input, output, file) {
open(file);
//setTool("rectangle");
run("Set Measurements...", "integrated display redirect=None decimal=0");
roiManager("Select", newArray(0,1,2,3,4,5));
roiManager("multi-measure measure_all one append");
saveAs("Results", path);
close(file);
}
}

macro "AspectRatio_mutichamber_FINAL" {


path = File.openDialog("Open one picture to adjust settings");
open(path); // open the file
//setTool("rectangle");
ID = getImageID();
roiManager("reset")

run("8-bit");
setTool("freehand");
title = "Measure larval size";
msg = "Outline one larva using freehand selection tool\ndoesn't need to be perfect\njust to know the average larval size \nthen click \"OK\".";
waitForUser(title, msg);
run("Set Measurements...", "area display redirect=None decimal=2");
run("Measure");
larvalSize = getResult("Area");
minLarvalSize =0.35*larvalSize;
maxLarvalSize = 1.5*larvalSize;
print("larval size: ",larvalSize,"  min: ", minLarvalSize,"  max: ",maxLarvalSize);

roiManager("Show None");
setTool("rectangle");

Dialog.create("How many larvae?");
Dialog.addNumber("number: ",15); // Select another file format if desired
Dialog.show();
j = Dialog.getNumber();
print("number of larvae: ",j);



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

getThreshold(lower, upper);
if (lower==-1) 
title = "Adjust Threshold";
msg = "Open Image>Adjust>Threshold \noptimize Min y Max with slider\nthen click \"OK\".";
waitForUser(title, msg);
  selectImage(ID);  //make sure we still have the same image
  getThreshold(lower, upper);

  
print("Threshold values: ",lower,"-",upper);


input = getDirectory("Process images from: ");
fecha= File.getName(input);
carpetaResultados = getDirectory("Save results in: ");

run("Flatten");
saveAs("Jpeg", carpetaResultados+"AREAS.jpeg");
close("*.jpeg");
close("*-1.bmp");

for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
run("Set Measurements...", "area shape integrated display redirect=None decimal=2");
run("Analyze Particles...", "size=minLarvalSize-maxLarvalSize show=Nothing display include");
//run("Clear Results");
nameOfResults = i+1;
IJ.renameResults(nameResults+".xls");
path = ""+carpetaResultados+""+nameResults+".xls";
saveAs("results", path);
run("Close");
//saveAs("results", path);
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

// Do something to each file

open(file);
run("8-bit");

run("Threshold...");
setThreshold(lower, upper);
//run("Convert to Mask");

run("Set Measurements...", "area shape integrated display redirect=None decimal=2");

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

}
}





macro "AspectRatio multichamber in AREA or LARVA SET Measurements" {

path = File.openDialog("Open one picture to adjust settings");
open(path); // open the file
//setTool("rectangle");
ID = getImageID();
roiManager("reset")

//run("8-bit");
Dialog.create("");
Dialog.addMessage("Click the box to measure intensity \n in the entire chamber (GCamp)\nLeave unchecked to identify larva")
Dialog.addCheckbox("Measure intensity in chamber",false); 
Dialog.show();
chamber=Dialog.getCheckbox()
if (chamber==true){
print("will measure chamber. NOT larva");
} else if (chamber==false){
	print("will measure larva. NOT chamber");
} else {
	print("ERROR - will not measure");
}
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
maxLarvalSize = 1.5*larvalSize;
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
run("8-bit");
getThreshold(lower, upper);
if (lower==-1) 
title = "Adjust Threshold";
msg = "Open Image>Adjust>Threshold \noptimize Min y Max with slider\nthen click \"OK\".";
waitForUser(title, msg);
  selectImage(ID);  //make sure we still have the same image
  getThreshold(lower, upper);

  
print("Threshold values: ",lower,"-",upper);
}

input = getDirectory("Process images from: ");
fecha= File.getName(input);
carpetaResultados = getDirectory("Save results in: ");

run("Flatten");
saveAs("Jpeg", carpetaResultados+"AREAS.jpeg");
close("*.jpeg");
close("*-1.bmp");

//the following lines create one empty file for each area and name with sequential numbers
if (chamber==false){
run("Set Measurements...", "shape display redirect=None decimal=2");

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
//run("Clear Results");
nameOfResults = i+1;
IJ.renameResults(nameResults+".xls");
path = ""+carpetaResultados+""+nameResults+".xls";
saveAs("results", path);
close(nameResults+".xls");
//run("Close");
//saveAs("results", path);
}
} else {
////the following lines create one empty file for each area and name with sequential numbers+"AREA"
run("Set Measurements...", "integrated display redirect=None decimal=2");
for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
run("Measure");
IJ.deleteRows(0,10);
nameOfResults = i+1;
IJ.renameResults(nameResults+"AREA.xls");
path = ""+carpetaResultados+""+nameResults+"AREA.xls";
saveAs("results", path);
close(nameResults+"AREA.xls");
//run("Close");
//saveAs("results", path);
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

// Do something to each file
if(chamber==false){
open(file);
run("8-bit");

run("Threshold...");
setThreshold(lower, upper);
//run("Convert to Mask");

//run("Set Measurements...", "area shape integrated display redirect=None decimal=2");

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

macro "AspectRatio multichamber Tracking Alisson in AREA or LARVA SET Measurements" {

path = File.openDialog("Open one picture to adjust settings");
open(path); // open the file
//setTool("rectangle");
ID = getImageID();
roiManager("reset")

//run("8-bit");
Dialog.create("");
Dialog.addMessage("Click the box to measure intensity \n in the entire chamber (GCamp)\nLeave unchecked to identify larva")
Dialog.addCheckbox("Measure intensity in chamber",false); 
Dialog.show();
chamber=Dialog.getCheckbox()
if (chamber==true){
print("will measure chamber. NOT larva");
} else if (chamber==false){
	print("will measure larva. NOT chamber");
} else {
	print("ERROR - will not measure");
}
if (chamber==false){
setTool("freehand");
title = "Measure larval size";
msg = "Outline one larva using freehand selection tool\ndoesn't need to be perfect\njust to know the average larval size \nthen click \"OK\".";
waitForUser(title, msg);
run("Set Measurements...", "area display redirect=None decimal=2");
run("Measure");
larvalSize = getResult("Area");

close("results");
minLarvalSize =0.05*larvalSize;
maxLarvalSize = 1.95*larvalSize;
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
run("8-bit");
getThreshold(lower, upper);
if (lower==-1) 
title = "Adjust Threshold";
msg = "Open Image>Adjust>Threshold \noptimize Min y Max with slider\nthen click \"OK\".";
waitForUser(title, msg);
  selectImage(ID);  //make sure we still have the same image
  getThreshold(lower, upper);

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
print("Threshold values: ",lower,"-",upper);
}

input = getDirectory("Process images from: ");
fecha= File.getName(input);
carpetaResultados = getDirectory("Save results in: ");

run("Flatten");
saveAs("Jpeg", carpetaResultados+"AREAS.jpeg");
close("*.jpeg");
close("*-1.bmp");

//the following lines create one empty file for each area and name with sequential numbers
if (chamber==false){
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
//run("Clear Results");
nameOfResults = i+1;
IJ.renameResults(nameResults+".xls");
path = ""+carpetaResultados+""+nameResults+".xls";
saveAs("results", path);
close(nameResults+".xls");
//run("Close");
//saveAs("results", path);
}
} else {
////the following lines create one empty file for each area and name with sequential numbers+"AREA"
run("Set Measurements...", "integrated display redirect=None decimal=2");
for (i=0; i<j; i++) {
roiManager("Select", i);
nameResults = i+1;
run("Measure");
IJ.deleteRows(0,10);
nameOfResults = i+1;
IJ.renameResults(nameResults+"AREA.xls");
path = ""+carpetaResultados+""+nameResults+"AREA.xls";
saveAs("results", path);
close(nameResults+"AREA.xls");
//run("Close");
//saveAs("results", path);
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

// Do something to each file
if(chamber==false){
open(file);
run("8-bit");

run("Threshold...");
setThreshold(lower, upper);
//run("Convert to Mask");

//run("Set Measurements...", "area shape integrated display redirect=None decimal=2");

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

