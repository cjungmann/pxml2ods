<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    office:mimetype="application/vnd.oasis.opendocument.spreadsheet"
    office:version="1.2">

  <xsl:output
      method="xml"
      version="1.0"
      indent="yes"
      encoding="utf-8"/>

  <xsl:template match="/">
    <office:document-content>
      <office:body>
        <xsl:apply-templates select="/*/*[@rndx][schema]" />
      </office:body>
    </office:document-content>
  </xsl:template>

  <xsl:template match="*[@rndx][schema]">
    <xsl:variable name="nrows" select="*[local-name()=../@row-name]" />
    <xsl:variable name="drows" select="*[not($nrows)][local-name()!='schema']" />

    <office:spreadsheet>
      <office:table>
        <xsl:apply-templates select="schema" mode="build_headline" />
        <xsl:apply-templates select="$nrows|$drows" mode="build_line">
          <xsl:with-param name="schema" select="schema" />
        </xsl:apply-templates>
      </office:table>
    </office:spreadsheet>
  </xsl:template>

  <xsl:template match="schema" mode="build_headline">
    <table:table-row>
      <xsl:apply-templates select="field" mode="build_headline" />
    </table:table-row>
  </xsl:template>

  <xsl:template match="field" mode="build_headline">
    <table:table-cell office:value-type="string">
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
    <table:table-row>
      <xsl:apply-templates select="field[not(@hidden)]" mode="build_cell_with_field">
        <xsl:with-param name="data" select="$data" />
      </xsl:apply-templates>
    </table:table-row>
  </xsl:template>

  <xsl:template match="field" mode="build_cell_with_field">
    <xsl:param name="data" />
    <table:table-cell office:value-type="string">
      <text:p><xsl:value-of select="$data/@*[local-name()=current()/@name]" /></text:p>
    </table:table-cell>
  </xsl:template>

  <xsl:template match="field" mode="build_cell_with_field">
    <xsl:param name="data" />
    <table:table-cell office:value-type="string">
      <text:p><xsl:value-of select="$data/@*[local-name()=current()/@name]" /></text:p>
    </table:table-cell>
  </xsl:template>

  <xsl:template match="field[contains(@type,'INT') or @type='FLOAT' or @type='DOUBLE']"
                mode="build_cell_with_field">
    <xsl:param name="data" />
    <table:table-cell office:value-type="string">
      <text:p><xsl:value-of select="$data/@*[local-name()=current()/@name]" /></text:p>
    </table:table-cell>
  </xsl:template>
  
</xsl:stylesheet>
