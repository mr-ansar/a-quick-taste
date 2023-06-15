# Author: Scott Woods <scott.suzuki@gmail.com>
# MIT License
#
# Copyright (c) 2022
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# This repo needs the following;
# - python3 -m venv .env
# - source .env/bin/activate
# - pip install pyinstaller
# - pip install ansar-create
# - make build
#
# The repo is ready. A make at this point runs the final, multi-process version.
# - make

# Generate useful lists of build artefacts.
EXECUTABLES := analyzer
BUILD := $(EXECUTABLES:%=dist/%)
SPEC := $(EXECUTABLES:%=%.spec)

all: run

# Turn a python script into an executable.
dist/% : %.py
	pyinstaller --onefile --log-level ERROR -p . $<

clean::
	-rm -rf build dist

# All the executables.
build: $(BUILD)

run: build
	PATH="${PWD}/dist:${PATH}" python3 run-2-analyzer-processes.py datafile-1.txt datafile-2.txt

clean::
	-rm -f $(SPEC)
