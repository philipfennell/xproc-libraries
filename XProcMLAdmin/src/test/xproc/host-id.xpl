<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xdmp="http://marklogic.com/xdmp"
		xml:base="../../../"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="test2" 
		xpath-version="2.0"
		version="1.0">
	<p:documentation>Creates a database with more than one forest.</p:documentation>
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c ml p xdmp">
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="false"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	
	<admin:get-configuration/>
	
	<xdmp:host name="host-id" ml-name="hp6910-772b.marklogic.com"/>
</p:declare-step>
