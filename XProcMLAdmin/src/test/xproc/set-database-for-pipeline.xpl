<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xdmp="http://marklogic.com/xdmp"
		xml:base="../../../"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="set-database-for-pipeline" 
		xpath-version="2.0"
		version="1.0">
	<p:documentation>Adds the database Id of the named database to the connection document.</p:documentation>
	<p:input port="connection" primary="true">
		<p:inline>
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="no" dry-run="no"/>
		</p:inline>
	</p:input>
	<p:input port="config" primary="false">
		<p:inline>
			<mla:database name="Documents">
				<mla:forests>
					<mla:forest name="_test-responder-config" host="hp6910-772.marklogic.com" datadir=""/>
				</mla:forests>
			</mla:database>
		</p:inline>
	</p:input>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	<mla:set-database-for-pipeline>
		<p:input port="config">
			<p:pipe port="config" step="set-database-for-pipeline"/>
		</p:input>
	</mla:set-database-for-pipeline>
</p:declare-step>
