<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:apidoc="http://marklogic.com/xdmp/apidoc"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:ml="http://www.marklogic.com"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:xs="http://www.w3.org/2001/XMLSchema" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xpath-default-namespace="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="xs" 
		version="2.0">
	
	<xsl:import href="api-xml-docs2xproc.xsl"/>
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xml" 
			method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	
	
	<!-- API Library. -->
	<xsl:template match="/">
		<xsl:apply-templates>
			<xsl:with-param name="libraryURI" as="xs:string" select="'http://marklogic.com/xdmp/admin'"/>
			<xsl:with-param name="libraryPrefix" as="xs:string" select="'admin'"/>
		</xsl:apply-templates>
	</xsl:template>
	
	
	<!-- Suppress configuration input ports.  -->
	<xsl:template match="apidoc:param[@name = 'config']" mode="ml:inputs" 
			priority="1"/>
	
		
	<!--  -->
	<xsl:template match="p:input[@port = 'source']" mode="ml:insert-inputs" priority="1">
		<xsl:param name="stepName" as="xs:NCName"/>
		
		<p:replace match="//config">
			<p:input port="replacement">
				<p:pipe port="result" step="configuration"/>
			</p:input>
		</p:replace>
	</xsl:template>
	
	
	<!-- Ignore config parameters. -->
	<xsl:template match="apidoc:param[@name = 'config']" mode="ml:params ml:set-params" priority="1"/>
	
</xsl:transform>
