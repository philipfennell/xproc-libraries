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
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xml" 
			method="xml"/>
	
	<xsl:output name="xquery" encoding="UTF-8" indent="yes" media-type="application/xquery" 
		method="text"/>
	
	<xsl:strip-space elements="*"/>
	
	<xsl:variable name="ELEMENT_TYPE" as="xs:string" select="'element\(.*\)'"/>
	<xsl:variable name="ITEM_TYPE" as="xs:string" select="'item\(\)'"/>
	
	
	
	<!-- API Library. -->
	<xsl:template match="/apidoc:module">
		<xsl:variable name="modules" as="element()*">
			<xsl:apply-templates select="apidoc:function[@lib = current()/@lib]" mode="ml:function"/>
		</xsl:variable>
		<c:directory>
			<xsl:apply-templates select="$modules" mode="ml:output"/>
		</c:directory>
	</xsl:template>
	
	
	<!-- Default behaviour: write the query to the file system. -->
	<xsl:template match="c:data" mode="ml:output">
		<xsl:result-document href="{@href}" format="xquery">
			<xsl:value-of select="text()"/>
		</xsl:result-document>
		<c:file href="{@href}"/>
	</xsl:template>
	
	
	<!-- Step declarations. -->
	<xsl:template match="apidoc:function" mode="ml:function">
		<xsl:variable name="queryURI" select="concat('../../xquery/', @lib, '/', @name, '.xqy')"/>
		
		<c:data name="{@name}" href="{$queryURI}">
<xsl:text>xquery version "1.0-ml" encoding "utf-8";&#10;&#10;</xsl:text>
<xsl:value-of select="concat(normalize-space(../apidoc:summary/xhtml:p/xhtml:code[starts-with(text(), 'import module namespace')]/text()), '&#10;&#10;')"/>
<xsl:apply-templates select="apidoc:params/apidoc:param" mode="ml:variables"/>
<xsl:text>
(:
</xsl:text>
<xsl:apply-templates select="apidoc:*" mode="ml:docs"/>
<xsl:text>
 :)</xsl:text>

try {
	<xsl:value-of select="@lib"/>:<xsl:value-of select="@name"/>(<xsl:apply-templates select="apidoc:params/apidoc:param" mode="ml:params"/>)
} catch($error) {
	$error
}</c:data>
	</xsl:template>
	
	
	<!-- External/global variables. -->
	<xsl:template match="apidoc:param" mode="ml:variables">
		<xsl:variable name="binding" as="xs:string"
				select="if (matches(@type, $ELEMENT_TYPE)) then 
						concat(' := &lt;', @name, '/&gt;') else ' external'"/>
		<xsl:variable name="type" as="xs:string" 
				select="if (matches(@type, $ELEMENT_TYPE)) then @type else 'xs:string'"/>
		
		<xsl:value-of select="concat('declare variable $', ml:global-variabe-name(@name), ' as ', $type, if (@optional = 'true') then '*' else '', $binding)"/><xsl:text>;&#10;</xsl:text>
	</xsl:template>
	
	
	<!-- Step summary. -->
	<xsl:template match="apidoc:summary" mode="ml:docs">
		<xsl:text> : </xsl:text><xsl:value-of select="normalize-space(string-join(* | text(), ' '))"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="apidoc:params" mode="ml:docs">
		<xsl:apply-templates select="apidoc:*" mode="#current"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="apidoc:param" mode="ml:docs">
		<xsl:text> : @param $</xsl:text><xsl:value-of select="ml:global-variabe-name(@name)"/><xsl:text>&#10;</xsl:text>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="apidoc:return" mode="ml:docs">
		<xsl:text> : @return </xsl:text><xsl:value-of select="text()"/>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="apidoc:param" mode="ml:params">
		<xsl:variable name="paramName" as="xs:string" select="concat('$', ml:global-variabe-name(@name))"/>
		<xsl:variable name="castTo" 
				select="if (matches(@type, $ELEMENT_TYPE)) then $paramName
				else if (matches(@type, $ITEM_TYPE)) then concat('if (fn:matches(', $paramName, ', ''\d+'')) then xs:unsignedLong(', $paramName, ') else xs:string(', $paramName, ')')
						else concat(translate(@type, '+*?', ''), '(', $paramName, ')')"/>
		<xsl:value-of select="concat($castTo, if (position() = last()) then '' else ', ')"/>
	</xsl:template>
	
	
	
	<!-- Ignore everything else. -->
	<xsl:template match="*" mode="ml:functions ml:docs ml:options ml:inputs ml:outputs"/>
	
	
	<!-- Returns the occurrence indicator (?|*|+) for the passed data type. -->
	<xsl:function name="ml:get-occurrence" as="xs:string?">
		<xsl:param name="type" as="xs:string"/>
		
		<xsl:value-of select="if (matches($type, '(\?|\*|\+)$')) then 
				substring($type, string-length($type), 1) 
						else ''"/>
	</xsl:function>
	
	
	<!-- Returns an upper-case version of the input variable name with '-'
		 characters translated to '_'. -->
	<xsl:function name="ml:global-variabe-name" as="xs:string">
		<xsl:param name="varName" as="xs:string"/>
		
		<xsl:value-of select="upper-case(translate($varName, '-', '_'))"/>
	</xsl:function>
	
</xsl:transform>