<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xdmp="http://marklogic.com/xdmp"
		exclude-inline-prefixes="admin c ml p xdmp" 
		name="test4" 
		xpath-version="2.0">
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c ml p xdmp">
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="false"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>

	<p:serialization port="result" encoding="utf-8" indent="true" media-type="application/xml"
		method="xml"/>

	<p:import href="../build/ml-config/lib/ml-config2.xpl"/>
	
	
	<admin:get-configuration/>
	
	<mla:create-forests>
		<p:input port="forests">
			<p:inline>
				<mla:forests>
					<mla:forest name="swansea" host="hp6910-772.marklogic.com" data-dir=""/>
				</mla:forests>
			</p:inline>
		</p:input>
	</mla:create-forests>
	
	<admin:save-configuration-without-restart/>
	
</p:declare-step>
