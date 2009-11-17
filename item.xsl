<xsl:stylesheet version="1.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LiquidHub/SimpleSchema/2007/10">
  
  <xsl:output method="xml" encoding="utf-8" />
  
  <!-- item/@name,@type,@required -->  

  <xsl:template match="ss:item">
    <xsl:element name="xs:element" 
                 use-attribute-sets="name-type-defaulting"
                 namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:if test="not(@required='yes')">
        <xsl:attribute name="minOccurs">0</xsl:attribute>  
      </xsl:if>      
      <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>