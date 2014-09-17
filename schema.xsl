<xsl:stylesheet version="1.0" exclude-result-prefixes="ss" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"                
                xmlns:ss="urn:LayerExp/Schema/2014/10"
                xmlns:ms="urn:schemas-microsoft-com:xslt">
  
  <xsl:output method="xml" encoding="utf-8" />

  <xsl:include href="export.xsl"/>
  <xsl:include href="enum.xsl"/>
  <xsl:include href="class.xsl"/>
  <xsl:include href="list.xsl"/>
  <xsl:include href="doc.xsl"/>

  <!-- schema/@namespace -->
    
  <xsl:template match="ss:schema">
    <xsl:element name="xs:schema" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:variable name="tns">
        <xsl:value-of select="@namespace"/>
        <xsl:if test="not(@namespace)">urn:unspecified</xsl:if>
      </xsl:variable> 
      <xsl:variable name="tweedledee">
        <xsl:element name="tweedledum" namespace="{$tns}"/>
      </xsl:variable>
      <xsl:copy-of select="ms:node-set($tweedledee)/*/namespace::*[.=$tns]"/>      
      <xsl:attribute name="targetNamespace">
        <xsl:value-of select="$tns"/>
      </xsl:attribute>
      <xsl:attribute name="elementFormDefault">qualified</xsl:attribute>            
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  
</xsl:stylesheet>