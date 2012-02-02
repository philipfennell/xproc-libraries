<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:ml="http://www.marklogic.com"
		xmlns:p="http://www.w3.org/ns/xproc"
		xml:base="../../../"
		exclude-inline-prefixes="admin c ml p"
		name="admin"
		xpath-version="2.0">
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c p">
			<ml:connection user="admin" password="admin" host="localhost" port="8003"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xml" method="xml"/>
	
	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	
	<admin:get-configuration/>
	<admin:database-get-fields ml-database-id="6415349236392110717"/>
	
</p:declare-step>
