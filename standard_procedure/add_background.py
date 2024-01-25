import sys
from PIL import Image, ImageDraw

# Get input and output paths from command line arguments
inputPath = sys.argv[1]
outputPath = sys.argv[2]

# Open the input image with a transparent background
img = Image.open(inputPath).convert('RGBA')

# Create a new RGBA image with a transparent background
bg = Image.new('RGBA', img.size, (0, 0, 0, 0))

# Create a new ImageDraw object
draw = ImageDraw.Draw(bg)

# Define the start and end colors for the gradient
start_color = (255, 255, 255, 255)  # white
end_color = (135, 206, 235, 255)  # sky blue

# Draw a rectangle with a gradient fill
for y in range(bg.height):
    # Calculate the color for this row
    r = int(start_color[0] + (end_color[0] - start_color[0]) * y / bg.height)
    g = int(start_color[1] + (end_color[1] - start_color[1]) * y / bg.height)
    b = int(start_color[2] + (end_color[2] - start_color[2]) * y / bg.height)
    a = int(start_color[3] + (end_color[3] - start_color[3]) * y / bg.height)
    color = (r, g, b, a)
    draw.line((0, y, bg.width, y), fill=color)

# Combine the background and input image
result = Image.alpha_composite(bg, img)

# Save the edited image as a PNG file
result.save(outputPath)
