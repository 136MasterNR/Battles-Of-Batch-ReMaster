def process_file(input_file, output_file):
    with open(input_file, 'r') as file:
        content = file.read()

    # Initialize variables
    result = []
    i = 0
    length = len(content)

    while i < length:
        if content[i:i+4] == "[49m":
            result.append("[49U")
            i += 4
            space_count = 0

            while i < length and content[i] == " ":
                space_count += 1
                i += 1

            if space_count > 0:
                result.append(f"[{space_count}C")
        else:
            result.append(content[i])
            i += 1

    # Join the result list into a single string
    processed_content = ''.join(result)

    # Write the processed content to the output file
    with open(output_file, 'w') as file:
        file.write(processed_content)

def add_line_counters(input_file, output_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    with open(output_file, 'w') as file:
        for idx, line in enumerate(lines, start=1):
            file.write(f"[{idx}]={line}")

# Example usage:
input_file = 'player_right.ans'
processed_file = 'processed.txt'
final_output_file = 'playerr.ans'

# Step 1: Process the file to replace spaces after "[49m"
process_file(input_file, processed_file)

# Step 2: Add line counters to the processed file
add_line_counters(processed_file, final_output_file)
