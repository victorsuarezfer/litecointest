import argparse
import functools

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f","--infile", required=True, help="File to process")
    args = parser.parse_args()
    return args

def is_numeric(n):
    try:
        int(n)
    except ValueError:
        return False
    return True

def isValidLine(line):
    if len(line) and is_numeric(line[4]):
        return True
    return False

def parseFile(inputFile):
    lines = []
    with open(inputFile, "r") as infile:
        lines = infile.read().splitlines()
    lines = filter(isValidLine, map( lambda line: line.split("|"), lines)) # Ignore wrong formated lines to avoid errors
    lines = map(lambda line: line[:4] + [int(line[4])] + line[4:],lines) # Convert column 5 to int

    return list(lines)  # Return as list type instead of FilterObject

def processEntries(entries):
    entries = filter(lambda entry: entry[4] in range(-50, 0) or entry[4] in range(1,51), entries)  # Filter out when column5 is not between specified ranges
    entries = map(lambda entry: [entry[1], entry[4]], entries)  # Get only second and fifth columns
    values = {}
    for entry in entries:
        values[entry[0]] = entry[1] + values.get(entry[0],0)
    return values

def printOutput(values):
    for k, v in sorted(values.items(), key=lambda value: value[1], reverse=True): 
        print("{},{}".format(k, v))

def main():
    args = get_args()
    entries = parseFile(args.infile)   # File reading duties on its own function
    results = processEntries(entries)  # Processing task on its own function
    printOutput(results)  # Output format duties on its own function
if __name__ == '__main__':
    main()
