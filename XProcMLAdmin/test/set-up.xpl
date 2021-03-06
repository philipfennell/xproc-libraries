<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:ml="http://www.marklogic.com"
		xmlns:p="http://www.w3.org/ns/xproc" 
		xmlns:xdmp="http://marklogic.com/xdmp"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="configure" 
		version="1.0"
		xpath-version="2.0">
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c ml p xdmp">
			<ml:connection user="admin" password="admin" host="localhost" port="8003"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="../build/ml-config/lib/xdmp.xpl"/>
	<p:import href="../build/ml-config/lib/admin.xpl"/>

	
	<xdmp:host name="host-id" ml-name="hp6910-772b.marklogic.com"/>
	<xdmp:database name="schema-db" ml-name="Schemas"/>
	<xdmp:database name="security-db" ml-name="Security"/>
	
	<admin:get-configuration/>
	
	<admin:forest-create ml-forest-name="neath" ml-data-directory="">
		<p:with-option name="ml-host-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="host-id"/>
		</p:with-option>
	</admin:forest-create>
	
	<admin:database-create ml-database-name="swansea">
		<p:with-option name="ml-security-db" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="security-db"/>
		</p:with-option>
		<p:with-option name="ml-schema-db" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="schema-db"/>
		</p:with-option>
	</admin:database-create>
	<admin:save-configuration-without-restart/>
	
	<xdmp:forest name="neath-forest" ml-name="neath"/>
	<xdmp:database name="swansea-db" ml-name="swansea"/>
	
	<admin:get-configuration/>
	<admin:database-attach-forest>
		<p:with-option name="ml-forest-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="neath-forest"/>
		</p:with-option>
		<p:with-option name="ml-database-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="swansea-db"/>
		</p:with-option>
	</admin:database-attach-forest>
	<admin:save-configuration-without-restart/>
</p:declare-step>