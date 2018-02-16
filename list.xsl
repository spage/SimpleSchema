<xsl:stylesheet version="2.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <xsl:include href="item.xsl"/>
  
  <!-- list/@name,item+ -->

  <!--
  HEY!! didn't implement minOccurs/maxOccurs correctly between these two...refactor
  -->

  <xsl:template match="ss:list">
    <xsl:choose>
      <xsl:when test="count(ss:item)>1">
        <xsl:apply-templates select="." mode="complex-type-sequence-choice"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="sequence-element-list"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="ss:list" mode="sequence-element-list">
    <xsl:comment>sequence-element-list BASIC</xsl:comment>
    <xsl:element name="xs:complexType" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:element name="xs:sequence" namespace="http://www.w3.org/2001/XMLSchema">        
        <xsl:apply-templates select="ss:item" />
      </xsl:element>
      <xsl:apply-templates select="ss:attribute" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ss:list" mode="complex-type-sequence-choice">
    <xsl:comment>complex-type-sequence-choice ADVANCED</xsl:comment>
    <xsl:element name="xs:complexType" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:element name="xs:choice" namespace="http://www.w3.org/2001/XMLSchema">
        <xsl:attribute name="minOccurs">
          <xsl:choose>
            <xsl:when test="boolean(ss:item[@required='yes'])">1</xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
        <xsl:apply-templates select="ss:item" />
      </xsl:element>
      <xsl:apply-templates select="ss:attribute" />
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>