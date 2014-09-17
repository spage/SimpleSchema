<xsl:stylesheet version="1.0" exclude-result-prefixes="ss"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:ss="urn:LayerExp/Schema/2014/10">
  
  <xsl:output method="xml" encoding="utf-8" />

  <xsl:include href="attribute.xsl"/>

  <!-- field/@name,@type,@required -->

  <xsl:template match="ss:field">
    <xsl:variable name="native-type">
      <xsl:call-template name="native-type-map"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="boolean(ss:attribute) and (string-length($native-type)>0 or not(@type))">
        <xsl:apply-templates select="." mode="extended-simple-content"/>
      </xsl:when>
      <xsl:when test="boolean(ss:attribute)">
        <!-- this is a weird case that leads to advanced usage anyway,
             I don't want anonymous types. The user is trying to reference
             a type they defined elsewhere and add attributes to it.
             Should I produce schema and warn, or error...leaning towards error,
             could suggest including this attribute in the referenced type, yes!
             
             The above could be avoided too come to think of it. leads to another
             advanced usage, anon type. Could recommend a class, since class can
             be created from a basic type and include attributes.-->
        <xsl:apply-templates select="." mode="complex-type-attribute-extension"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="element-type-reference"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="ss:field" mode="element-type-reference">
    <!--xsl:comment>element-type-reference BASIC</xsl:comment-->
    <xsl:element name="xs:element" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:variable name="native-type">
          <xsl:call-template name="native-type-map"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="string-length($native-type)>0">
            <xsl:value-of select="$native-type"/>
          </xsl:when>
          <xsl:when test="boolean(@type)">
            <xsl:value-of select="@type"/>
          </xsl:when>
          <xsl:otherwise>xs:string</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="@required='no'">
        <xsl:attribute name="minOccurs">0</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="ss:doc"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="ss:field" mode="extended-simple-content">    
    <xsl:element name="xs:element" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:if test="@required='no'">
        <xsl:attribute name="minOccurs">0</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:comment>extended-simple-content ADVANCED</xsl:comment>
      <xsl:element name="xs:complexType" namespace="http://www.w3.org/2001/XMLSchema">
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
    </xsl:element>
  </xsl:template>

  <xsl:template match="ss:field" mode="complex-type-attribute-extension">
    <xsl:comment>complex-type-attribute-extension BASIC</xsl:comment>
    <xsl:element name="xs:element" namespace="http://www.w3.org/2001/XMLSchema">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:if test="@required='no'">
        <xsl:attribute name="minOccurs">0</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="ss:doc"/>
      <xsl:element name="xs:complexType" namespace="http://www.w3.org/2001/XMLSchema">
        <xsl:element name="xs:complexContent" namespace="http://www.w3.org/2001/XMLSchema">
          <xsl:element name="xs:extension" namespace="http://www.w3.org/2001/XMLSchema">
            <xsl:attribute name="base">
              <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates select="ss:attribute" />            
          </xsl:element>
        </xsl:element>
      </xsl:element>      
    </xsl:element>
  </xsl:template>


</xsl:stylesheet>