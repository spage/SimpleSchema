<xsl:stylesheet version="1.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <!-- enum/@name,value+ -->
    
  <xsl:template match="ss:enum">
    <xsl:comment>string-enumeration-type BASIC</xsl:comment>
    <xsl:element name="xs:simpleType" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:element name="xs:restriction" namespace="http://www.w3.org/2001/XMLSchema">
        <xsl:attribute name="base">xs:string</xsl:attribute>
        <xsl:apply-templates select="ss:value" />
      </xsl:element>
    </xsl:element>
  </xsl:template>
    
  <xsl:template match="ss:value">
    <xsl:element name="xs:enumeration" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="value">
        <xsl:value-of select="normalize-space(text())"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>