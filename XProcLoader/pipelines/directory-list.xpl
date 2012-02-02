<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:cx="http://xmlcalabash.com/ns/extensions"
	xmlns:file="http://www.marklogic.com/xproc/file/"
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xml:base="../"
	name="directory-list">
	
	<p:input port="source"/>
	<p:output port="result" sequence="true"/>
	
	<p:declare-step type="file:list">
		<p:documentation>Returns a list of files in the current directory</p:documentation>
		<p:input port="source"/>
		<p:output port="result" sequence="true"/>
		<p:option name="path"/>
		<p:option name="filter" select="'.*'"/>
		<p:option name="mode" select="'flat'"/><!-- flat|tree -->
		
		<p:directory-list name="directory">
			<p:with-option name="path" select="$path"/>
			<p:with-option name="include-filter" select="$filter"/>
		</p:directory-list>
		
		<p:for-each name="iterate">
			<p:iteration-source select="/c:directory/c:*"/>
			
			<p:variable name="entityName" select="/c:*/@name"/>
			
			<p:choose>
				<p:when test="name(/*) = 'c:directory'">
					
					<file:list>
						<p:with-option name="path" select="concat($path, '/', $entityName)"/>
						<p:with-option name="mode" select="$mode"/>
					</file:list>
				</p:when>
				<p:otherwise>
					<p:identity/>
					<p:add-attribute attribute-name="path" match="/*">
						<p:with-option name="attribute-value" select="concat($path, '/', $entityName)"/>
					</p:add-attribute>
				</p:otherwise>
			</p:choose>
		</p:for-each>
		
		<p:wrap-sequence wrapper="c:directory"/>
		<p:add-attribute attribute-name="name" match="/*">
			<p:with-option name="attribute-value" select="subsequence(reverse(tokenize($path, '/')), 1, 1)"/>
		</p:add-attribute>
		
		<p:choose>
			<p:when test="$mode = 'flat'">
				<p:unwrap match="/c:directory"/>
			</p:when>
			<p:otherwise>
				<p:identity/>
			</p:otherwise>
		</p:choose>
	</p:declare-step>
	
	<!--  filter="^.+\.[Xx][Mm][Ll]$" -->
	<file:list path="content" mode="flat"/>
	
</p:declare-step>
