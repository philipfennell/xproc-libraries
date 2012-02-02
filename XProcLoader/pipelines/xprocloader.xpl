<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:file="http://www.marklogic.com/xproc/file/"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpl="http://www.marklogic.com/xprocloader/"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xml:base="../"
		exclude-inline-prefixes="xsi"
		version="1.0"
		name="xprocloader">
	
	<p:serialization port="result" indent="true" omit-xml-declaration="false" 
			method="xml" encoding="utf-8" media-type="application/atom+xml"/>
	
	<p:input port="source"/>
	<p:output port="result"/>
	
	<p:import href="pipelines/library-1.0.xpl"/>
	<p:import href="pipelines/lib-loader.xpl"/>
	
	
	<p:wrap-sequence name="create_job-bag" wrapper="ml:job-bag">
		<p:documentation>Wraps the source config in a job-bag container.</p:documentation>
	</p:wrap-sequence>
	
	<xpl:identify-files name="add-files">
		<p:documentation>Generates a list of files and inserts them into the job-bag.</p:documentation>
	</xpl:identify-files>
	
	<xpl:load name="load-documents"/>
	
	<p:identity>
		<p:input port="source">
			<p:pipe port="result" step="add-files"/>
		</p:input>
	</p:identity>
</p:declare-step>
