import benchy, strformat, zip/zlib, zippy

const
  zs = [
    "alice29.txt.z",
    "urls.10K.z",
    "rfctest3.z",
    "randtest3.z",
    "paper-100k.pdf.z",
    "geo.protodata.z",
    "tor-list.z"
  ]
  golds = [
    "alice29.txt",
    "urls.10K",
    "rfctest3.gold",
    "randtest3.gold",
    "paper-100k.pdf",
    "geo.protodata",
    "gzipfiletest.txt",
    "tor-list.gold"
  ]

echo "https://github.com/guzba/zippy compress [default]"
for gold in golds:
  let uncompressed = readFile(&"tests/data/{gold}")
  timeIt gold:
    discard zippy.compress(uncompressed, dataFormat = dfDeflate)

echo "https://github.com/nim-lang/zip compress [default]" # Requires zlib1.dll
for gold in golds:
  let uncompressed = readFile(&"tests/data/{gold}")
  timeIt gold:
    discard zlib.compress(uncompressed, stream = RAW_DEFLATE)

echo "https://github.com/guzba/zippy compress [best speed]"
for gold in golds:
  let uncompressed = readFile(&"tests/data/{gold}")
  timeIt gold:
    discard zippy.compress(uncompressed, BestSpeed, dataFormat = dfDeflate)

echo "https://github.com/nim-lang/zip compress [best speed]" # Requires zlib1.dll
for gold in golds:
  let uncompressed = readFile(&"tests/data/{gold}")
  timeIt gold:
    discard zlib.compress(uncompressed, Z_BEST_SPEED, RAW_DEFLATE)

echo "https://github.com/guzba/zippy compress [best compression]"
for gold in golds:
  let uncompressed = readFile(&"tests/data/{gold}")
  timeIt gold:
    discard zippy.compress(uncompressed, BestCompression, dataFormat = dfDeflate)

echo "https://github.com/nim-lang/zip compress [best compression]" # Requires zlib1.dll
for gold in golds:
  let uncompressed = readFile(&"tests/data/{gold}")
  timeIt gold:
    discard zlib.compress(uncompressed, Z_BEST_COMPRESSION, RAW_DEFLATE)

echo "https://github.com/guzba/zippy uncompress"
for z in zs:
  let compressed = readFile(&"tests/data/{z}")
  timeIt z:
    discard zippy.uncompress(compressed)

echo "https://github.com/nim-lang/zip uncompress" # Requires zlib1.dll
for z in zs:
  let compressed = readFile(&"tests/data/{z}")
  timeIt z:
    discard zlib.uncompress(compressed)
