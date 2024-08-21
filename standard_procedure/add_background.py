import sys
from PIL import Image, ImageDraw

# Get input and output paths from command line arguments
input_path = sys.argv[1]
output_path_blue = sys.argv[2]
output_path_grey = sys.argv[3]

# Open the input image with a transparent background
img = Image.open(input_path).convert('RGBA')

# Create a new RGBA image with a transparent background
bg = Image.new('RGBA', img.size, (0, 0, 0, 0))

# Create a new ImageDraw object
draw = ImageDraw.Draw(bg)

# Define the start and end colors for the gradient
start_color = (255, 255, 255, 255)  # white
end_color_blue = (135, 206, 235, 255)  # sky blue
end_color_grey = (156, 156, 156, 255)  # light grey

def add_background(end_color, output_path):
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

    # Save the edited images as a PNG files
    result.save(output_path)

# Call the functions for each background color
add_background(end_color_blue, output_path_blue)
add_background(end_color_grey, output_path_grey)