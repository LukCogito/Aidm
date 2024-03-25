from ffmpeg import FFmpeg
import sys

# Get an input path from a command line argument
input_path = sys.argv[1]

# Get an output path from a command line argument
output_path = sys.argv[2]

# Define the main funciton for the conversion
def main():
	ffmpeg = (
		FFmpeg()
		.option("i")
		.input(input_path)
		.output(output_path)
	)

	ffmpeg.execute()

# If script is executed as main (and not as an module)
if __name__ == "__main__":
	main()