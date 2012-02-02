<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xdmp="http://marklogic.com/xdmp"
		xml:base="../../../"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="yell-config" 
		xpath-version="2.0">
	<p:documentation>Creates a set of databases forest forest.</p:documentation>
	<p:input port="connection" primary="true"/>
	<p:input port="config" primary="false"/>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	<mla:create-databases>
		<p:input port="config">
			<p:pipe port="config" step="yell-config"/>
		</p:input>
	</mla:create-databases>
</p:declare-step>
