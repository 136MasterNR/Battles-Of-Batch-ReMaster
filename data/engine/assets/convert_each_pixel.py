import re

def process_ansi_data(input_filename, output_filename):
    with open(input_filename, 'r', encoding='utf-8') as file:
        data = file.readlines()

    output_data = []
    cursor_x = {}
    
    for line in data:
        match = re.match(r'\[(\d+)\]=(.+)', line)
        if not match:
            continue
        
        y = int(match.group(1))
        ansi_data = match.group(2)
        
        cursor_x[y] = 1
        ansi_escape_sequence = ''

        i = 0
        while i < len(ansi_data):
            if ansi_data[i] == '\x1b':  # ASCII escape character
                # Find the end of the ANSI escape sequence
                end_seq = i
                while end_seq < len(ansi_data) and not ansi_data[end_seq].isalpha():
                    end_seq += 1
                end_seq += 1

                sequence = ansi_data[i:end_seq]
                if sequence[-1] == 'C':
                    move_right = int(re.search(r'\d+', sequence).group())
                    cursor_x[y] += move_right
                else:
                    ansi_escape_sequence = sequence
                i = end_seq
            else:
                if ansi_data[i] == ' ':
                    cursor_x[y] += 1
                else:
                    full_sequence = ansi_escape_sequence + ansi_data[i]
                    output_data.append(f'[{y},{cursor_x[y]}]={full_sequence}')
                    cursor_x[y] += 1
                i += 1

    with open(output_filename, 'w', encoding='utf-8') as file:
        for item in output_data:
            file.write(item + '\n')

# Input and output filenames
input_filename = 'background.ans'
output_filename = 'output.txt'

# Process the data
process_ansi_data(input_filename, output_filename)

# Read and display the first few lines of the output file for verification
with open(output_filename, 'r', encoding='utf-8') as file:
    output_contents = file.readlines()

output_contents[:20]  # Display the first 20 lines for inspection
