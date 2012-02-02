<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xml:base="../"
		exclude-inline-prefixes="xsi"
		name="config2xml">
	<!-- xsi:schemaLocation="http://www.w3.org/TR/xproc/schemas/xproc.xsd ../schemata/xproc.xsd" -->
	
	<p:serialization port="result" indent="true" omit-xml-declaration="false" 
			method="xml" encoding="utf-8" media-type="application/xml"/>
	
	<p:input port="source">
		<p:data href="configs/config.properties" content-type="text/plain"/>
	</p:input>
	<p:output port="result"/>
	
	<p:xquery>
		<p:input port="query">
			<p:data href="queries/config2xml.xqy" content-type="text/plain"/>
		</p:input>
		<p:input port="parameters">
			<p:empty/>
		</p:input>
	</p:xquery>
</p:declare-step>
