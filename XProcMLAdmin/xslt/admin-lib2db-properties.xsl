<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:apidoc="http://marklogic.com/xdmp/apidoc"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:xdmp="http://marklogic.com/xdmp"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema" 
		xmlns:yell="http://www.yellgroup.com"
		exclude-result-prefixes="xs" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	
	<!--  -->
	<xsl:template match="/p:library">
		<p:library version="1.0">
			<xsl:namespace name="mla" select="'http://www.marklogic.com/admin'"/>
			<p:documentation>High-level library for setting database properties</p:documentation>
			<p:import href="xdmp.xpl"/>
			<p:import href="admin.xpl"/>

			<xsl:apply-templates select="p:declare-step[starts-with(@type, 'admin:database-set-')]" mode="ml:steps"/>
		</p:library>
	</xsl:template>
	
	
	<!-- -->
	<xsl:template match="p:declare-step" mode="ml:steps">
		<xsl:text>&#10;&#10;&#10;</xsl:text>
		<p:declare-step type="mla:{substring-after(@type, 'admin:database-set-')}">
			<xsl:copy-of select="(p:documentation, p:input, p:output)"/>
			<xsl:text>&#10;&#10;</xsl:text>
			<p:option name="value" required="true"/>
			<xsl:text>&#10;&#10;</xsl:text>
			
			<xsl:element name="{@type}">
				<p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
				<xsl:apply-templates select="p:option[@name != 'ml-database-id']" mode="ml:options"/>
			</xsl:element>
		</p:declare-step>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:option" mode="ml:options">
		<p:with-option name="{@name}" select="$value"/>
	</xsl:template>
	
</xsl:transform>