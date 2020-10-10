macro "open_czi" {
input = getDirectory("Process images from: ");
setBatchMode(true);
output = input; // Output images to the same directory as input (prevents second dialogue box, otherwise getDirectory("Output Directory"))



Dialog.create("");
Dialog.addMessage("Use default parameters\n-open .czi\n-SaveAs jpeg90%\n-do NOT rotate");
Dialog.addCheckbox("Default",true); 
Dialog.show();
default=Dialog.getCheckbox();

if (default==true){
suffix =".czi";
type=".jpeg";
rotate=false;
run("Input/Output...", "jpeg="+90);
}else{
	
Dialog.create("Only process files with extension: ");
Dialog.addChoice("extension: ", newArray (".czi",".bmp", ".jpg", ".tiff"));// Select another file format if desired
Dialog.show();
suffix = Dialog.getChoice();
 
Dialog.create("Save as: ");
Dialog.addChoice("extension: ", newArray (".jpeg",".bmp", ".tiff"));// Select another file format if desired
Dialog.show();
type = Dialog.getChoice();

if (type == ".jpeg"){
quality = call("ij.plugin.JpegWriter.getQuality");
	quality = getNumber("JPEG quality (0-100):", quality);
	run("Input/Output...", "jpeg="+quality);
}
	
Dialog.create("");
Dialog.addMessage("Click the box to rotate images 180");
Dialog.addCheckbox("Rotate",false); 
Dialog.show();
rotate=Dialog.getCheckbox();
}



title = "[Progress]";
run("Text Window...", "name="+ title +" width=50 height=2 monospaced");

processFolder(input);

print(title, "\\Close");

//here ends the program and are the defined the functions used in the script

function processFile(input,output,file) {

// Do something to each file
open(input+file);

nameOfFile= getInfo("image.filename");
if (suffix ==".czi"){
run("Stack to RGB");
}
if (rotate==true){
run("Flip Horizontally");
run("Flip Vertically");
}

saveAs(type,input+nameOfFile);
close("*");

}

function processFolder(input) {
    	list = getFileList(input);
    	list = Array.sort(list);
        	for (i = 0; i < list.length; i++) {
    		j=i+1;
    		print(title, "\\Update:"+j+"/"+list.length+ " ("+j*100/list.length+"%)\n" +getBar(j, list.length));
    		if(File.isDirectory(input +  list[i]))
    			processFolder(input +  list[i]);
    		if(endsWith(list[i], suffix))
    			processFile(input, output, list[i]);
			}
		//print(title, "\\Close");
    	}

function getBar(p1, p2) {
        n = 20;
        bar1 = "--------------------";
        bar2 = "********************";
        index = round(n*(p1/p2));
        if (index<1) index = 1;
        if (index>n-1) index = n-1;
        return substring(bar2, 0, index) + substring(bar1, index+1, n);
  }
 
}

