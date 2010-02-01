#!/usr/bin/python2.4
#
# Copyright (c) 2008 rPath, Inc.
#

class Error(Exception):
    "Base error class"

class InvalidSchemaVersionError(Error):
    ""

class SchemaValidationError(Error):
    ""

class UnknownSchema(Error):
    ""

class DataValidationError(Error):
    ""

class ConstraintsValidationError(Error):
    ""

class InvalidDefaultValue(Error):
    ""

class UndefinedFactoryDataField(Error):
    ""
