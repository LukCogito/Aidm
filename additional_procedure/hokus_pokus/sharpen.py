import cv2
import numpy as np
import os
import sys

# Define the kernel for sharpening
kernel = np.array([[-1,-1,-1], [-1,9,-1], [-1,-1,-1]])

# Get input and output path from a command line argument
input_path = sys.argv[1]
output_path = sys.argv[2]

# Reading the image
img = cv2.imread(input_path)

# Apply the sharpening
sharpened = cv2.filter2D(img, -1, kernel)

# Writing the sharpened image
cv2.imwrite(output_path, sharpened)