<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpl="http://www.marklogic.com/xprocloader/"
		xml:base="../">
	<p:input port="source">
		<p:inline>
			<test xmlns="">
				<title>Test</title>
			</test>
		</p:inline>		
	</p:input>
	<p:output port="result"/>
	
	<p:import href="pipelines/library-1.0.xpl"/>
	<p:import href="pipelines/core.xpl"/>
	
	<xpl:content-to-entry>
		<p:with-option name="title" select="/test/title/text()"/>
	</xpl:content-to-entry>
	
	<!--<xpl:entry-to-request service="file:///C:/Users/pfennell/Projects/MarkLogic/users/pfennell/" collection="XProcLoader/configs/" method="get"/>
	
	<xpl:submit-request/>-->
</p:declare-step>
