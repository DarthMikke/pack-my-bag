#!/usr/bin/env python3
#-*- coding: utf-8 -*-

from PIL import Image
import os
import PIL
import glob

FILENAME = "suitcase-icon.png"
OUTPUT = "./scaled"

scalesList = [
	(20, [2, 3]),
	(29, [2, 3]),
	(40, [2, 3]),
	(60, [2, 3]),
	(20, [1, 2]),
	(29, [1, 2]),
	(40, [1, 2]),
	(76, [1, 2]),
	(83.5, [2]),
	(1024, [1]),
	(16, [1, 2]),
	(32, [1, 2]),
	(128, [1, 2]),
	(256, [1, 2]),
	(512, [1, 2]),
]

#sizes = []
#for size in scales.keys():
#	for scale in scales[size]:
#		multiplied = size*scale
#		if multiplied in sizes:
#			continue
#		sizes.append(int(multiplied))

#print(sizes)

image = Image.open(FILENAME)
filename, ext = os.path.splitext(os.path.split(FILENAME)[1])

for size, scales in scalesList:
	for scale in scales:
		print(f"{size} pt, {scale}x")
		pxSize = int(size*scale)
		resized_image = image.resize((pxSize, pxSize), PIL.Image.NEAREST)
		try:
			resized_image.save(os.path.join(OUTPUT, f"{filename}-{size}pt-{scale}x{ext}"))
		except FileNotFoundError:
			print("Utputt-mappa finst ikkje. Du må opprette ho fyrst.")
			exit(1)
