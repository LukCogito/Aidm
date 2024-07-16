import cv2
import numpy as np
import sys

def automatic_brightness_and_contrast(image, clip_hist_percent=1):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Calculate the histogram of gray levels
    hist = cv2.calcHist([gray],[0],None,[256],[0,256])
    hist_size = len(hist)

    # Calculate the accumulated histogram
    accumulator = []
    accumulator.append(float(hist[0][0]))
    for index in range(1, hist_size):
        accumulator.append(accumulator[index -1] + float(hist[index][0]))

    # Calculate the maximum and minimum brightness
    maximum = accumulator[-1]
    clip_hist_percent *= (maximum/100.0)
    clip_hist_percent /= 2.0

    # Calculate the minimum brightness
    minimum_gray = 0
    while accumulator[minimum_gray] < clip_hist_percent:
        minimum_gray += 1

    # Calculate the maximum brightness
    maximum_gray = hist_size -1
    while accumulator[maximum_gray] >= (maximum - clip_hist_percent):
        maximum_gray -= 1

    # Calculate alpha and beta for contrast and brightness adjustment
    alpha = 255 / (maximum_gray - minimum_gray)
    beta = -minimum_gray * alpha

    # Adjust contrast and brightness
    auto_result = cv2.convertScaleAbs(image, alpha=alpha, beta=beta)
    return (auto_result, alpha, beta)

# Get the paths to the original and target image from the command line arguments
input_path = sys.argv[1]
output_path = sys.argv[2]

# Load the image
# https://stackoverflow.com/questions/43185605/how-do-i-read-an-image-from-a-path-with-unicode-characters
stream = open(input_path, "rb")
bytes = bytearray(stream.read())
numpyarray = np.asarray(bytes, dtype=np.uint8)
image = cv2.imdecode(numpyarray, cv2.IMREAD_UNCHANGED)

# Automatic brightness and contrast adjustment
auto_result, alpha, beta = automatic_brightness_and_contrast(image)

# Save the resulting image
cv2.imwrite(output_path, auto_result)