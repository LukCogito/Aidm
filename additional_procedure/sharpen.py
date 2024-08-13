import os
import sys
import cv2
import shutil
import tempfile
import numpy as np
from pathlib import Path

with tempfile.TemporaryDirectory() as tmpdirname:
    # Define the kernel for sharpening
    kernel = np.array([[-1,-1,-1], [-1,9,-1], [-1,-1,-1]])

    # Extract a file name without extension
    filename = Path(sys.argv[1]).stem
    
    # Extract an extension
    extension = os.path.splitext(sys.argv[1])[1]

    # Define an input path
    input_path = tmpdirname + "/" + filename + extension

    # Define an output path
    output_path = tmpdirname + "/" + filename + "_sharpened" + extension

    # Define a final path
    final_path = os.path.splitext(sys.argv[1])[0] + "_sharpened" + extension

    # Copy the input image to the temp dir
    shutil.copyfile(sys.argv[1], input_path)
    
    # Reading the image
    img = cv2.imread(input_path)
    
    # Apply the sharpening
    sharpened = cv2.filter2D(img, -1, kernel)
    
    # Writing the sharpened image
    cv2.imwrite(output_path, sharpened)

    # Copy the output to the same dir as input
    shutil.copyfile(output_path, final_path)