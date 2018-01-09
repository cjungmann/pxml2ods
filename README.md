# Project pxml2ods

Converts an XML document with a simplified schema into an ODS spreadsheet document.
It will work in concert with other projects to convert scraped web pages into an
easily-imported spreadsheet.

## Project Purpose

This project exists to serve as a prototype for a C-language version with the same
basic utility.  It will provide

- A testing place for XSL transformation of the data document
- A testing place for building an ODS document
- A place to discuss design decisions that will be carried over to the C version
- A repository for online references that help develop the application

## Design Elements

### ODS File Format

This file format is much more complicated than a CSV (comma-separated-values)
document that might also serve the same purpose, but its advantage is that the
separation between rows and columns is unambiguous.  Unlike CSV files, an ODS
file can define non-string data-types for more accurate and usable data transfer.

Advantages of the ODS file format
- The ODS file format is directly-readable (need not be imported) by Microsoft Excel
  as well as most other open-source spreadsheet programs.
- It is much easier to produce that other well-supported spreadsheet formats.  The
  data is stored as an XML document, with other XML and text documents, in a zipped
  file.

### Schema Use

Using a schema with a collection of field definitions helps prevent the
misalignment of data if a data row omits an attribute due to a NULL value.

This project may be a candidate to replace the export feature of the Schema
Framework, which uses a schema to direct the rendering of pages.  This project
is designed to recognise the schema format of the Schema Framework, but to

### XSL Transformation

Using [libxml2](http://xmlsoft.org/) to parse HTML pages makes even very-badly
formatted HTML usable as well-formatted XML.  XSL is the ideal tool for converting
XML to other forms because it is a mature design with good conversion tools
available.




## References

- [OpenDocument technical specification](https://en.wikipedia.org/wiki/OpenDocument_technical_specification)



