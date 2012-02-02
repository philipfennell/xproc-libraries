<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
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
	
	<xsl:strip-space elements="*"/>
	
	<xsl:variable name="ELEMENT_TYPE" as="xs:string" select="'element\(.*\)'"/>
	
	
	
	<!-- API Library. -->
	<xsl:template match="/apidoc:module">
		<xsl:param name="libraryURI" as="xs:string"/>
		<xsl:param name="libraryPrefix" as="xs:string"/>
		
		<p:library version="1.0">
			<xsl:namespace name="{$libraryPrefix}" select="$libraryURI"/>
			<p:import href="ml-server.xpl"/>
			<xsl:text>&#10;&#10;</xsl:text>
			<xsl:apply-templates select="apidoc:summary" mode="ml:summary"/>
			
			<xsl:apply-templates select="apidoc:function[@lib = $libraryPrefix]" mode="ml:function">
				<xsl:sort select="@name"/>
			</xsl:apply-templates>
		</p:library>
	</xsl:template>
	
	
	<!-- Step declarations. -->
	<xsl:template match="apidoc:function" mode="ml:function">
		<xsl:variable name="stepName" as="xs:NCName" select="xs:NCName(concat(@lib, '-', @name))"/>
		<xsl:variable name="stepType" as="xs:QName" select="QName('http://marklogic.com/xdmp/admin', concat(@lib, ':', @name))"/>
		<xsl:variable name="inputs" as="element()+">
			<p:input port="source"/>
			<xsl:apply-templates select="apidoc:params/apidoc:param" mode="ml:inputs"/>
		</xsl:variable>
		<xsl:variable name="outputs" as="element()*">
			<xsl:apply-templates select="apidoc:return" mode="ml:outputs"/>
		</xsl:variable>
		<xsl:variable name="options" as="element()*">
			<xsl:apply-templates select="apidoc:params/apidoc:param" mode="ml:options"/>
		</xsl:variable>
		
		<xsl:text>&#10;&#10;&#10;</xsl:text>
		<p:declare-step name="{$stepName}" type="{$stepType}">
			<!-- Description. -->
			<xsl:apply-templates select="apidoc:summary" mode="ml:summary"/>
			
			<!-- Inputs -->
			<xsl:if test="apidoc:params[preceding-sibling::apidoc:*] | apidoc:return[preceding-sibling::apidoc:*]">
				<xsl:text>&#10;&#10;</xsl:text>
			</xsl:if>
			<xsl:copy-of select="$inputs"/>
			
			<!-- Outputs -->
			<xsl:copy-of select="$outputs"/>
			
			<!-- Options. -->
			<xsl:if test="apidoc:params[preceding-sibling::apidoc:*]">
				<xsl:text>&#10;&#10;</xsl:text>
			</xsl:if>
			<xsl:copy-of select="$options"/>
			
			<!-- Sub-pipeline. -->
			<xsl:text>&#10;&#10;</xsl:text>
			
			<p:unwrap name="configuration" match="/ml:connection"/>
			<p:sink/>
			
			<xsl:text>&#10;&#10;</xsl:text>
			<p:identity>
				<p:documentation>Retrieve the source query</p:documentation>
				<p:input port="source">
					<p:data href="xquery/{@lib}/{@name}.xqy" content-type="text/plain"/>
				</p:input>
			</p:identity>
			<p:unescape-markup>
				<p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
			</p:unescape-markup>
			<xsl:apply-templates select="$inputs" mode="ml:insert-inputs">
				<xsl:with-param name="stepName" as="xs:NCName" select="$stepName"/>
			</xsl:apply-templates>
			<p:add-attribute match="/*" attribute-name="step-type" attribute-value="{$stepType}"/>
			<p:escape-markup name="query"/>
			<p:sink/>
			
			<xsl:apply-templates select="apidoc:params" mode="ml:params"/>
			
			<xsl:text>&#10;&#10;</xsl:text>
			<ml:action name="action">
				<p:input port="source">
					<p:pipe port="result" step="query"/>
				</p:input>
				<p:input port="params">
					<xsl:choose>
						<xsl:when test="apidoc:params">
							<p:pipe port="result" step="params"/>
						</xsl:when>
						<xsl:otherwise>
							<p:empty/>
						</xsl:otherwise>
					</xsl:choose>
				</p:input>
				<p:input port="connection">
					<p:pipe port="source" step="{$stepName}"/>
				</p:input>
			</ml:action>
			
			<p:sink/>
			
			<!-- Remove the contents of the ml:connection wrapper. -->
			<p:delete match="/ml:connection/*">
				<p:input port="source">
					<p:pipe port="source" step="{$stepName}"/>
				</p:input>
			</p:delete>
			
			<p:insert match="/*" position="last-child">
				<p:input port="insertion">
					<p:pipe port="result" step="action"/>
				</p:input>
			</p:insert>
		</p:declare-step>
	</xsl:template>
	
	
	<!-- Step summary. -->
	<xsl:template match="apidoc:summary" mode="ml:summary">
		<p:documentation>
			<xsl:value-of select="* | text()"/>
		</p:documentation>
	</xsl:template>
	
	
	<!-- Suppress configuration input ports.  -->
	<xsl:template match="apidoc:param[@name = 'config']" mode="ml:inputs" 
			priority="1"/>
	
	
	<!-- Generates an input port. -->
	<xsl:template match="apidoc:param[matches(@type, $ELEMENT_TYPE)]" 
				mode="ml:inputs">
		<p:input port="{@name}" 
				sequence="{if (ml:get-occurrence(@type) = ('+', '*')) then 
						'true' else 'false'}">
			<xsl:apply-templates select="apidoc:summary" mode="ml:summary"/>
		</p:input>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:input[@port = 'source']" mode="ml:insert-inputs" priority="1">
		<xsl:param name="stepName" as="xs:NCName"/>
		
		<p:replace match="//config">
			<p:input port="replacement">
				<p:pipe port="result" step="configuration"/>
			</p:input>
		</p:replace>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="p:input" mode="ml:insert-inputs">
		<xsl:param name="stepName" as="xs:NCName"/>
		
		<p:replace match="//{@port}">
			<p:input port="replacement">
				<p:pipe port="{@port}" step="{$stepName}"/>
			</p:input>
		</p:replace>
	</xsl:template>
	
	
	<!-- Generates an output port if the return type is not an empty sequence.
		 Sets sequence='true' if the function's return type is a sequence.-->
	<xsl:template match="apidoc:return" mode="ml:outputs">
		
		<xsl:choose>
			<xsl:when test="ends-with(text(), 'empty-sequence()')"/>
			<xsl:otherwise>
				<p:output port="result" 
						sequence="{if(matches(text(), '(\+|\*)$')) then 
								'true' else 'false'}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- Generates an option declaration, setting required='true' if the 
		 parameter requires at least one value. -->
	<xsl:template match="apidoc:param[not(matches(@type, $ELEMENT_TYPE))]" 
			mode="ml:options">
		
		<p:option name="ml-{@name}" 
				required="{not(xs:boolean(@optional))}">
			<xsl:apply-templates select="apidoc:summary" mode="ml:summary"/>
		</p:option>
	</xsl:template>
	
	
	<!-- Generates the external parameter param-sets. -->
	<xsl:template match="apidoc:params" mode="ml:params">
		<xsl:text>&#10;&#10;</xsl:text>
		<xsl:variable name="params" as="element()*">
			<xsl:apply-templates select="apidoc:param" mode="ml:set-params"/>
		</xsl:variable>
		
		<p:identity>
			<xsl:if test="not($params)">
				<xsl:attribute name="name" select="'params'"/>
			</xsl:if>
			<p:input port="source">
				<p:inline exclude-inline-prefixes="#all">
					<c:param-set>
						<xsl:apply-templates select="apidoc:param" mode="#current"/>
					</c:param-set>
				</p:inline>
			</p:input>
		</p:identity>
		
		<xsl:copy-of select="$params"/>
	</xsl:template>
	
	
	<!-- Ignore config parameters. -->
	<xsl:template match="apidoc:param[@name = 'config']" mode="ml:params ml:set-params" priority="1"/>
	
	
	<!--  -->
	<xsl:template match="apidoc:param[not(matches(@type, $ELEMENT_TYPE))]" mode="ml:params">
		<c:param name="{ml:global-variabe-name(@name)}"/>
	</xsl:template>
	
	
	<!-- Generate the p:add-attribute steps to insert the option value(s) into
		 the c:paramset. -->
	<xsl:template match="apidoc:param[not(matches(@type, $ELEMENT_TYPE))]" mode="ml:set-params">
		<p:add-attribute match="//c:param[@name = '{ml:global-variabe-name(@name)}']" attribute-name="value">
			<xsl:if test="position() = last()">
				<xsl:attribute name="name" select="'params'"/>
			</xsl:if>
			<p:with-option name="attribute-value" select="$ml-{@name}">
				<p:pipe port="source" step="{ancestor::apidoc:function/@lib}-{ancestor::apidoc:function/@name}"/>
			</p:with-option>
		</p:add-attribute>
	</xsl:template>
	
	
	<!-- Ignore everything else. -->
	<xsl:template match="*" mode="ml:functions ml:summary ml:options ml:inputs ml:outputs ml:params ml:set-params"/>
	
	
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
