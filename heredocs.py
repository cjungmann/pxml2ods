#
# The ODS document should start with the mimetype, without compressions,
# then the rest can just follow on.
#
mimetype = """application/vnd.oasis.opendocument.spreadsheet"""

META_dash_INF_manifest_xml = """<?xml version="1.0" encoding="UTF-8" ?>
<manifest:manifest xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0" manifest:version="1.2" >
 <manifest:file-entry manifest:full-path="/" manifest:media-type="application/vnd.oasis.opendocument.spreadsheet"/>
 <manifest:file-entry manifest:full-path="styles.xml" manifest:media-type="text/xml"/>
 <manifest:file-entry manifest:full-path="content.xml" manifest:media-type="text/xml"/>
 <manifest:file-entry manifest:full-path="meta.xml" manifest:media-type="text/xml"/>
</manifest:manifest>"""

meta_xml ="""<?xml version="1.0" encoding="UTF-8" ?>
<office:document-meta
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    office:version="1.2">
  <office:meta>
    <meta:creation-date></meta:creation-date>
    <meta:generator>pxml2ods</meta:generator>
    </office:meta>
</office:document-meta>"""

styles_xml = """<?xml version="1.0" encoding="UTF-8" ?>
<office:document-styles
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    office:version="1.2">
</office:document-styles>"""
