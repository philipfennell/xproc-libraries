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

	
	<xdmp:forest name="forest" ml-name="neath"/>
	<xdmp:database name="content-db" ml-name="swansea"/>
	
	<admin:get-configuration/>
	
	<admin:database-delete>
		<p:with-option name="ml-database-ids" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="content-db"/>
		</p:with-option>
	</admin:database-delete>
	<admin:save-configuration-without-restart/>
	
	<admin:forest-delete ml-delete-data="true">
		<p:with-option name="ml-forest-ids" select="/ml:connection/c:result/text()">
			<p:pipe port="result" step="forest"/>
		</p:with-option>
	</admin:forest-delete>
	<admin:save-configuration-without-restart/>
</p:declare-step>