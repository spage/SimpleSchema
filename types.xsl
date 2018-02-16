<xsl:stylesheet version="2.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <!-- maps @type to native type name -->
  <xsl:template name="native-type-map">
    <xsl:choose>
      <xsl:when test="not(@type)"/>
      
      <!-- basics -->
      <xsl:when test="@type='string'">xs:string</xsl:when>
      <xsl:when test="@type='int' or @type='integer'">xs:int</xsl:when>
      <xsl:when test="@type='boolean' or @type='bool'">xs:boolean</xsl:when>

      <!-- basic under consideration -->
      <!--
      <xsl:when test="@type='datetime'">xs:dateTime</xsl:when>
      <xsl:when test="@type='token'">xs:token</xsl:when>
      <xsl:when test="@type='name'">xs:NCName</xsl:when>
      <xsl:when test="@type='short'">xs:short</xsl:when>
      <xsl:when test="@type='long'">xs:long</xsl:when>
      <xsl:when test="@type='double'">xs:double</xsl:when>
      <xsl:when test="@type='uri'">xs:anyURI</xsl:when>
      <xsl:when test="@type='base64'">xs:base64Binary</xsl:when>
      -->
      
      <!-- denied due to advanced pattern constraint use at (low) risk -->
      <!--
      <xsl:when test="@type='decimal'">xs:decimal</xsl:when>
      <xsl:when test="@type='integer'">xs:integer</xsl:when>
      <xsl:when test="@type='date'">xs:date</xsl:when>
      <xsl:when test="@type='time'">xs:time</xsl:when>
      <xsl:when test="@type='float'">xs:float</xsl:when>
      <xsl:when test="@type='id'">xs:ID</xsl:when>
      <xsl:when test="@type='idref'">xs:IDREF</xsl:when>
      -->
      
    </xsl:choose>
  </xsl:template>

  <!-- implements name-type defaulting (for export and item) -->
  <xsl:attribute-set name="name-type-defaulting">
    <xsl:attribute name="name">
      <xsl:choose>
        <xsl:when test="not(@name)">
          <xsl:value-of select="@type"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="type">
      <xsl:variable name="native-type">
        <xsl:call-template name="native-type-map"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="not(@type)">
          <xsl:value-of select="@name"/>
        </xsl:when>
        <xsl:when test="string-length($native-type)>0">
          <xsl:value-of select="$native-type"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@type"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>