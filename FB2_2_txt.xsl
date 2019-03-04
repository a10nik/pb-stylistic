<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:fb="http://www.gribuser.ru/xml/fictionbook/2.0">
	<xsl:strip-space elements="*"/>
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:key name="note-link" match="fb:section|fb:p" use="@id"/>

	<xsl:template match="*">
<!-- <xsl:variable/> -->
<xsl:value-of select="fb:description/fb:title-info/fb:book-title"/>
<xsl:text >&#010;</xsl:text>
<xsl:for-each select="fb:description/fb:title-info/fb:author">	<xsl:call-template name="author"/>
<xsl:text >&#010;</xsl:text>
</xsl:for-each>
<xsl:text >&#010;</xsl:text>

<!-- BUILD BOOK -->
<xsl:for-each select="fb:body[1]">
<xsl:apply-templates/>
</xsl:for-each>
<xsl:text >&#010;</xsl:text>
	</xsl:template>
	<!-- author template -->
<xsl:template name="author">
</xsl:template>
	<!-- secuence template -->
<xsl:template name="sequence">
<xsl:value-of select="@name"/><xsl:if test="@number"><xsl:text >&#032;#</xsl:text><xsl:value-of select="@number"/></xsl:if>
<xsl:if test="fb:sequence">
	<xsl:for-each select="fb:sequence">
<xsl:call-template name="sequence"/>
</xsl:for-each>
</xsl:if></xsl:template>

<!-- description -->
<xsl:template match="fb:description">
</xsl:template>
<!-- body -->
<xsl:template match="fb:body">
<xsl:text >&#010;</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="fb:section">
<xsl:text >&#010;</xsl:text>
<xsl:apply-templates select="./*"/>
</xsl:template>
	
	
<!-- section/title -->
<xsl:template match="fb:title"> 
</xsl:template>

	<!-- subtitle -->
<xsl:template match="fb:subtitle">
</xsl:template>

<!-- p -->
<xsl:template match="fb:p">
<xsl:apply-templates/>
<xsl:text >&#010;&#010;</xsl:text>
</xsl:template>

<xsl:template match="fb:p" mode="note">
</xsl:template>

<xsl:template match="fb:title" mode="note">
</xsl:template>


<xsl:template match="fb:strong|fb:emphasis|fb:style"><xsl:apply-templates/></xsl:template>

<xsl:template match="fb:a">
</xsl:template>

<xsl:template match="fb:empty-line">
<xsl:text >&#010;&#010;</xsl:text>
</xsl:template>

<!-- annotation -->
<xsl:template name="annotation">
<xsl:apply-templates/>
<xsl:text >&#010;</xsl:text>
</xsl:template>

<!-- epigraph -->
<xsl:template match="fb:epigraph">
</xsl:template>

<!-- cite -->
<xsl:template match="fb:cite">
</xsl:template>


	<!-- cite/text-author -->
<xsl:template match="fb:text-author">
</xsl:template>
	<!-- date -->
<xsl:template match="fb:date">
</xsl:template>

<xsl:template match="fb:poem">
</xsl:template>

	<!-- stanza -->
<xsl:template match="fb:stanza">
</xsl:template>
	<!-- v -->
<xsl:template match="fb:v">
</xsl:template>

</xsl:stylesheet>
