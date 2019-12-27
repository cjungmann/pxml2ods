<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
    xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
    xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"

    xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
    xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"

    office:mimetype="application/vnd.oasis.opendocument.spreadsheet"
    office:version="1.2">

  <xsl:output
      method="xml"
      version="1.0"
      indent="yes"
      encoding="utf-8"/>

  <xsl:template match="/">
    <office:document-content
        office:mimetype="application/vnd.oasis.opendocument.spreadsheet"
        office:version="1.2">

      <office:font-face-decls>
        <style:font-face style:name="Liberation Sans" svg:font-family="&quot;Liberation Sans&quot;"/>
      </office:font-face-decls>
      <office:automatic-styles>
        <style:style style:name="ce1" style:family="table-cell" style:parent-style-name="Default" style:data-style-name="N0"/>
        <style:style style:name="co1" style:family="table-column">
          <style:table-column-properties fo:break-before="auto" style:column-width="2.25cm"/>
        </style:style>
        <style:style style:name="co2" style:family="table-column">
          <style:table-column-properties fo:break-before="auto" style:column-width="0.75cm"/>
        </style:style>
        <style:style style:name="ro1" style:family="table-row">
          <style:table-row-properties style:row-height="14.15pt" style:use-optimal-row-height="true" fo:break-before="auto"/>
        </style:style>
        <style:style style:name="ta1" style:family="table" style:master-page-name="mp1">
          <style:table-properties table:display="true" style:writing-mode="lr-tb"/>
        </style:style>
      </office:automatic-styles>


      <office:body>
        <xsl:apply-templates select="//*[schema]" />
      </office:body>
    </office:document-content>
  </xsl:template>

  <xsl:template match="*[schema]">
    <xsl:variable name="nrows" select="*[local-name()=../@row-name]" />
    <xsl:variable name="drows" select="*[not($nrows)][local-name()!='schema']" />
    <xsl:variable name="ncols" select="count(schema/field)" />
    <xsl:variable name="ecols" select="16384 - $ncols" />

    <office:spreadsheet>
      <table:calculation-settings
          table:case-sensitive="true"
          table:search-criteria-must-apply-to-whole-cell="true"
          table:use-wildcards="false"
          table:use-regular-expressions="false"
          table:automatic-find-labels="false"/>
      <table:table table:style-name="ta1" table:name="Sheet1">
        <table:table-column
            table:style-name="co1"
            table:number-columns-repeated="{$ncols}"
            table:default-cell-style-name="ce1"/>
        <table:table-column
            table:style-name="co2"
            table:number-columns-repeated="{$ecols}"
            table:default-cell-style-name="ce1"/>
        <xsl:apply-templates select="schema" mode="build_headline" />
        <xsl:apply-templates select="$nrows|$drows" mode="build_line">
          <xsl:with-param name="schema" select="schema" />
        </xsl:apply-templates>
      </table:table>
    </office:spreadsheet>
  </xsl:template>

  <xsl:template match="schema" mode="build_headline">
    <table:table-row table:style-name="ro1">
      <xsl:apply-templates select="field" mode="build_headline" />
    </table:table-row>
  </xsl:template>

  <xsl:template match="field" mode="build_headline">
    <table:table-cell table:style-name="ce1" office:value-type="string">
      <text:p>
        <xsl:if test="position()=1">*</xsl:if>
        <xsl:apply-templates select="." mode="fill_headline_text"/>
      </text:p>
    </table:table-cell>
  </xsl:template>

  <xsl:template match="field" mode="fill_headline_text">
    <xsl:value-of select="@name" />
  </xsl:template>

  <xsl:template match="field[@label]" mode="fill_headline_text">
    <xsl:value-of select="@label" />
  </xsl:template>

  <xsl:template match="*" mode="build_line">
    <xsl:param name="schema" />
    <xsl:apply-templates select="$schema" mode="build_line_with_schema">
      <xsl:with-param name="data" select="." />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="schema" mode="build_line_with_schema">
    <xsl:param name="data" />
    <table:table-row table:style-name="ro1">
      <xsl:apply-templates select="field[not(@hidden)]" mode="build_cell_with_field">
        <xsl:with-param name="data" select="$data" />
      </xsl:apply-templates>
    </table:table-row>
  </xsl:template>

  <xsl:template match="field" mode="build_cell_with_field">
    <xsl:param name="data" />
    <table:table-cell table:style-name="ce1" office:value-type="string">
      <text:p><xsl:value-of select="$data/@*[local-name()=current()/@name]" /></text:p>
    </table:table-cell>
  </xsl:template>

  <xsl:template match="field" mode="build_cell_with_field">
    <xsl:param name="data" />
    <table:table-cell table:style-name="ce1" office:value-type="string">
      <text:p><xsl:value-of select="$data/@*[local-name()=current()/@name]" /></text:p>
    </table:table-cell>
  </xsl:template>

  <xsl:template match="field[contains(@type,'INT') or @type='FLOAT' or @type='DOUBLE']"
                mode="build_cell_with_field">
    <xsl:param name="data" />
    <table:table-cell table:style-name="ce1" office:value-type="string">
      <text:p><xsl:value-of select="$data/@*[local-name()=current()/@name]" /></text:p>
    </table:table-cell>
  </xsl:template>
  
</xsl:stylesheet>
