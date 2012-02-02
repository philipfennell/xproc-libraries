<p:library xmlns:admin="http://marklogic.com/xdmp/admin"
           xmlns:c="http://www.w3.org/ns/xproc-step"
           xmlns:cx="http://xmlcalabash.com/ns/extensions"
           xmlns:cxu="http://xmlcalabash.com/ns/extensions/xmlunit"
           xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
           xmlns:ml="http://www.marklogic.com"
           xmlns:p="http://www.w3.org/ns/xproc"
           version="1.0">
	
	  <p:import href="library-1.0.xpl"/>
	

	  <p:declare-step name="ml-action" type="ml:action">
	    <p:documentation>Evaluates the 'source' query in the context of the host specified in the connection.</p:documentation>
	    <p:input port="source" primary="true"/>
	    <p:input port="connection"/>
	    <p:input port="params" kind="parameter"/>
	    <p:output port="result"/>
	  	
		    <p:choose>
			      <p:documentation>By default, print the name of the current action 
				to stdout. If silent is 'yes' then do nothing.</p:documentation>
			      <p:when test="/ml:connection/@silent = 'yes'">
				        <p:xpath-context>
					          <p:pipe port="connection" step="ml-action"/>
				        </p:xpath-context>
				
				        <p:identity/>
			      </p:when>
			      <p:otherwise>				
				        <cx:message>
					          <p:with-option name="message" select="concat('[XProc] ', /*/@step-type)"/>
				        </cx:message>
			      </p:otherwise>
	  	  </p:choose>
	  	
	  	  <p:choose>
	  		    <p:documentation>If debug is 'yes' then print the query to stdout.</p:documentation>
	  		    <p:when test="/ml:connection/@debug = 'yes'">
	  			      <p:xpath-context>
	  				        <p:pipe port="connection" step="ml-action"/>
	  			      </p:xpath-context>
	  			      <cx:message>
	  				        <p:with-option name="message" select="concat('[XProc] ', /*/text())"/>
	  			      </cx:message>
	  		    </p:when>
	  		    <p:otherwise>
	  			      <p:identity/>
	  		    </p:otherwise>
	  	  </p:choose>
	  
		    <p:choose>
			      <p:documentation>If dry-run is 'yes' then no request is made to MarkLogic.</p:documentation>
			      <p:when test="/ml:connection/@dry-run = 'yes'">
				        <p:xpath-context>
					          <p:pipe port="connection" step="ml-action"/>
				        </p:xpath-context>
				        <p:identity>
					          <p:input port="source">
						            <p:inline>
                     <ml:action/>
                  </p:inline>
					          </p:input>
				        </p:identity>
			      </p:when>
			      <p:otherwise>
				        <cxml:adhoc-query wrapper="c:result">
					          <p:input port="source"/>
					          <p:input port="parameters">
						            <p:pipe port="params" step="ml-action"/>
					          </p:input>
					          <p:with-option name="user" select="/ml:connection/@user">
						            <p:pipe port="connection" step="ml-action"/>
					          </p:with-option>
					          <p:with-option name="password" select="/ml:connection/@password">
						            <p:pipe port="connection" step="ml-action"/>
					          </p:with-option>
					          <p:with-option name="host" select="/ml:connection/@host">
						            <p:pipe port="connection" step="ml-action"/>
					          </p:with-option>
					          <p:with-option name="port" select="/ml:connection/@port">
						            <p:pipe port="connection" step="ml-action"/>
					          </p:with-option>
				        </cxml:adhoc-query>
			      </p:otherwise>
		    </p:choose>
	  </p:declare-step>
</p:library>