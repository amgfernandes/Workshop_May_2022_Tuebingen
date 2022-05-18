// To make this script run in Fiji, please activate 
// the clij and clij2 update sites in your Fiji 
// installation. Read more: https://clij.github.io

//Following an update site:
//https://imagej.net/update-sites/following#Add_update_sites

//https://clij.github.io/clij2-docs/installationInFiji

// Generator version: 2.5.1.1

// Init GPU
run("CLIJ2 Macro Extensions", "cl_device=");

// Load sample dataset Neuron
run("Neuron (5 channels)");

image_1 = getTitle();
Ext.CLIJ2_pushCurrentZStack(image_1);
// The following auto-generated workflow is made for processing a 2D or 3D dataset.
// For processing multiple channels or time points, you need to program a for-loop.
// You can learn how to do this online: https://www.youtube.com/watch?v=ulSq-x5_in4

// Copy
Ext.CLIJ2_copy(image_1, image_2);
Ext.CLIJ2_release(image_1);

Ext.CLIJ2_pull(image_2);

// Copy
Ext.CLIJ2_copy(image_2, image_3);
Ext.CLIJ2_release(image_2);

Ext.CLIJ2_pull(image_3);

// Gaussian Blur2D
sigma_x = 2;
sigma_y = 2;
Ext.CLIJ2_gaussianBlur2D(image_3, image_4, sigma_x, sigma_y);
Ext.CLIJ2_release(image_3);

Ext.CLIJ2_pull(image_4);

// Top Hat Box
radiusX = 10;
radiusY = 10;
radiusZ = 10;
Ext.CLIJ2_topHatBox(image_4, image_5, radiusX, radiusY, radiusZ);
Ext.CLIJ2_release(image_4);

Ext.CLIJ2_pull(image_5);

// Automatic Threshold
method = "Huang";
Ext.CLIJ2_automaticThreshold(image_5, image_6, method);
Ext.CLIJ2_release(image_5);

Ext.CLIJ2_pull(image_6);

// Connected Components Labeling Box
Ext.CLIJ2_connectedComponentsLabelingBox(image_6, image_7);
Ext.CLIJ2_release(image_6);



Ext.CLIJ2_pull(image_7);
run("glasbey_on_dark");

// Exclude Labels With Values Out Of Range
minimum_value_range = 5.0;
maximum_value_range = 6.0;


Ext.CLIJ2_excludeLabelsWithValuesOutOfRange(image_7, image_7, image_8, minimum_value_range, maximum_value_range);
Ext.CLIJ2_release(image_7);

Ext.CLIJ2_pull(image_8);


Ext.CLIJ2_clear();
