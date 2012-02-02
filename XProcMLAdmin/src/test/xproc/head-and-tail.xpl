<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xml:base="../../../"
		exclude-inline-prefixes="admin c cxml ml p"
		name="head-and-tail"
		xpath-version="2.0">
	<p:input port="source" primary="true">
		<p:inline exclude-inline-prefixes="admin c p">
			<configuration/>
		</p:inline>
	</p:input>
	<p:output port="result"/>
	
	<p:serialization port="result" encoding="utf-8" indent="true" 
			media-type="application/xml" method="xml"/>
	
	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	
	<mla:forests name="test">
		<p:input port="forests">
			<p:inline>
				<mla:forests>
					<mla:forest name="swansea" host="hp6910-772.marklogic.com" data-dir=""/>
					<mla:forest name="cardiff" host="hp6910-772.marklogic.com" data-dir=""/>
					<mla:forest name="newport" host="hp6910-772.marklogic.com" data-dir=""/>
				</mla:forests>
			</p:inline>
		</p:input>
	</mla:forests>
	
	<p:wrap-sequence wrapper="c:test-results"/>
	<p:insert match="/c:test-results" position="last-child">
		<p:input port="insertion">
			<p:pipe port="head" step="test"/>
		</p:input>
	</p:insert>
	<p:insert match="/c:test-results" position="last-child">
		<p:input port="insertion">
			<p:pipe port="tail" step="test"/>
		</p:input>
	</p:insert>
	
</p:declare-step>
