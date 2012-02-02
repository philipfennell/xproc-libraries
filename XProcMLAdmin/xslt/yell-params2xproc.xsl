<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:apidoc="http://marklogic.com/xdmp/apidoc"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema" 
		xmlns:yell="http://www.yellgroup.com"
		exclude-result-prefixes="xs" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	<xsl:variable name="ADMIN_LIB_DOC" as="element()" select="doc('../build/ml-config/lib/admin.xpl')/*"/>
	
	
	<!--  -->
	<xsl:template match="/params">
		<p:library version="1.0">
			<xsl:apply-templates select="databases/database[1]" mode="ml:db-settings"/>
		</p:library>
	</xsl:template>
	
	
	<!-- -->
	<xsl:template match="database" mode="ml:db-settings">
		<p:declare-step type="yell:{database-name}">
			<xsl:apply-templates select="* except (forests, indices, database-name)" mode="#current"/>
		</p:declare-step>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="*" mode="ml:db-settings">
		<xsl:variable name="type" select="concat('mla:', name())"/>
		<xsl:variable name="stepDeclaration" as="element()" select="$ADMIN_LIB_DOC//p:declare-step[@type = $type]"/>
		
		<xsl:element name="{$type}" namespace="http://www.marklogic.com/admin">
			<xsl:attribute name="value" select="text()"/>
		</xsl:element>
	</xsl:template>
	
</xsl:transform>
