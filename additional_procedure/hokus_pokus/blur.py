import cv2
import sys

# Get input and output path from a command line argument
input_path = sys.argv[1]
output_path = sys.argv[2]

# Open the input image
img = cv2.imread(input_path)

# Apply the Gaussian Blur
blurred = cv2.GaussianBlur(img, (9, 9), 10)

# Save the blurred image
cv2.imwrite(output_path, blurred)