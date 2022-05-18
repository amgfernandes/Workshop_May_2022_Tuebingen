// To make this script run in Fiji, please activate 
// the clij and clij2 update sites in your Fiji 
// installation. Read more: https://clij.github.io

// Generator version: 2.5.1.4

// Init GPU
run("CLIJ2 Macro Extensions", "cl_device=AMD");


// Load image from disc 
open("/Users/fernandesm/Nextcloud/Retreat_DZNE_Tuebingen_2022_Constance/example_data/Demo_stimulation/1h_stimulation/A_1.tif");


run("Duplicate...", " ");

run("16-bit");
image_1 = getTitle();
Ext.CLIJ2_pushCurrentZStack(image_1);

// Copy
Ext.CLIJ2_copy(image_1, image_2);
Ext.CLIJ2_release(image_1);

Ext.CLIJ2_pull(image_2);

// Gaussian Blur2D
sigma_x = 2;
sigma_y = 2;
Ext.CLIJ2_gaussianBlur2D(image_2, image_3, sigma_x, sigma_y);
Ext.CLIJ2_release(image_2);

Ext.CLIJ2_pull(image_3);

// Threshold Huang
Ext.CLIJ2_thresholdHuang(image_3, image_4);
Ext.CLIJ2_release(image_3);

Ext.CLIJ2_pull(image_4);

// Binary Fill Holes
Ext.CLIJ2_binaryFillHoles(image_4, image_5);
Ext.CLIJ2_release(image_4);

Ext.CLIJ2_pull(image_5);

// Erode Box
Ext.CLIJ2_erodeBox(image_5, image_6);
Ext.CLIJ2_release(image_5);

Ext.CLIJ2_pull(image_6);

// Dilate Box
Ext.CLIJ2_dilateBox(image_6, image_7);
Ext.CLIJ2_release(image_6);

Ext.CLIJ2_pull(image_7);

// Connected Components Labeling Box
Ext.CLIJ2_connectedComponentsLabelingBox(image_7, image_8);
Ext.CLIJ2_release(image_7);

Ext.CLIJ2_pull(image_8);
run("glasbey_on_dark");

// Exclude Labels On Edges
Ext.CLIJ2_excludeLabelsOnEdges(image_8, image_9);
Ext.CLIJ2_release(image_8);

Ext.CLIJ2_pull(image_9);
run("glasbey_on_dark");
Ext.CLIJ2_release(image_9);


Ext.CLIJ2_clear();