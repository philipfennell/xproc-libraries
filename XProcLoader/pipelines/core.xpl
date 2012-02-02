<?xml version="1.0" encoding="UTF-8"?>
<p:library 
		xmlns:app="http://www.w3.org/2007/app"
		xmlns:as="http://services.bbc.co.uk/atomstore"
		xmlns:atom="http://www.w3.org/2005/Atom"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:test="http://www.test.bbc.co.uk/"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:xpl="http://www.marklogic.com/xprocloader/"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xml:base="../"
		version="1.0">
	
	<p:documentation>
		<h2>Core Library</h2>
		<p>XProc library.</p>
	</p:documentation>
	
	
	<p:declare-step type="xpl:files-from-zip">
		<p:documentation>For the passed ZIP file location, extract each document in the ZIP.</p:documentation>
		
		<p:input port="source"/>
		<p:output port="result" sequence="true"/>
		
		<p:option name="src"/>
		
		<cx:unzip content-type="application/xml">
			<p:with-option name="href" select="$src"/>
		</cx:unzip>
		
		<p:for-each >
			<p:iteration-source select="/c:zipfile/c:file"/>
			
			<cx:unzip content-type="application/xml">
				<p:with-option name="href" select="$src"/>
				<p:with-option name="file" select="/c:file/@name"/>
			</cx:unzip>
		</p:for-each>
	</p:declare-step>
	
	
	<p:declare-step type="xpl:content-to-entry"
			exclude-inline-prefixes="app atom as c cx p test xhtml xpl xs">
		<p:documentation>
			<p>Wrap content in an Atom Entry document, creating a UUID for each entry.</p>
		</p:documentation>
		
		<p:input port="source" sequence="true"/>
		<p:output port="result" sequence="true"/>
		
		<p:option name="title" select="'unknown'">
			<p:documentation>A human-readable title for the resource.</p:documentation>
		</p:option>
		
		<p:for-each name="make-entries">
			<p:iteration-source select="/*"/>
			
			<p:wrap-sequence wrapper="atom:content"/>
			<p:add-attribute match="/atom:content" attribute-name="type" attribute-value="application/xml"/>
			<p:wrap-sequence name="entry-wrapper" wrapper="atom:entry"/>
			
			<p:insert name="insert-updated" match="//atom:entry" position="first-child">
				<p:input port="source"/>
				<p:input port="insertion">
					<p:inline><atom:updated>xs:dateTime</atom:updated></p:inline>
				</p:input>
			</p:insert>
			<p:string-replace match="/atom:entry/atom:updated/text()" replace="current-dateTime()"/>
			
			<p:insert name="insert-title" match="//atom:entry" position="first-child">
				<p:input port="source"/>
				<p:input port="insertion">
					<p:inline><atom:title>xs:string</atom:title></p:inline>
				</p:input>
			</p:insert>
			<p:string-replace match="/atom:entry/atom:title/text()">
				<p:with-option name="replace" select="$title"/>
			</p:string-replace>
			
			<p:insert name="insert-uuid" match="/atom:entry" position="first-child">
				<p:input port="source"/>
				<p:input port="insertion">
					<p:inline><atom:id>urn:uuid:<uuid/></atom:id></p:inline>
				</p:input>
			</p:insert>
			<p:uuid match="/atom:entry/atom:id/uuid" version="4"/>
		</p:for-each>
	</p:declare-step>
	
	
	<p:declare-step type="xpl:entry-to-request">
		<p:documentation>
			<p>Takes a sequence of Atom Entry documents and wraps them in the body of an HTTP PUT request document.</p>
		</p:documentation>
		
		<p:input port="source" sequence="true"/>
		<p:output port="result" sequence="true"/>
		
		<p:option name="service"/>
		<p:option name="collection"/>
		<p:option name="method"/>
		
		<p:for-each>
			<p:iteration-source select="/atom:entry"/>
			
			<p:wrap-sequence wrapper="c:body"/>
			<p:add-attribute match="/c:body" attribute-name="content-type" attribute-value="application/xml"/>
			<p:wrap-sequence wrapper="c:request"/>
			<p:add-attribute match="/c:request" attribute-name="method">
				<p:with-option name="attribute-value" select="$method"/>
			</p:add-attribute>
			<p:add-attribute match="/c:request" attribute-name="override-content-type" attribute-value="text/plain"/>
			<p:add-attribute match="/c:request" attribute-name="href">
				<p:with-option name="attribute-value" select="concat($service, $collection, if (lower-case($method) = 'put') then 
						substring-after(/c:request/c:body/atom:entry/atom:id, 'urn:uuid:') else 
								/c:request/c:body/atom:entry/atom:id)"/>
			</p:add-attribute>
			<p:add-attribute match="/c:request" attribute-name="detailed" attribute-value="true"/>
			
			<cx:message>
				<p:with-option name="message" select="concat('[test:feed-to-requests] ', /c:request/@href)"/>
			</cx:message>
		</p:for-each>
	</p:declare-step>
	
	
	<p:declare-step type="xpl:file-to-get-request">
		<p:documentation>
			<p>Takes a sequence of file references and creates an HTTP PUT request document.</p>
		</p:documentation>
		
		<p:input port="source"/>
		<p:output port="result"/>
			
		<p:wrap-sequence wrapper="c:request"/>
		<p:add-attribute match="/c:request" attribute-name="method" attribute-value="'get'"/>
		<p:add-attribute match="/c:request" attribute-name="override-content-type">
			<p:with-option name="attribute-value" select="if (/c:request/c:file/@type = 'xml') then 'application/xml' else 'text/plain'"/>
		</p:add-attribute>
		<p:add-attribute match="/c:request" attribute-name="href">
			<p:with-option name="attribute-value" select="concat(/c:request/c:file/@path, /c:request/c:file/@name)"/>
		</p:add-attribute>
		<p:make-absolute-uris match="/c:request/@href"/>
		<p:string-replace match="/c:request/@href" replace="replace(., 'file:', 'file://')">
			<p:documentation>Fixes the URI so that it can be used by the http-request step.</p:documentation>
		</p:string-replace>
		<p:add-attribute match="/c:request" attribute-name="detailed" attribute-value="true"/>
		<p:delete match="/c:request/c:file"/>
	</p:declare-step>
	
	
	<p:declare-step type="xpl:submit-request">
		<p:documentation>
			<p>Takes a sequence of XProc request documents and submits them over HTTP.</p> 
		</p:documentation>
		
		<p:input port="source" sequence="true"/>
		<p:output port="result"/>
		
		<p:for-each>
			<p:iteration-source select="/c:request"/>
			
			<p:http-request indent="true" method="xml" encoding="utf-8" media-type="application/xml"/>
			
			<cx:message>
				<p:with-option name="message" select="concat('[test:create-entries] ', name(/*))"/>
			</cx:message>
		</p:for-each>
	
		<p:wrap-sequence wrapper="c:responses"/>
	</p:declare-step>
	
	
	<p:declare-step type="test:begin-time">
		<p:documentation>
			<p>Inserts a 'test:begin-time' attribute into the context element with the value of the date/time when this step is processed.</p>
			<p>Use this step to mark the time a pipeline began.</p>
		</p:documentation>
		
		<p:input port="source"/>
		<p:output port="result"/>
		
		<p:add-attribute match="*" attribute-name="test:begin-time" >
			<p:with-option name="attribute-value" select="current-dateTime()"/>
		</p:add-attribute>
	</p:declare-step>
	
	
	<p:declare-step type="test:split-time">	
		<p:documentation>
			<p>Inserts a 'test:split-time' attribute into the context element with the value of the date/time when this step is processed.</p>
			<p>Use this step to mark the time an arbitrary step began. I could be used within a for-each loop to show when each iteration was processed.</p>
		</p:documentation>
		
		<p:input port="source"/>
		<p:output port="result"/>
		
		<p:add-attribute match="*" attribute-name="test:split-time" >
			<p:with-option name="attribute-value" select="current-dateTime()"/>
		</p:add-attribute>
	</p:declare-step>
	
	
	<p:declare-step type="test:end-time">
		<p:documentation>
			<p>Inserts an 'test:end-time' attribute into the context element with the value of the date/time when this step is processed.</p>
			<p>Use this step to mark the time a pipeline ended.</p>
		</p:documentation>
		
		<p:input port="source"/>
		<p:output port="result"/>
		
		<p:add-attribute match="*" attribute-name="test:end-time" >
			<p:with-option name="attribute-value" select="current-dateTime()"/>
		</p:add-attribute>
	</p:declare-step>
</p:library>