<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xdmp="http://marklogic.com/xdmp"
		xml:base="../../../"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="create-database-with-two-forests" 
		xpath-version="2.0"
		version="1.0">
	<p:documentation>Creates a database with more than one forest.</p:documentation>
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c ml p xdmp">
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="yes"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	
	<admin:get-configuration/>
	
	<mla:create-database database="wales" schema-db="Schemas" security-db="Security">
		<p:input port="forests">
			<p:inline>
				<mla:forests>
					<mla:forest name="swansea" host="hp6910-772b.marklogic.com" data-dir=""/>
					<mla:forest name="cardiff" host="hp6910-772b.marklogic.com" data-dir=""/>
				</mla:forests>
			</p:inline>
		</p:input>
	</mla:create-database>
	
</p:declare-step>
