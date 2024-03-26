import ffmpeg
import sys

# Get an input path from a command line argument
input_path = sys.argv[1]

# Get an output path from a command line argument
output_path = sys.argv[2]


(
    ffmpeg
    .input(input_path)
    .output(output_path)
    .run()
)