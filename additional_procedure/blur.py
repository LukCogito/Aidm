import os
import cv2
import sys
import shutil
import tempfile
from pathlib import Path

with tempfile.TemporaryDirectory() as tmpdirname:
    # Extract a file name without extension
    filename = Path(sys.argv[1]).stem

    # Extract an extension
    extension = os.path.splitext(sys.argv[1])[1]

    # Define an input path
    input_path = tmpdirname + "/" + filename + extension

    # Define an output path
    output_path = tmpdirname + "/" + filename + "_blured" + extension

    # Define a final path
    final_path = os.path.splitext(sys.argv[1])[0] + "_blured" + extension

    # Copy the input image to the temp dir
    shutil.copyfile(sys.argv[1], input_path)

    # Open the input image
    img = cv2.imread(input_path)

    # Apply the Gaussian Blur
    blurred = cv2.GaussianBlur(img, (9, 9), 10)

    # Save the blurred image
    cv2.imwrite(output_path, blurred)

    # Copy the output to the same dir as input
    shutil.copyfile(output_path, final_path)