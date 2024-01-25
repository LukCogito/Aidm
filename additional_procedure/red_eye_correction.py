import sys
import os
import cv2
import numpy as np

# Get an input path from a command line argument
input_path = sys.argv[1]

# Extract a file path without an extension
file_path_without_extension = os.path.splitext(input_path)[0]

# Extract an extension
extension = os.path.splitext(input_path)[1]

# Define an output path
output_path = file_path_without_extension + "_eyes" + extension

# Load the image
img = cv2.imread(input_path)

out_image = img.copy()

# Load the Haar cascade for eyes
eyes_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')

# Detect eyes in the image
eye_rects = eyes_cascade.detectMultiScale(img, 1.1, 5)

# Iterate over all detected eyes to remove red-eye effect
for x, y, w, h in eye_rects:
    # Crop the region containing the eye
    eye_image = img[y:y+h, x:x+w]

    # Split the eye image into its Red, Green, and Blue channels
    b, g, r = cv2.split(eye_image)

    # Add the Blue and Green channels
    bg = cv2.add(b, g)

    # Create a mask based on the red color and the combination of blue and green colors
    mask = ((r > (bg - 20)) & (r > 80)).astype(np.uint8) * 255

    # Find the largest region in the mask
    contours, _ = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    max_area = 0
    max_cont = None
    for cont in contours:
        area = cv2.contourArea(cont)
        if area > max_area:
            max_area = area
            max_cont = cont

    # Reset the mask image to complete black
    mask = np.zeros_like(mask)

    # Draw the largest contour on the mask
    cv2.drawContours(mask, [max_cont], 0, 255, -1)

    # Close small holes in the mask for a smoother region
    mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5)))
    mask = cv2.dilate(mask, (3, 3), iterations=3)

    # Compensate for the lost red color information by filling with the mean of blue and green colors
    mean = bg // 2

    # Apply the mean value to the masked image
    mean = cv2.bitwise_and(mean, mask)
    mean = cv2.cvtColor(mean, cv2.COLOR_GRAY2BGR)
    mask = cv2.cvtColor(mask, cv2.COLOR_GRAY2BGR)
    eye = cv2.bitwise_and(cv2.bitwise_not(mask), eye_image) + mean
    out_image[y:y+h, x:x+w] = eye

# Save the result to the output file
cv2.imwrite(output_path, out_image)