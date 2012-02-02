<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xml:base="../../../" 
		name="tear-down_yellcontent" 
		xpath-version="2.0">
	<p:documentation>Deletes the yellcontent database and it's forests.</p:documentation>
	<p:input port="connection">
		<p:inline>
			<ml:connection user="admin" password="admin" host="localhost" port="8003" debug="yes" dry-run="no"/>
		</p:inline>
	</p:input>
	<p:output port="result"/>
	
	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	<mla:delete-database-from-config>
		<p:input port="config">
			<p:inline>
				<mla:database name="_yellcontent">
					<mla:forests>
						<mla:forest name="_poicontent01" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent00" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent01" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent02" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent03" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="_yelllocations" host="hp6910-772.marklogic.com" datadir=""/>
						<mla:forest name="_yellwebcrawl" host="hp6910-772.marklogic.com" datadir=""/>
					</mla:forests>
				</mla:database>
			</p:inline>
		</p:input>
	</mla:delete-database-from-config>
</p:declare-step>
