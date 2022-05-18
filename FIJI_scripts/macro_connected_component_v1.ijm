//get title of current image
input = getTitle();
			
// get image name without extension
nameOnly = File.nameWithoutExtension;
rename("original");

run("Duplicate...", " ");

run("16-bit");
run("Gaussian Blur...", "sigma=2");


setOption("BlackBackground", true);


run("Convert to Mask");
run("Fill Holes");

run("Options...", "iterations=3 count=1 black do=Erode");
run("Options...", "iterations=3 count=1 black do=Dilate");

run("Connected Components Labeling", "connectivity=4 type=[16 bits]");
run("glasbey on dark");

run("Find Maxima...", "prominence=10 output=[Maxima Within Tolerance]");

run("Set Measurements...", "area mean standard min centroid center fit area_fraction redirect=original decimal=3");
run("Analyze Particles...", "size=0.0001-1  show=Outlines display exclude clear summarize add");

selectWindow("original-1-lbl Maxima");
run("Outline");
run("Cyan");

imageCalculator("Add create 32-bit", "original","original-1-lbl Maxima");

