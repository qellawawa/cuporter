<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml"
              indent="yes"
              doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
              encoding="UTF-8"
              />


  <xsl:template match="/">
    <xsl:element name="html">
      <xsl:attribute name="xmlns">"http://www.w3.org/1999/xhtml"</xsl:attribute>
      <xsl:call-template name="head"/>

      <xsl:call-template name="body"/>

    </xsl:element>
  </xsl:template>

  <xsl:template name="head">
    <xsl:element name="head">
      <xsl:element name="title">
        <xsl:apply-templates select="//report"/>
      </xsl:element>
      <xsl:element name="style">
        <xsl:attribute name="type">text/css</xsl:attribute>
        <xsl:value-of select="document('cuporter.css')" disable-output-escaping="yes" />
      </xsl:element>
      <xsl:element name="style">
        <xsl:attribute name="type">text/css</xsl:attribute>
        <xsl:value-of disable-output-escaping="yes" select="document(concat($view,'_style.css'))" />
      </xsl:element>

      <!--
        <xsl:element name="script">
          <xsl:attribute name="type">script/javascript</xsl:attribute>
          <xsl:value-of select="document('../formatter/jquery-min.js')" disable-output-escaping="yes" />
          <xsl:value-of select="document('expand-collapse.js')" disable-output-escaping="yes" />
        </xsl:element>
        -->
    </xsl:element>
  </xsl:template>

  <xsl:template match="report">
    <xsl:value-of select="@title"/>
  </xsl:template>

  <xsl:template name="body">
    <xsl:element name="body">
        <xsl:element name="div">
          <xsl:attribute name="class">report</xsl:attribute>
          <xsl:element name="ul">
            <xsl:apply-templates select="//feature"/>
          </xsl:element>
        </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="feature">
    <xsl:element name="li">
      <xsl:attribute name="class">feature</xsl:attribute>
      <xsl:element name="div">
        <xsl:attribute name="class">properties</xsl:attribute>
        <xsl:apply-templates select="@cuke_name"/>
        <xsl:apply-templates select="@total"/>
        <xsl:apply-templates select="@tags"/>
        <xsl:element name="span">
          <xsl:attribute name="class">file</xsl:attribute>
          <xsl:value-of select="@file"/>
        </xsl:element>
      </xsl:element>

      <xsl:if test="scenario | scenario_outline">
        <xsl:element name='ul'>
          <xsl:attribute name="class">children</xsl:attribute>
          <xsl:apply-templates select="scenario | scenario_outline"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="scenario">
    <xsl:element name="li">
      <xsl:attribute name="class">scenario</xsl:attribute>
      <xsl:element name="div">
        <xsl:attribute name="class">properties</xsl:attribute>
        <xsl:apply-templates select="@number"/>
        <xsl:apply-templates select="@cuke_name"/>
        <xsl:apply-templates select="@tags"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="scenario_outline">
    <xsl:element name="li">
      <xsl:attribute name="class">scenario_outline</xsl:attribute>
      <xsl:element name="div">
        <xsl:attribute name="class">properties</xsl:attribute>
        <xsl:apply-templates select="@cuke_name"/>
        <xsl:apply-templates select="@total"/>
        <xsl:apply-templates select="@tags"/>
      </xsl:element>
    </xsl:element>
    <xsl:element name="ul">
      <xsl:attribute name="class">children</xsl:attribute>
      <xsl:apply-templates select="examples"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="examples">
    <xsl:element name="li">
      <xsl:attribute name="class">examples</xsl:attribute>
      <xsl:element name="div">
        <xsl:attribute name="class">properties</xsl:attribute>
        <xsl:apply-templates select="@cuke_name"/>
        <xsl:apply-templates select="@total"/>
        <xsl:apply-templates select="@tags"/>
      </xsl:element>
      <xsl:element name="table">
        <xsl:attribute name="class">children</xsl:attribute>
        <xsl:element name="thead">
          <xsl:apply-templates select="example[1]"/>
        </xsl:element>
        <xsl:element name="tbody">
          <xsl:apply-templates select="example[@number]"/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@cuke_name">
    <xsl:element name="span">
      <xsl:attribute name="class">cuke_name</xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@tags">
    <xsl:element name="span">
      <xsl:attribute name="class">tags</xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@total">
    <xsl:element name="span">
      <xsl:attribute name="class">total</xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@number">
    <xsl:element name="span">
      <xsl:attribute name="class">number</xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="example[1]">
    <xsl:element name="tr">
      <xsl:attribute name="class">example</xsl:attribute>
      <xsl:element name="th"> <xsl:attribute name="class">number</xsl:attribute> </xsl:element>
      <xsl:apply-templates select="span"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="example[@number]">
    <xsl:element name="tr">
      <xsl:attribute name="class">example</xsl:attribute>
      <xsl:element name="td"> <xsl:attribute name="class">number</xsl:attribute> <xsl:value-of select="@number"/> </xsl:element>
      <xsl:apply-templates select="span"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="example[1]/span">
    <xsl:element name="th">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="example[@number]/span">
    <xsl:element name="td">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>

