<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
	xmlns:admin="http://marklogic.com/xdmp/admin"
	xmlns:ml="http://www.marklogic.com"
	xmlns:mla="http://www.marklogic.com/admin"
	xmlns:p="http://www.w3.org/ns/xproc"
	xml:base="../../../" 
	name="yellcontent" 
	xpath-version="2.0">
	<p:documentation>Creates the yellcontent database.</p:documentation>
	<p:input port="connection"/>
	<p:output port="result"/>
	
	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	<mla:create-database-from-config>
		<p:input port="config">
			<p:inline>
				<mla:database name="yellcontent">
					<mla:forests>
						<mla:forest name="poicontent01" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="yellcontent00" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="yelllocations" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="yellwebcrawl" host="hp6910-772.marklogic.com" datadir=""/>
					</mla:forests>
				</mla:database>
			</p:inline>
		</p:input>
	</mla:create-database-from-config>
	
	<mla:trailing-wildcard-searches value="true"/>
	<mla:word-searches value="true"/>
	<mla:word-positions value="true"/>
</p:declare-step>