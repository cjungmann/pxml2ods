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

### XML Source Format

The XML document that is the source for the ODS file must conform to some
simple rules.  The rules are a greatly-simplified version of the XML document
created by the [Schema Server component](https://github.com/cjungmann/SchemaServer).

- The document must include a *schema* element as a child of the document element,
  and the table rows must be elements that are also direct children of the document
  element.

- The schema must include a **row-name** attribute, the value of which is the
  name of the row elements.

- The schema must contain a collection of *field* elements containing a **name**
  attribute that corresponds to an attribute of the row elements.

- The spreadsheet columns will consist of the field elements of the schema,
  in document order.

~~~html
<?xml version=1.0?>
<list>
   <schema row-name="row">
      <field name="id" />
      <field name="fname" />
      <field name="lname" />
   </schema>
   <row id="1" fname="Tom" lname="Swift" />
   <row id="2" fname="Phyllis" lname="Newton" />
</list>
~~~

### XSL Transformation

Using [libxml2](http://xmlsoft.org/) to parse HTML pages makes even very-badly
formatted HTML usable as well-formatted XML.  XSL is the ideal tool for converting
XML to other forms because it is a mature design with good conversion tools
available.




## References

- [OpenDocument technical specification](https://en.wikipedia.org/wiki/OpenDocument_technical_specification)



