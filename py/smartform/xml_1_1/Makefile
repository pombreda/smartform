#
# Copyright (c) 2009 rPath, Inc.
#
# This program is distributed under the terms of the Common Public License,
# version 1.0. A copy of this license should have been distributed with this
# source file in a file called LICENSE. If it is not present, the license
# is always available at http://www.rpath.com/permanent/licenses/CPL-1.0.
#
# This program is distributed in the hope that it will be useful, but
# without any warranty; without even the implied warranty of merchantability
# or fitness for a particular purpose. See the Common Public License for
# full details.
#

export TOPDIR=$(shell pwd)/../../..
python_files =	$(wildcard *.py)

build: default-build python-build

install: default-install python-install

clean: default-clean python-clean
test: default-test python-test

include $(TOPDIR)/Make.rules
include $(TOPDIR)/Make.defs
