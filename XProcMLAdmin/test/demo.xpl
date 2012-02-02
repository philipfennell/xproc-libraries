<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step" 
		xmlns:ml="http://www.marklogic.com"
		xmlns:p="http://www.w3.org/ns/xproc" 
		xmlns:xdmp="http://marklogic.com/xdmp"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="demo" 
		version="1.0"
		xpath-version="2.0">
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c ml p xdmp">
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="no"/>
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
	
	<xdmp:forest name="forest" ml-name="neath"/>
	<xdmp:database name="content-db" ml-name="swansea"/>
	
	<admin:get-configuration/>
	<admin:database-attach-forest>
		<p:with-option name="ml-forest-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="forest"/>
		</p:with-option>
		<p:with-option name="ml-database-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="content-db"/>
		</p:with-option>
	</admin:database-attach-forest>
	<admin:save-configuration-without-restart/>
	
	<admin:get-configuration/>
	<admin:database-set-uri-lexicon ml-value="true">
		<p:with-option name="ml-database-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="content-db"/>
		</p:with-option>
	</admin:database-set-uri-lexicon>
	<admin:save-configuration-without-restart/>
	
	<xdmp:group name="group-id" ml-name="Default"/>
	<xdmp:database name="modules-db" ml-name="Modules"/>
	
	<admin:get-configuration/>
	<admin:xdbc-server-create 
			ml-appserver-name="8010-DEMO-XDBC"
			ml-root="/"
			ml-port="8010">
		<p:with-option name="ml-group-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="group-id"/>
		</p:with-option>
		<p:with-option name="ml-modules-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="modules-db"/>
		</p:with-option>
		<p:with-option name="ml-database-id" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="content-db"/>
		</p:with-option>
	</admin:xdbc-server-create>
	<admin:save-configuration-without-restart/>
</p:declare-step>