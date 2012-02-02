<p:library xmlns:admin="http://marklogic.com/xdmp/admin"
           xmlns:c="http://www.w3.org/ns/xproc-step"
           xmlns:cx="http://xmlcalabash.com/ns/extensions"
           xmlns:ml="http://www.marklogic.com"
           xmlns:mla="http://www.marklogic.com/admin"
           xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:xdmp="http://marklogic.com/xdmp"
           xpath-version="2.0"
           version="1.0">
	  <p:documentation>Advanced XProc library which has more fully featured ML Admin
		steps.</p:documentation>

	  <p:import href="xdmp.xpl"/>
	  <p:import href="admin.xpl"/>
	  <p:import href="db-properties.xpl"/>


	  <p:declare-step name="mla-set-database-for-pipeline" type="mla:set-database-for-pipeline">
		    <p:documentation>Adds the database Id to the connection details.</p:documentation>
		    <p:input port="connection" primary="true"/>
		    <p:input port="config" primary="false"/>
		    <p:output port="result"/>

		    <xdmp:database name="database-id">
			      <p:with-option name="ml-name" select="/mla:database/@name">
				        <p:pipe port="config" step="mla-set-database-for-pipeline"/>
			      </p:with-option>
		    </xdmp:database>

		    <p:add-attribute match="/*" attribute-name="database-id">
			      <p:input port="source">
				        <p:pipe port="connection" step="mla-set-database-for-pipeline"/>
			      </p:input>
			      <p:with-option name="attribute-value" select="/ml:connection/c:result/text()">
				        <p:pipe port="result" step="database-id"/>
			      </p:with-option>
		    </p:add-attribute>
	  </p:declare-step>


	  <p:declare-step name="mla-forests" type="mla:forests">
		    <p:documentation>For the given connection and forest sequence return the connection, the
			first 'head' forest and the remaining 'tail' forests.</p:documentation>
		    <p:input port="source" primary="true"/>
		    <p:input port="forests" primary="false"/>
		    <p:output port="result" primary="true">
			      <p:pipe port="source" step="mla-forests"/>
		    </p:output>
		    <p:output port="head" primary="false">
			      <p:pipe port="result" step="forests-head"/>
		    </p:output>
		    <p:output port="tail" primary="false">
			      <p:pipe port="result" step="forests-tail"/>
		    </p:output>

		    <p:identity name="forests-head">
			      <p:input port="source" select="/mla:forests/mla:forest[1]">
				        <p:pipe port="forests" step="mla-forests"/>
			      </p:input>
		    </p:identity>

		    <p:delete name="forests-tail" match="/mla:forests/mla:forest[1]">
			      <p:input port="source">
				        <p:pipe port="forests" step="mla-forests"/>
			      </p:input>
		    </p:delete>
	  </p:declare-step>


	  <p:declare-step name="mla-create-forests" type="mla:create-forests">
		    <p:documentation>Recursively process a sequence of Forest declarations, creating then as it
			goes.</p:documentation>
		    <p:input port="connection" primary="true">
			      <p:documentation>The connection/configuration document.</p:documentation>
		    </p:input>
		    <p:input port="forests">
			      <p:documentation>A set of forests to be attached to the context
				database.</p:documentation>
		    </p:input>
		    <p:output port="result"/>

		    <p:choose>
			      <p:when test="exists(/mla:forests/*)">
				        <p:xpath-context>
					          <p:pipe port="forests" step="mla-create-forests"/>
				        </p:xpath-context>

				        <mla:forests name="forests">
					          <p:input port="forests">
						            <p:pipe port="forests" step="mla-create-forests"/>
					          </p:input>
				        </mla:forests>

				        <xdmp:host name="host-id">
					          <p:with-option name="ml-name" select="/mla:forest/@host">
						            <p:pipe port="head" step="forests"/>
					          </p:with-option>
				        </xdmp:host>

				        <p:sink/>

				        <admin:forest-create name="forest-create">
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-create-forests"/>
					          </p:input>
					          <p:with-option name="ml-forest-name" select="/mla:forest/@name">
						            <p:pipe port="head" step="forests"/>
					          </p:with-option>
					          <p:with-option name="ml-data-directory" select="/mla:forest/@data-dir">
						            <p:pipe port="head" step="forests"/>
					          </p:with-option>
					          <p:with-option name="ml-host-id" select="/ml:connection/c:result/text()">
						            <p:pipe port="result" step="host-id"/>
					          </p:with-option>
				        </admin:forest-create>

				        <mla:create-forests>
					          <p:input port="forests">
						            <p:pipe port="tail" step="forests"/>
					          </p:input>
				        </mla:create-forests>
			      </p:when>
			      <p:otherwise>
				        <p:identity>
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-create-forests"/>
					          </p:input>
				        </p:identity>
			      </p:otherwise>
		    </p:choose>
	  </p:declare-step>


	  <p:declare-step name="mla-database-attach-forests" type="mla:database-attach-forests">
		    <p:documentation>Recursively process a sequence of Forest, attaching them to the target
			database.</p:documentation>
		    <p:input port="connection" primary="true">
			      <p:documentation>The connection/configuration document.</p:documentation>
		    </p:input>
		    <p:input port="forests">
			      <p:documentation>A set of forests to be attached to the context
				database.</p:documentation>
		    </p:input>
		    <p:output port="result"/>

		    <p:option name="database-name">
			      <p:documentation>The name of the database to be created.</p:documentation>
		    </p:option>

		    <p:choose>
			      <p:when test="exists(/mla:forests/*)">
				        <p:xpath-context>
					          <p:pipe port="forests" step="mla-database-attach-forests"/>
				        </p:xpath-context>

				        <mla:forests name="forests">
					          <p:input port="forests">
						            <p:pipe port="forests" step="mla-database-attach-forests"/>
					          </p:input>
				        </mla:forests>

				        <xdmp:forest name="forest-id">
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-database-attach-forests"/>
					          </p:input>
					          <p:with-option name="ml-name" select="/mla:forest/@name">
						            <p:pipe port="head" step="forests"/>
					          </p:with-option>
				        </xdmp:forest>

				        <xdmp:database name="database-id">
					          <p:with-option name="ml-name" select="$database-name">
						            <p:pipe port="connection" step="mla-database-attach-forests"/>
					          </p:with-option>
				        </xdmp:database>

				        <p:sink/>

				        <admin:database-attach-forest>
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-database-attach-forests"/>
					          </p:input>
					          <p:with-option name="ml-forest-id" select="/ml:connection/c:result/text()">
						            <p:pipe port="result" step="forest-id"/>
					          </p:with-option>
					          <p:with-option name="ml-database-id" select="/ml:connection/c:result/text()">
						            <p:pipe port="result" step="database-id"/>
					          </p:with-option>
				        </admin:database-attach-forest>

				        <mla:database-attach-forests>
					          <p:input port="forests">
						            <p:pipe port="tail" step="forests"/>
					          </p:input>
					          <p:with-option name="database-name" select="$database-name">
						            <p:pipe port="connection" step="mla-database-attach-forests"/>
					          </p:with-option>
				        </mla:database-attach-forests>
			      </p:when>
			      <p:otherwise>
				        <p:identity>
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-database-attach-forests"/>
					          </p:input>
				        </p:identity>
			      </p:otherwise>
		    </p:choose>
	  </p:declare-step>




	  <p:declare-step name="mla-create-database" type="mla:create-database">
		    <p:documentation>Creates a database and joins it to the set of forest
			names.</p:documentation>
		    <p:input port="connection" primary="true">
			      <p:documentation>The connection/configuration document.</p:documentation>
		    </p:input>
		    <p:input port="forests">
			      <p:documentation>A set of forests to be attached to the context
				database.</p:documentation>
		    </p:input>
		    <p:output port="result">
			      <p:documentation>The updated configuration document.</p:documentation>
		    </p:output>

		    <p:option name="database">
			      <p:documentation>The name of the database to be created.</p:documentation>
		    </p:option>
		    <p:option name="schema-db">
			      <p:documentation>The name of the associated Schema database.</p:documentation>
		    </p:option>
		    <p:option name="security-db">
			      <p:documentation>The name of the associated Security database.</p:documentation>
		    </p:option>

		    <xdmp:database name="schema-db">
			      <p:with-option name="ml-name" select="$schema-db"/>
		    </xdmp:database>
		    <xdmp:database name="security-db">
			      <p:with-option name="ml-name" select="$security-db"/>
		    </xdmp:database>
		    <p:sink/>

		    <mla:create-forests name="forests">
			      <p:input port="connection">
				        <p:pipe port="connection" step="mla-create-database"/>
			      </p:input>
			      <p:input port="forests">
				        <p:pipe port="forests" step="mla-create-database"/>
			      </p:input>
		    </mla:create-forests>

		    <admin:database-create>
			      <p:with-option name="ml-database-name" select="$database">
				        <p:pipe port="connection" step="mla-create-database"/>
			      </p:with-option>
			      <p:with-option name="ml-security-db" select="/ml:connection/c:result/text()">
				        <p:pipe port="result" step="security-db"/>
			      </p:with-option>
			      <p:with-option name="ml-schema-db" select="/ml:connection/c:result/text()">
				        <p:pipe port="result" step="schema-db"/>
			      </p:with-option>
		    </admin:database-create>

		    <admin:save-configuration-without-restart/>

		    <admin:get-configuration/>

		    <mla:database-attach-forests>
			      <p:input port="forests">
				        <p:pipe port="forests" step="mla-create-database"/>
			      </p:input>
			      <p:with-option name="database-name" select="$database">
				        <p:pipe port="connection" step="mla-create-database"/>
			      </p:with-option>
		    </mla:database-attach-forests>

		    <admin:save-configuration-without-restart/>
	  </p:declare-step>


	  <p:declare-step name="mla-create-databases" type="mla:create-databases">
		    <p:documentation>Creates a set of databases and forests from the config document passed in
			on the config port.</p:documentation>
		    <p:input port="connection" primary="true"/>
		    <p:input port="config" primary="false"/>
		    <p:output port="result"/>

		    <p:for-each>
			      <p:iteration-source select="/mla:config/mla:databases/mla:database">
				        <p:pipe port="config" step="mla-create-databases"/>
			      </p:iteration-source>

			      <p:identity name="database"/>
			      <p:sink/>

			      <admin:get-configuration>
				        <p:input port="source">
					          <p:pipe port="connection" step="mla-create-databases"/>
				        </p:input>
			      </admin:get-configuration>

			      <mla:create-database schema-db="Schemas" security-db="Security">
				        <p:input port="forests" select="/mla:database/mla:forests">
					          <p:pipe port="result" step="database"/>
				        </p:input>
				        <p:with-option name="database" select="/mla:database/@name">
					          <p:pipe port="result" step="database"/>
				        </p:with-option>
			      </mla:create-database>
		    </p:for-each>

		    <p:wrap-sequence wrapper="mla:result"/>
	  </p:declare-step>


	  <p:declare-step name="mla-create-database-from-config" type="mla:create-database-from-config">
		    <p:documentation>Creates a database and forests with respect to the config document passed
			in on the config port.</p:documentation>
		    <p:input port="connection" primary="true"/>
		    <p:input port="config" primary="false"/>
		    <p:output port="result"/>

		    <admin:get-configuration name="ml-config"/>

		    <mla:create-database schema-db="Schemas" security-db="Security">
			      <p:input port="forests" select="/mla:database/mla:forests">
				        <p:pipe port="config" step="mla-create-database-from-config"/>
			      </p:input>
			      <p:with-option name="database" select="/mla:database/@name">
				        <p:pipe port="config" step="mla-create-database-from-config"/>
			      </p:with-option>
		    </mla:create-database>

		    <mla:set-database-for-pipeline>
			      <p:input port="config">
				        <p:pipe port="config" step="mla-create-database-from-config"/>
			      </p:input>
		    </mla:set-database-for-pipeline>

		    <p:insert match="/*" position="first-child">
			      <p:input port="insertion" select="/ml:connection/configuration">
				        <p:pipe port="result" step="ml-config"/>
			      </p:input>
		    </p:insert>
	  </p:declare-step>


	  <p:declare-step name="mla-delete-forests" type="mla:delete-forests">
		    <p:documentation>Recursively process a sequence of Forest declarations, deleting then as it
			goes.</p:documentation>
		    <p:input port="connection" primary="true">
			      <p:documentation>The connection/configuration document.</p:documentation>
		    </p:input>
		    <p:input port="forests">
			      <p:documentation>A set of forests to be removed.</p:documentation>
		    </p:input>
		    <p:output port="result"/>

		    <p:choose>
			      <p:when test="exists(/mla:forests/*)">
				        <p:xpath-context>
					          <p:pipe port="forests" step="mla-delete-forests"/>
				        </p:xpath-context>

				        <mla:forests name="forests">
					          <p:input port="forests">
						            <p:pipe port="forests" step="mla-delete-forests"/>
					          </p:input>
				        </mla:forests>

				        <xdmp:forest name="forest-id">
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-delete-forests"/>
					          </p:input>
					          <p:with-option name="ml-name" select="/mla:forest/@name">
						            <p:pipe port="head" step="forests"/>
					          </p:with-option>
				        </xdmp:forest>

				        <admin:forest-delete name="forest-delete">
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-delete-forests"/>
					          </p:input>
					          <p:with-option name="ml-forest-ids" select="//c:result/text()"/>
					          <p:with-option name="ml-delete-data" select="true()"/>
				        </admin:forest-delete>

				        <mla:delete-forests>
					          <p:input port="forests">
						            <p:pipe port="tail" step="forests"/>
					          </p:input>
				        </mla:delete-forests>
			      </p:when>
			      <p:otherwise>
				        <p:identity>
					          <p:input port="source">
						            <p:pipe port="connection" step="mla-delete-forests"/>
					          </p:input>
				        </p:identity>
			      </p:otherwise>
		    </p:choose>
	  </p:declare-step>


	  <p:declare-step name="mla-delete-database-from-config" type="mla:delete-database-from-config">
		    <p:documentation>Deletes a database and forests with respect to the config document passed
			in on the config port.</p:documentation>
		    <p:input port="connection" primary="true"/>
		    <p:input port="config" primary="false"/>
		    <p:output port="result"/>

		    <xdmp:database name="database-id">
			      <p:with-option name="ml-name" select="/mla:database/@name">
				        <p:pipe port="config" step="mla-delete-database-from-config"/>
			      </p:with-option>
		    </xdmp:database>

		    <admin:get-configuration name="ml-config"/>

		    <admin:database-delete name="delete-db">
			      <p:with-option name="ml-database-ids" select="/ml:connection/c:result/text()">
				        <p:pipe port="result" step="database-id"/>
			      </p:with-option>
		    </admin:database-delete>

		    <admin:save-configuration-without-restart/>
		    <admin:get-configuration/>

		    <mla:delete-forests name="forests">
			      <p:input port="forests" select="/mla:database/mla:forests">
				        <p:pipe port="config" step="mla-delete-database-from-config"/>
			      </p:input>
		    </mla:delete-forests>

	  </p:declare-step>

	  <p:declare-step type="mla:create-http-appserver">
		    <p:input port="connection" primary="true"/>
		    <p:output port="result"/>
		
		    <p:option name="host" required="true"/>
		    <p:option name="server-name" required="true"/>
		    <p:option name="root" required="true"/>
		    <p:option name="port" required="true"/>
		    <p:option name="modules" required="true"/>
		    <p:option name="database" required="true"/>
		
		    <xdmp:host name="hostId">
			      <p:with-option name="ml-name" select="$host"/>
		    </xdmp:host>
		    <admin:get-configuration/>
		    <admin:host-get-group name="groupId">
			      <p:with-option name="ml-host-id" select="//c:result/text()">
				        <p:pipe port="result" step="hostId"/>
			      </p:with-option>
		    </admin:host-get-group>
		    <xdmp:database name="databaseId">
			      <p:with-option name="ml-name" select="$database"/>
		    </xdmp:database>
		    <xdmp:database name="modulesId">
			      <p:with-option name="ml-name" select="$modules"/>
		    </xdmp:database>
		    <admin:get-configuration/>
		    <admin:http-server-create>
			      <p:with-option name="ml-appserver-name" select="$server-name"/>
			      <p:with-option name="ml-root" select="$root"/>
			      <p:with-option name="ml-port" select="$port"/>
			      <p:with-option name="ml-group-id" select="//c:result/text()">
				        <p:pipe port="result" step="groupId"/>
			      </p:with-option>
			      <p:with-option name="ml-database-id" select="//c:result/text()">
				        <p:pipe port="result" step="databaseId"/>
			      </p:with-option>
			      <p:with-option name="ml-modules-id" select="//c:result/text()">
				        <p:pipe port="result" step="modulesId"/>
			      </p:with-option>
		    </admin:http-server-create>
		    <admin:save-configuration-without-restart/>
	  </p:declare-step>


</p:library>