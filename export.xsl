<xsl:stylesheet version="2.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <!-- export/@name,@type -->

  <xsl:template match="ss:export">
    <xsl:element name="xs:element" 
                 use-attribute-sets="name-type-defaulting" 
                 namespace="http://www.w3.org/2001/XMLSchema"/>
  </xsl:template>

</xsl:stylesheet>