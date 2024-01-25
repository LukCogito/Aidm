import cv2
import os
import sys

# Nefunguje!

# Get an input path from a command line argument
input_path = sys.argv[1]

# Extract a file path without an extension
file_path_without_extension = os.path.splitext(input_path)[0]

# Extract an extension
extension = os.path.splitext(input_path)[1]

# Define an output path
output_path = file_path_without_extension + "_blured" + extension

# Open the input image
img = cv2.imread(input_path)

# Apply the Gaussian Blur
blurred = cv2.GaussianBlur(img, (9, 9), 10)

# Save the blurred image
cv2.imwrite(output_path, blurred)