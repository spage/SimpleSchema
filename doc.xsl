<xsl:stylesheet version="1.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <!-- doc -->
    
  <xsl:template match="ss:doc">
    <!--xsl:comment>documentation-element BASIC</xsl:comment-->
    <xsl:element name="xs:annotation" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:element name="xs:documentation" namespace="http://www.w3.org/2001/XMLSchema">        
        <xsl:value-of select="text()" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>