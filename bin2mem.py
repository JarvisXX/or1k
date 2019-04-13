import argparse
import binascii


parser = argparse.ArgumentParser()
parser.add_argument('--file', '-f', required=True)
parser.add_argument('--outfile', '-o', required=True)
args = parser.parse_args()

file = open(args.file, 'rb')
buf_bin = file.read()

buf_hex = binascii.hexlify(buf_bin)
buf_str = str(buf_hex)
buf_str = buf_str[2:-1]

step = 8
file_new = open(args.outfile, 'w')
for i in range(0, len(buf_str), step):
	# print(buf_str[i:i+step])
	file_new.write(buf_str[i:i+step])
	file_new.write('\n')
file_new.close()
