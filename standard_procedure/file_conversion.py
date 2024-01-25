import cv2
import sys

# Get the paths to the original and target image from the command line arguments
input_path = sys.argv[1]
output_path = sys.argv[2]

# Define a function for png to jpg conversion
def convert_png_to_jpg(input_path, output_path):
    # Reading the image
    image = cv2.imread(input_path)

    # Save the image as jpg
    cv2.imwrite(output_path, image)


# Calling the function
convert_png_to_jpg(input_path, output_path)
