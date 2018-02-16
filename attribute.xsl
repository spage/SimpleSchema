<xsl:stylesheet version="2.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <xsl:include href="types.xsl"/>

  <!-- attribute/@name,@type,@required -->
    
  <xsl:template match="ss:attribute">
    <xsl:element name="xs:attribute" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:variable name="native-type">
        <xsl:call-template name="native-type-map"/>
      </xsl:variable>
      <xsl:attribute name="type">
        <xsl:choose>
          <xsl:when test="not(@type)">xs:string</xsl:when>
          <xsl:when test="string-length($native-type)>0">
            <xsl:value-of select="$native-type"/>
          </xsl:when>          
          <xsl:otherwise>
            <!-- may want to add a check allowing only enum type reference -->
            <xsl:value-of select="@type"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="@required='yes'">
        <xsl:attribute name="use">required</xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>