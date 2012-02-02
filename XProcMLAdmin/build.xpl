<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:apidoc="http://marklogic.com/xdmp/apidoc"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:p="http://www.w3.org/ns/xproc"
		name="build"
		version="1.0">
	<p:documentation>Build the MarkLogic Server Admin Pipeline Tool Kit</p:documentation>
	
	<p:input port="source" sequence="true">
		<p:document href="src/main/resources/apidocs/admin.xml"/>
		<p:document href="src/main/resources/apidocs/xdmp.xml"/>
	</p:input>
	
	
	<p:declare-step name="build-lib" type="ml:build-lib">
		<p:documentation>Generates an XProc library and support XQuery modules from the source document.</p:documentation>
		<p:input port="source"/>
		
		<p:variable name="OUTPUT_PATH" select="'build/ml-config/lib/'"/>
		<p:variable name="MODULE_NAME" select="/apidoc:module/@lib"/>
	
		<p:load name="xproc-transform">
			<p:documentation>Load the transform for the context library.</p:documentation>
			<p:with-option name="href" select="concat('xslt/', $MODULE_NAME, '-xproc-library.xsl')">
				<p:pipe port="source" step="build-lib"/>
			</p:with-option>
		</p:load>
		<p:sink/>
		
		<p:xslt version="2.0" name="xproc-library">
			<p:documentation>Transform the API documentation to an XProc library.</p:documentation>
			<p:input port="source">
				<p:pipe port="source" step="build-lib"/>
			</p:input>
			<p:input port="stylesheet">
				<p:pipe port="result" step="xproc-transform"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
		</p:xslt>
		
		<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
				method="xml">
			<p:documentation>Store the XProc library.</p:documentation>
			<p:with-option name="href" select="concat($OUTPUT_PATH, $MODULE_NAME, '.xpl')"/>
		</p:store>
		
		<p:xslt version="2.0" name="xquery-modules">
			<p:documentation>Transform the API documentation to a set of XQuery main modules.</p:documentation>
			<p:input port="source">
				<p:pipe port="source" step="build-lib"/>
			</p:input>
			<p:input port="stylesheet">
				<p:document href="xslt/xquery-modules.xsl"/>
			</p:input>
			<p:input port="parameters">
				<p:empty/>
			</p:input>
		</p:xslt>
		
		<p:for-each>
			<p:documentation>Store the queries.</p:documentation>
			<p:iteration-source select="/c:results/c:data"/>
			
			<p:store method="text" media-type="application/xquery" encoding="utf-8">
				<p:with-option name="href" select="concat($OUTPUT_PATH, 'xquery/', $MODULE_NAME, '/', /c:data/@name, '.xqy')"/>
			</p:store>
		</p:for-each>
	</p:declare-step>
	
	<p:for-each>
		<p:documentation>Build the library from each doc.</p:documentation>
		<ml:build-lib/>
	</p:for-each>
	
	
	
	<p:load href="src/main/resources/localhost.xml"/>	
	<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
			method="xml" href="build/ml-config/localost.xml"/>
	
	<p:load href="src/main/resources/configure.xpl"/>	
	<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
			method="xml" href="build/ml-config/configure.xpl"/>
	
	<p:load href="src/main/xproc/ml-config.xpl"/>	
	<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
			method="xml" href="build/ml-config/lib/ml-config.xpl"/>
	
	<p:load href="src/main/xproc/ml-server.xpl"/>	
	<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
			method="xml" href="build/ml-config/lib/ml-server.xpl"/>
	
	<p:load href="src/main/xproc/library-1.0.xpl"/>	
	<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
			method="xml" href="build/ml-config/lib/library-1.0.xpl"/>
	
	<p:load href="src/main/xproc/db-properties.xpl"/>	
	<p:store encoding="utf-8" indent="true" media-type="application/xproc+xml"
			method="xml" href="build/ml-config/lib/db-properties.xpl"/>
</p:declare-step>
