<xsl:stylesheet version="2.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">

  <xsl:output method="xml" encoding="utf-8" />

  <xsl:include href="field.xsl"/>

  <!-- class/@name,@type,field*,attribute* -->

  <xsl:template match="ss:class">
    <xsl:choose>
      <xsl:when test="boolean(@type) and not(ss:attribute)">
        <xsl:apply-templates select="." mode="global-simple-type"/>
      </xsl:when>
      <xsl:when test="boolean(@type)">
        <xsl:apply-templates select="." mode="extended-simple-content"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="complex-type-sequence"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="ss:class" mode="complex-type-sequence">
    <xsl:comment>complex-type-sequence BASIC</xsl:comment>
    <xsl:element name="xs:complexType" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:if test="boolean(ss:field)">
        <!-- what about when no fields, call it complex-type-attribute? -->
        <xsl:element name="xs:sequence" namespace="http://www.w3.org/2001/XMLSchema">
          <xsl:apply-templates select="ss:field" />
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="ss:attribute" />
    </xsl:element>
  </xsl:template>

  <!-- class with type restricted to no fields -->
  <xsl:template match="ss:class" mode="global-simple-type">
    <xsl:comment>global-simple-type BASIC</xsl:comment>
    <xsl:element name="xs:simpleType" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:element name="xs:restriction" namespace="http://www.w3.org/2001/XMLSchema">
        <xsl:attribute name="base">
          <xsl:variable name="native-type">
            <xsl:call-template name="native-type-map"/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="string-length($native-type)>0">
              <xsl:value-of select="$native-type"/>
            </xsl:when>            
            <xsl:otherwise>
              <xsl:value-of select="@type"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:element>
      <!-- wait, what about attributes with a base type? -->
    </xsl:element>
  </xsl:template>

  <xsl:template match="ss:class" mode="extended-simple-content">
    <xsl:comment>extended-simple-content2 ADVANCED</xsl:comment>
    <xsl:element name="xs:complexType" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:element name="xs:simpleContent" namespace="http://www.w3.org/2001/XMLSchema">
        <xsl:element name="xs:extension" namespace="http://www.w3.org/2001/XMLSchema">
          <xsl:attribute name="base">
            <xsl:variable name="native-type">
              <xsl:call-template name="native-type-map"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="string-length($native-type)>0">
                <xsl:value-of select="$native-type"/>
              </xsl:when>
              <xsl:otherwise>xs:string</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:apply-templates select="ss:attribute" />
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>