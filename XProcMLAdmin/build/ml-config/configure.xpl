<p:declare-step xmlns:admin="http://marklogic.com/xdmp/admin"
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
	
	  <p:import href="lib/xdmp.xpl"/>
	  <p:import href="lib/admin.xpl"/>
	
	  <admin:get-configuration/>
</p:declare-step>