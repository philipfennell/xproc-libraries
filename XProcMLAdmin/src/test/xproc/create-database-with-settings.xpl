<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xml:base="../../../"
		exclude-inline-prefixes="admin ml mla p" 
		name="create-database-with-settings" 
		version="1.0"
		xpath-version="2.0">
	<p:documentation>Creates a database, its forest(s) and applies database settings.</p:documentation>
	<p:input port="connection" primary="true">
		<p:inline>
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="no" dry-run="yes"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	<mla:create-database-from-config>
		<p:input port="config">
			<p:inline>
				<mla:database name="_test-databse">
					<mla:forests>
						<mla:forest name="_test-forest" host="hp6910-772b.marklogic.com" datadir=""/>
					</mla:forests>
				</mla:database>
			</p:inline>
		</p:input>
	</mla:create-database-from-config>
	
	<mla:language value="it"/>
	
	<admin:save-configuration-without-restart/>
	
</p:declare-step>
