<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xdmp="http://marklogic.com/xdmp"
		xml:base="../../../"
		exclude-inline-prefixes="admin cxml ml p"
		name="create-http-appserver"
		version="1.0"
		xpath-version="2.0">
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c p xdmp">
			<ml:connection user="admin" password="admin" host="localhost" port="8003"
					debug="yes" dry-run="no" silent="no"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xml" method="xml"/>
	
	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	
	<mla:create-http-appserver host="hp6910-772b.marklogic.com" server-name="http-eoi-8050" 
			root="/" port="8050" modules="Modules" database="eoi-content"/>
	
</p:declare-step>
