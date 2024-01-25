import cv2
import numpy as np
import os
import sys

# Define the kernel for sharpening
kernel = np.array([[-1,-1,-1], [-1,9,-1], [-1,-1,-1]])

# Get an input path from a command line argument
input_path = sys.argv[1]

# Extract a file path without an extension
file_path_without_extension = os.path.splitext(input_path)[0]

# Extract an extension
extension = os.path.splitext(input_path)[1]

# Define an output path
output_path = file_path_without_extension + "_sharpened" + extension

# Reading the image
img = cv2.imread(input_path)

# Apply the sharpening
sharpened = cv2.filter2D(img, -1, kernel)

# Writing the sharpened image
cv2.imwrite(output_path, sharpened)