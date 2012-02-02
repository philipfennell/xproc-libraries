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
	
	<xsl:import href="api-xml-docs2xquery.xsl"/>
	
	
	
	
	<!-- API Library. -->
	<xsl:template match="/apidoc:module">
		<xsl:variable name="modules" as="element()*">
			<xsl:apply-templates select="apidoc:function[@lib = current()/@lib]" mode="ml:function">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</xsl:variable>
		<c:results>
			<xsl:apply-templates select="$modules" mode="ml:output"/>
		</c:results>
	</xsl:template>
	
	
	<!-- Default behaviour: write the query to the file system. -->
	<xsl:template match="c:data" mode="ml:output">
		<xsl:copy-of select="."/>
	</xsl:template>
	
</xsl:transform>
