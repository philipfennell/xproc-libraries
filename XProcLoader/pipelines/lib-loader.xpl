<?xml version="1.0" encoding="UTF-8"?>
<p:library 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:file="http://www.marklogic.com/xproc/file/"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpl="http://www.marklogic.com/xprocloader/"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xml:base="../"
		version="1.0">
	
	<p:import href="pipelines/core.xpl"/>
	
	<p:declare-step type="xpl:file-list">
		<p:documentation>Returns a list of files in the current directory</p:documentation>
		<p:input port="source"/>
		<p:output port="result" sequence="true"/>
		<p:option name="path"/>
		<p:option name="filter" select="'.*'"/>
		<p:option name="mode" select="'flat'"/><!-- flat|tree -->
		
		<p:directory-list name="directory">
			<p:with-option name="path" select="$path"/>
			<p:with-option name="include-filter" select="$filter"/>
			<p:with-option name="exclude-filter" select="'\.svn'">
				<p:documentation>Always exclude SVN directories.</p:documentation>
			</p:with-option>
		</p:directory-list>
		
		<p:for-each name="iterate">
			<p:iteration-source select="/c:directory/c:*"/>
			
			<p:variable name="entityName" select="/c:*/@name"/>
			<p:variable name="fileExtension" select="substring-after($entityName, '.')"/>
			
			<p:choose>
				<p:when test="name(/*) eq 'c:directory'">
					<xpl:file-list>
						<p:with-option name="path" select="concat($path, '/', $entityName)"/>
						<p:with-option name="mode" select="$mode"/>
					</xpl:file-list>
				</p:when>
				<p:otherwise>
					<p:add-attribute attribute-name="path" match="/c:file">
						<p:with-option name="attribute-value" select="concat($path, '/')"/>
					</p:add-attribute>
					<p:add-attribute attribute-name="type" match="/c:file">
						<p:with-option name="attribute-value" 
								select="if (matches($fileExtension, 'xml|xhtml|xsd|rng|sch|xslt|xsl|fo|svg|x3d|wadl|xpl')) then 'xml' 
										else if (matches($fileExtension, 'png|jpg|gif|tiff|mp3|mov')) then 'base64'
										else 'text'"/>
					</p:add-attribute>
				</p:otherwise>
			</p:choose>
			<p:choose>
				<p:when test="$mode eq 'flat'">
					<p:filter select="//c:file"/>
				</p:when>
				<p:otherwise>
					<p:identity/>
				</p:otherwise>
			</p:choose>
			
		</p:for-each>
		
		<p:wrap-sequence wrapper="c:directory"/>
		<p:add-attribute attribute-name="name" match="/*">
			<p:with-option name="attribute-value" select="subsequence(reverse(tokenize($path, '/')), 1, 1)"/>
		</p:add-attribute>
	</p:declare-step>
	
	
	<p:declare-step type="xpl:identify-files">
		<p:documentation>Outputs a file directory listing for the provided path</p:documentation>
		<p:input port="source" primary="true"/>
		<p:output port="result"/>		
		
		<p:variable name="path" select="/ml:job-bag/ml:config/ml:input-path/text()"/>
		<p:variable name="inputPattern" select="/ml:job-bag/ml:config/ml:input-pattern/text()"/>
		<p:variable name="defaultPattern" select="'^.+\.[Xx][Mm][Ll]$'"/>
		
		<p:identity name="job-bag"/>
		
		<xpl:file-list name="file-list">
			<p:with-option name="path" select="$path"/>
			<!--<p:with-option name="filter" select="if ($inputPattern != '') then $inputPattern else $defaultPattern"/>-->
		</xpl:file-list>
		
		<p:insert name="insert_file-list" match="/*" position="last-child">
			<p:documentation>Inserts the file list into the job-bag.</p:documentation>
			<p:input port="source">
				<p:pipe port="result" step="job-bag"/>
			</p:input>
			<p:input port="insertion">
				<p:pipe port="result" step="file-list"/>
			</p:input>
		</p:insert>
	</p:declare-step>
	
	
	<p:declare-step type="xpl:load">
		<p:documentation>Iterate over the file list, getting each document and load it into Mark Logic.</p:documentation>
		<p:input port="source"/>
		
		<p:variable name="ml:connectionString" select="/ml:job-bag/ml:config/ml:connection-string/text()"/>
		<p:variable name="ml:configFormat" select="/ml:job-bag/ml:config/ml:document-format/text()"/>
		<p:variable name="ml:inputPath" select="/ml:job-bag/ml:config/ml:input-path/text()"/>
		
		<p:for-each name="get-file-and-upload">
			<p:iteration-source select="/ml:job-bag//c:file"/>
			
			<p:variable name="ml:format" select="if ($ml:configFormat != '') then $ml:configFormat else /c:file/@type"/>
			<p:variable name="ml:uri" select="concat(/c:file/@path, /c:file/@name)"/>
			
			<p:load>
				<p:with-option name="href" select="$ml:uri"/>
			</p:load>
			
			<ml:insert-document collections="http://medline.org">
				<p:with-option name="user" select="subsequence(tokenize($ml:connectionString, ':|//|@'), 3, 1)"/>
				<p:with-option name="password" select="subsequence(tokenize($ml:connectionString, ':|//|@'), 4, 1)"/>
				<p:with-option name="host" select="subsequence(tokenize($ml:connectionString, ':|//|@'), 5, 1)"/>
				<p:with-option name="port" select="subsequence(tokenize($ml:connectionString, ':|//|@'), 6, 1)"/>
				<p:with-option name="format" select="$ml:format"/>
				<p:with-option name="uri" select="concat('/MedlineCitation/', $ml:uri)"/>
			</ml:insert-document>
			
		</p:for-each>
	</p:declare-step>
	
</p:library>
