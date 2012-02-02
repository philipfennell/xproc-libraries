<p:library xmlns:xhtml="http://www.w3.org/1999/xhtml"
           xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
           xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:apidoc="http://marklogic.com/xdmp/apidoc"
           xmlns:c="http://www.w3.org/ns/xproc-step"
           xmlns:ml="http://www.marklogic.com"
           xmlns:xdmp="http://marklogic.com/xdmp"
           version="1.0">
   <p:import href="ml-server.xpl"/>

   <p:documentation>The extension built-in functions are miscellaneous extensions to the
   XQuery core library, including functions for evaluating
   strings as XQuery expressions and functions to get information about 
   documents in the database.</p:documentation>
   <p:documentation>The map built-in functions are used to create maps.  Maps store
   name-value pairs in an in-memory data structure.
   You can also persist a map to disk by storing it in a document.
   Some programming languages implement maps using hash tables, but these
   map functions make it convenient for you to create and update your
   own maps. Maps are represented using the map:map XQuery primitive 
   type.  When you serialize an object of map:map type, it
   serializes to an XML node in the http://marklogic.com/xdmp/map
   namespace.</p:documentation>
   <p:documentation>The function values functions allow you to pass a function value
   as a parameter to another function.  You can also pass in the location
   of the implementation of a function, allowing the caller to
   specify a different version of a function to use in the context of
   making that function.</p:documentation>
   <p:documentation>The MarkLogic Server extension functions are XQuery extensions that
 return MarkLogic Server-specific information, such as the version of 
 MarkLogic Server, the IDs of the hosts in the cluster, and so on. </p:documentation>
   <p:documentation>The extension functions provide miscellaneous extensions to XQuery.</p:documentation>
   <p:documentation>The HTTP functions allow you to make various HTTP calls from
 within your XQuery program.</p:documentation>
   <p:documentation>The search extension functions complement the Search Built-in functions.</p:documentation>
   <p:documentation>The XML extension functions provide XML functionality such as 
 parsing a string as XML.</p:documentation>
   <p:documentation>The XQuery Context functions are XQuery extensions that allow
 you to start a new query context, manipulate the current context, or
 get information about the current context.</p:documentation>
   <p:documentation>The Documents, Directories, Properties, and Locks functions are XQuery built-in
 extension functions that get information from documents, directories, 
 properties, and locks from MarkLogic Server.  All of these are stored
 as fragments in a database.</p:documentation>


   <p:declare-step name="xdmp-QName-from-key" type="xdmp:QName-from-key">
      <p:documentation>
   Construct a QName from a string of the form "{namespaceURI}localname".
   This function is useful for constructing Clark notation
   parameters for the  xdmp:xslt-eval 
   and  xdmp:xslt-invoke 
   functions.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-key" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/QName-from-key.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:QName-from-key"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="KEY"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'KEY']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-key">
            <p:pipe port="source" step="xdmp-QName-from-key"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-QName-from-key"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-QName-from-key"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-access" type="xdmp:access">
      <p:documentation>
  Returns whether a given action on the specified document URI would succeed.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-action" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/access.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:access"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="ACTION"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-access"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ACTION']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-action">
            <p:pipe port="source" step="xdmp-access"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-access"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-access"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-add64" type="xdmp:add64">
      <p:documentation>
  Add two 64-bit integer values, discarding overflow. 
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/add64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:add64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-add64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-add64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-add64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-add64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-and64" type="xdmp:and64">
      <p:documentation>
  AND two 64-bit integer values.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/and64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:and64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-and64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-and64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-and64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-and64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-apply" type="xdmp:apply">
      <p:documentation>
  Applies an  xdmp:function  with the given parameters.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-function" required="true"/>
      <p:option name="ml-params-1-to-N" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/apply.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:apply"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="FUNCTION"/>
                  <c:param name="PARAMS_1_TO_N"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'FUNCTION']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-function">
            <p:pipe port="source" step="xdmp-apply"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'PARAMS_1_TO_N']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-params-1-to-N">
            <p:pipe port="source" step="xdmp-apply"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-apply"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-apply"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-architecture" type="xdmp:architecture">
      <p:documentation>
  Returns the hardware architecture upon which MarkLogic Server is running.
  If  xdmp:platform()  returns "linux",
  it will return "x86_64" or "i686.
  If  xdmp:platform()  returns "solaris",
  it will return "amd64" or "sparcv9".
  If  xdmp:platform()  returns "winnt", 
  it will return "amd64" or "i686".  
  If  xdmp:platform()  returns "macosx", 
  it will return "x86_64".  
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/architecture.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:architecture"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-architecture"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-architecture"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-base64-decode" type="xdmp:base64-decode">
      <p:documentation>
  Converts base64-encoded string to plaintext.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-encoded" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/base64-decode.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:base64-decode"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ENCODED"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ENCODED']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-encoded">
            <p:pipe port="source" step="xdmp-base64-decode"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-base64-decode"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-base64-decode"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-base64-encode" type="xdmp:base64-encode">
      <p:documentation>
  Converts plaintext into base64-encoded string.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-plaintext" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/base64-encode.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:base64-encode"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="PLAINTEXT"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'PLAINTEXT']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-plaintext">
            <p:pipe port="source" step="xdmp-base64-encode"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-base64-encode"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-base64-encode"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-binary-decode" type="xdmp:binary-decode">
      <p:documentation>
  Converts an encoded byte sequence, passed in as a binary node, from the
  specified encoding to a unicode string.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-encoded" required="true"/>
      <p:option name="ml-encoding-name" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/binary-decode.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:binary-decode"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ENCODED"/>
                  <c:param name="ENCODING_NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ENCODED']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-encoded">
            <p:pipe port="source" step="xdmp-binary-decode"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ENCODING_NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-encoding-name">
            <p:pipe port="source" step="xdmp-binary-decode"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-binary-decode"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-binary-decode"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-collation-canonical-uri" type="xdmp:collation-canonical-uri">
      <p:documentation>
  Returns the canonical URI for the given URI, if it represents a 
  valid collation.  A canonical URI is the unique string MarkLogic Server
  uses to identify a given collation.  The canonical URI string places any 
  attributes that occur in the URI in a predefined order, and it removes
  any attributes that are redundant due to locale defaults.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-collation-uri" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/collation-canonical-uri.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:collation-canonical-uri"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="COLLATION_URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'COLLATION_URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-collation-uri">
            <p:pipe port="source" step="xdmp-collation-canonical-uri"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-collation-canonical-uri"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-collation-canonical-uri"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-collection-locks" type="xdmp:collection-locks">
      <p:documentation>
  Returns locks of documents in a collection.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/collection-locks.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:collection-locks"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-collection-locks"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-collection-locks"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-collection-locks"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-collection-properties" type="xdmp:collection-properties">
      <p:documentation>
  Returns a sequence of properties documents, one for each document in the 
  specified collection(s) that has a corresponding properties document.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/collection-properties.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:collection-properties"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-collection-properties"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-collection-properties"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-collection-properties"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-database" type="xdmp:database">
      <p:documentation>
  Returns the the ID of the database named in the the parameter.
  Returns the ID of the current database if no parameter is specified.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/database.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:database"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-database"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-database"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-database"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-database-forests" type="xdmp:database-forests">
      <p:documentation>
  Returns a sequence of forest IDs in the specified database.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-database" required="true"/>
      <p:option name="ml-include-replicas" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/database-forests.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:database-forests"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="DATABASE"/>
                  <c:param name="INCLUDE_REPLICAS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'DATABASE']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-database">
            <p:pipe port="source" step="xdmp-database-forests"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'INCLUDE_REPLICAS']" attribute-name="value"
                       name="params">
         <p:with-option name="attribute-value" select="$ml-include-replicas">
            <p:pipe port="source" step="xdmp-database-forests"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-database-forests"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-database-forests"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-database-name" type="xdmp:database-name">
      <p:documentation>
  Return the name of the database with the given ID.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-id" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/database-name.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:database-name"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ID"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-id">
            <p:pipe port="source" step="xdmp-database-name"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-database-name"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-database-name"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-databases" type="xdmp:databases">
      <p:documentation>
  Returns a sequence of the IDs of all the databases in the system.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/databases.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:databases"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-databases"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-databases"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-describe" type="xdmp:describe">
      <p:documentation>
  Returns a string representing the 
  description of a given item sequence.  If you take
  the output of the  xdmp:describe  function and evaluate 
  it as an XQuery program, it returns the item(s) input to the
  function.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-item" required="true"/>
      <p:option name="ml-maxSequenceLength" required="false"/>
      <p:option name="ml-maxItemLength" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/describe.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:describe"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ITEM"/>
                  <c:param name="MAXSEQUENCELENGTH"/>
                  <c:param name="MAXITEMLENGTH"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ITEM']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-item">
            <p:pipe port="source" step="xdmp-describe"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MAXSEQUENCELENGTH']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-maxSequenceLength">
            <p:pipe port="source" step="xdmp-describe"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MAXITEMLENGTH']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-maxItemLength">
            <p:pipe port="source" step="xdmp-describe"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-describe"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-describe"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-diacritic-less" type="xdmp:diacritic-less">
      <p:documentation>
Returns the specified string, converting all of the characters with diacritics 
to characters without diacritics.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-string" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/diacritic-less.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:diacritic-less"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="STRING"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'STRING']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-string">
            <p:pipe port="source" step="xdmp-diacritic-less"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-diacritic-less"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-diacritic-less"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-directory" type="xdmp:directory">
      <p:documentation>
  Returns the documents in a directory.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-depth" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/directory.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:directory"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="DEPTH"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-directory"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DEPTH']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-depth">
            <p:pipe port="source" step="xdmp-directory"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-directory"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-directory"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-directory-locks" type="xdmp:directory-locks">
      <p:documentation>
  Returns locks of documents in a directory.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-depth" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/directory-locks.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:directory-locks"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="DEPTH"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-directory-locks"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DEPTH']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-depth">
            <p:pipe port="source" step="xdmp-directory-locks"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-directory-locks"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-directory-locks"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-directory-properties" type="xdmp:directory-properties">
      <p:documentation>
  Returns a sequence of properties documents, one for each document in 
  the specified directory that has a corresponding properties document.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-depth" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/directory-properties.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:directory-properties"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="DEPTH"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-directory-properties"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DEPTH']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-depth">
            <p:pipe port="source" step="xdmp-directory-properties"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-directory-properties"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-directory-properties"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-document-forest" type="xdmp:document-forest">
      <p:documentation>
  Returns the forest ID of the forest in which a document (or a lock or a 
  property) with the specified URI is stored.   Otherwise, returns the empty 
  sequence.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-forest-ids" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/document-forest.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:document-forest"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="FOREST_IDS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-document-forest"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'FOREST_IDS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-forest-ids">
            <p:pipe port="source" step="xdmp-document-forest"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-document-forest"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-document-forest"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-document-get" type="xdmp:document-get">
      <p:documentation>
  Returns the document in the file specified by $location.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-location" required="true"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/document-get.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:document-get"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="LOCATION"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'LOCATION']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-location">
            <p:pipe port="source" step="xdmp-document-get"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-document-get"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-document-get"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-document-get"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-document-get-properties" type="xdmp:document-get-properties">
      <p:documentation>
  Returns the property values for a document's property.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-property" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/document-get-properties.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:document-get-properties"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="PROPERTY"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-document-get-properties"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'PROPERTY']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-property">
            <p:pipe port="source" step="xdmp-document-get-properties"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-document-get-properties"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-document-get-properties"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-document-get-quality" type="xdmp:document-get-quality">
      <p:documentation>
  Returns the quality of the specified document if the document exists.  
  Otherwise, returns the empty sequence.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-uri" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/document-get-quality.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:document-get-quality"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-document-get-quality"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-document-get-quality"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-document-get-quality"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-document-locks" type="xdmp:document-locks">
      <p:documentation>
  Returns the locks for one or more documents or directories.  
  Returns the locks for all documents and directories 
  in the database if no parameter is given.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/document-locks.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:document-locks"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-document-locks"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-document-locks"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-document-locks"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-document-properties" type="xdmp:document-properties">
      <p:documentation>
  Returns a sequence of properties documents, one for each of the specified 
  documents that has a corresponding properties document.  If no documents 
  are specified, returns a sequence of properties documents for all 
  documents in the database that have a corresponding properties document.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/document-properties.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:document-properties"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-document-properties"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-document-properties"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-document-properties"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-elapsed-time" type="xdmp:elapsed-time">
      <p:documentation>
  Returns the elapsed time since the start of processing of this query.  Gives
  the same information as the  elapsed-time  element of the 
   xdmp:query-meters  output, but has less overhead than calling
   xdmp:query-meters .
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/elapsed-time.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:elapsed-time"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:empty/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-elapsed-time"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-elapsed-time"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-element-content-type" type="xdmp:element-content-type">
      <p:documentation>
  Returns the schema-defined content-type of an element 
  ("empty", "simple", "element-only", or "mixed").
</p:documentation>

      <p:input port="source"/>
      <p:input port="element" sequence="false"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/element-content-type.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:replace match="//element">
         <p:input port="replacement">
            <p:pipe port="element" step="xdmp-element-content-type"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:element-content-type"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-element-content-type"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-element-content-type"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-encoding-language-detect" type="xdmp:encoding-language-detect">
      <p:documentation>
  Analyzes binary, text, or XML data and suggests possible pairs of encoding 
  and language, with a confidence score for each pair. Scores of 10 and 
  above are high confidence recommendations.
  The results are given in order of decreasing score.
  Accuracy may be poor for short documents.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-document" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/encoding-language-detect.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type"
                       attribute-value="xdmp:encoding-language-detect"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="DOCUMENT"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'DOCUMENT']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-document">
            <p:pipe port="source" step="xdmp-encoding-language-detect"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-encoding-language-detect"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-encoding-language-detect"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-estimate" type="xdmp:estimate">
      <p:documentation>
  Returns the number of fragments selected by an expression.
  This can be used as a fast estimate of the number of items in a sequence.  
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-expression" required="true"/>
      <p:option name="ml-maximum" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/estimate.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:estimate"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="EXPRESSION"/>
                  <c:param name="MAXIMUM"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'EXPRESSION']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-expression">
            <p:pipe port="source" step="xdmp-estimate"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MAXIMUM']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-maximum">
            <p:pipe port="source" step="xdmp-estimate"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-estimate"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-estimate"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-eval" type="xdmp:eval">
      <p:documentation>
  Returns the result of evaluating a string
  as an XQuery module.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-xquery" required="true"/>
      <p:option name="ml-vars" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/eval.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:eval"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="XQUERY"/>
                  <c:param name="VARS"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'XQUERY']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-xquery">
            <p:pipe port="source" step="xdmp-eval"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VARS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-vars">
            <p:pipe port="source" step="xdmp-eval"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-eval"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-eval"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-eval"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-eval-in" type="xdmp:eval-in">
      <p:documentation>
  [DEPRECATED: use  xdmp:eval  with the 
  database option instead] Returns the result of evaluating a string as 
  an XQuery module in a given database.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-xquery" required="true"/>
      <p:option name="ml-ID" required="true"/>
      <p:option name="ml-vars" required="false"/>
      <p:option name="ml-modules" required="false"/>
      <p:option name="ml-root" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/eval-in.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:eval-in"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="XQUERY"/>
                  <c:param name="ID"/>
                  <c:param name="VARS"/>
                  <c:param name="MODULES"/>
                  <c:param name="ROOT"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'XQUERY']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-xquery">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-ID">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VARS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-vars">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MODULES']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-modules">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ROOT']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-root">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-eval-in"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-exists" type="xdmp:exists">
      <p:documentation>
  Returns true if any fragment is selected by an expression, false if no
  fragments are selected.  This can be used as a fast existence check.  
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-expression" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/exists.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:exists"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="EXPRESSION"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'EXPRESSION']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-expression">
            <p:pipe port="source" step="xdmp-exists"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-exists"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-exists"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-forest" type="xdmp:forest">
      <p:documentation>
  Returns the the ID of the forest specified as the parameter.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-name" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/forest.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:forest"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-forest"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-forest"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-forest"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-forest-databases" type="xdmp:forest-databases">
      <p:documentation>
  Returns the database ID corresponding to the database to which 
  the specified forest belongs.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-forest" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/forest-databases.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:forest-databases"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="FOREST"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'FOREST']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-forest">
            <p:pipe port="source" step="xdmp-forest-databases"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-forest-databases"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-forest-databases"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-forest-name" type="xdmp:forest-name">
      <p:documentation>
  Return the name of the forest with the given id.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-id" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/forest-name.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:forest-name"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ID"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-id">
            <p:pipe port="source" step="xdmp-forest-name"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-forest-name"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-forest-name"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-forests" type="xdmp:forests">
      <p:documentation>
  Returns a sequence of the IDs of all the forests in the system.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/forests.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:forests"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-forests"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-forests"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-function" type="xdmp:function">
      <p:documentation>
  Returns a function value as an  xdmp:function  type.  
  You can return an  xdmp:function  from an expression or
  a function.  You can execute the function referred to by an
   xdmp:function  by passing the  xdmp:function  value to 
   xdmp:apply .  
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-function" required="true"/>
      <p:option name="ml-module-path" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/function.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:function"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="FUNCTION"/>
                  <c:param name="MODULE_PATH"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'FUNCTION']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-function">
            <p:pipe port="source" step="xdmp-function"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MODULE_PATH']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-module-path">
            <p:pipe port="source" step="xdmp-function"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-function"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-function"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-function-module" type="xdmp:function-module">
      <p:documentation>
  Returns the module location (if any) that the xdmp:function value refers to.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-function" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/function-module.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:function-module"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="FUNCTION"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'FUNCTION']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-function">
            <p:pipe port="source" step="xdmp-function-module"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-function-module"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-function-module"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-function-name" type="xdmp:function-name">
      <p:documentation>
  Returns the QName of the function(s) that the xdmp:function refers to.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-function" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/function-name.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:function-name"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="FUNCTION"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'FUNCTION']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-function">
            <p:pipe port="source" step="xdmp-function-name"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-function-name"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-function-name"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-get" type="xdmp:get">
      <p:documentation>
  [DEPRECATED: use  xdmp:document-get 
  instead] Returns the document in the XML file specified by $path.
   This function is deprecated and will be removed from a future release. 
  Use xdmp:document-get instead.</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-path" required="true"/>
      <p:option name="ml-default-namespace" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/get.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:get"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="PATH"/>
                  <c:param name="DEFAULT_NAMESPACE"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'PATH']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-path">
            <p:pipe port="source" step="xdmp-get"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DEFAULT_NAMESPACE']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-default-namespace">
            <p:pipe port="source" step="xdmp-get"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-get"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-get"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-get"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-group" type="xdmp:group">
      <p:documentation>
  Returns the the ID of the group specified in the parameter.  
  Returns the ID of the current group if no parameter is specified.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/group.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:group"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-group"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-group"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-group"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-group-hosts" type="xdmp:group-hosts">
      <p:documentation>
  Returns the IDs of all hosts belonging to the group with the given ID.  
  If no parameter is specified, it uses the group of the current host.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/group-hosts.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:group-hosts"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-group-hosts"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-group-hosts"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-group-hosts"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-group-name" type="xdmp:group-name">
      <p:documentation>
  Returns the the name of the group with the given ID.  
  Returns the name of the current group if no parameter is specified.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/group-name.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:group-name"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-group-name"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-group-name"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-group-name"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-group-servers" type="xdmp:group-servers">
      <p:documentation>
  Returns the the IDs of all App Servers belonging to the group with 
  the given ID.  
  If no parameter is specified, it uses the group of the current host.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/group-servers.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:group-servers"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-group-servers"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-group-servers"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-group-servers"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-groups" type="xdmp:groups">
      <p:documentation>
  Returns a sequence of the IDs of all the groups in the system.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/groups.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:groups"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-groups"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-groups"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-hash32" type="xdmp:hash32">
      <p:documentation>
  Returns the 32-bit hash of a string.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-string" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/hash32.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:hash32"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="STRING"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'STRING']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-string">
            <p:pipe port="source" step="xdmp-hash32"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-hash32"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-hash32"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-hash64" type="xdmp:hash64">
      <p:documentation>
  Returns the 64-bit hash of a string.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-string" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/hash64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:hash64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="STRING"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'STRING']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-string">
            <p:pipe port="source" step="xdmp-hash64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-hash64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-hash64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-hex-to-integer" type="xdmp:hex-to-integer">
      <p:documentation>
  Parses a hexadecimal string, returning an integer.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-hex" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/hex-to-integer.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:hex-to-integer"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="HEX"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'HEX']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-hex">
            <p:pipe port="source" step="xdmp-hex-to-integer"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-hex-to-integer"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-hex-to-integer"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-host" type="xdmp:host">
      <p:documentation>
  Returns the the ID of the host named in the parameter.  
  Returns the ID of the current host if no parameter is specified.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/host.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:host"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-host"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-host"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-host"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-host-name" type="xdmp:host-name">
      <p:documentation>
  Returns the the name of the host ID specified as the parameter.  
  Returns the current host if no name is specified.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-ID" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/host-name.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:host-name"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ID"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-ID">
            <p:pipe port="source" step="xdmp-host-name"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-host-name"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-host-name"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-hosts" type="xdmp:hosts">
      <p:documentation>
  Returns a sequence of the IDs of all the hosts in the system.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/hosts.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:hosts"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-hosts"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-hosts"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-http-delete" type="xdmp:http-delete">
      <p:documentation>
  Sends an http DELETE request to the http server specified in the URI 
  to delete the specified resource. The server should respond if the 
  request is to be completed, but a response is not guaranteed. 
  Also, even if the server does respond, it 
  does not guarantee that the request has been or will be completed.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/http-delete.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:http-delete"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-http-delete"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-http-delete"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-http-delete"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-http-delete"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-http-get" type="xdmp:http-get">
      <p:documentation>
  Sends the http GET method to the specified URI. Returns the http response 
  as well as whatever information is identified by the specified URI 
  (for example, an html document).
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/http-get.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:http-get"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-http-get"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-http-get"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-http-get"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-http-get"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-http-head" type="xdmp:http-head">
      <p:documentation>
  Sends the http HEAD method to the specified URI. Returns the http response 
  header for the specified URI.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/http-head.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:http-head"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-http-head"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-http-head"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-http-head"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-http-head"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-http-options" type="xdmp:http-options">
      <p:documentation>
  Sends the http OPTIONS method to the specified URI. Returns the http response 
  for the specified URI.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/http-options.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:http-options"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-http-options"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-http-options"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-http-options"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-http-options"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-http-post" type="xdmp:http-post">
      <p:documentation>
  Sends the http POST request to the server.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-options" required="false"/>
      <p:option name="ml-data" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/http-post.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:http-post"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="OPTIONS"/>
                  <c:param name="DATA"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-http-post"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-http-post"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DATA']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-data">
            <p:pipe port="source" step="xdmp-http-post"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-http-post"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-http-post"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-http-put" type="xdmp:http-put">
      <p:documentation>
  Sends an HTTP PUT request to an HTTP server.  
  The HTTP server should return a response, which will differ depending on
  the action the HTTP server takes for the PUT.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-options" required="false"/>
      <p:option name="ml-data" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/http-put.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:http-put"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="OPTIONS"/>
                  <c:param name="DATA"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-http-put"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-http-put"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DATA']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-data">
            <p:pipe port="source" step="xdmp-http-put"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-http-put"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-http-put"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-integer-to-hex" type="xdmp:integer-to-hex">
      <p:documentation>
  Returns a hexadecimal representation of an integer.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-val" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/integer-to-hex.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:integer-to-hex"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="VAL"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'VAL']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-val">
            <p:pipe port="source" step="xdmp-integer-to-hex"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-integer-to-hex"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-integer-to-hex"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-integer-to-octal" type="xdmp:integer-to-octal">
      <p:documentation>
  Returns an octal representation of an integer.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-val" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/integer-to-octal.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:integer-to-octal"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="VAL"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'VAL']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-val">
            <p:pipe port="source" step="xdmp-integer-to-octal"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-integer-to-octal"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-integer-to-octal"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-invoke" type="xdmp:invoke">
      <p:documentation>
  Returns the result of evaluating a module at the given path.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-path" required="true"/>
      <p:option name="ml-vars" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/invoke.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:invoke"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="PATH"/>
                  <c:param name="VARS"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'PATH']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-path">
            <p:pipe port="source" step="xdmp-invoke"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VARS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-vars">
            <p:pipe port="source" step="xdmp-invoke"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-invoke"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-invoke"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-invoke"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-invoke-in" type="xdmp:invoke-in">
      <p:documentation>
  [DEPRECATED: use  xdmp:invoke  with the 
  database option instead] Returns the result of evaluating a module 
  at the given path.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-uri" required="true"/>
      <p:option name="ml-ID" required="true"/>
      <p:option name="ml-vars" required="false"/>
      <p:option name="ml-modules" required="false"/>
      <p:option name="ml-root" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/invoke-in.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:invoke-in"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
                  <c:param name="ID"/>
                  <c:param name="VARS"/>
                  <c:param name="MODULES"/>
                  <c:param name="ROOT"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-ID">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VARS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-vars">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MODULES']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-modules">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ROOT']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-root">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-invoke-in"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-key-from-QName" type="xdmp:key-from-QName">
      <p:documentation>
   Construct a context-independent string from a QName.  This string is
   of the form "{namespaceURI}localname" and is suitable for use as a map
   key.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-name" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/key-from-QName.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:key-from-QName"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-key-from-QName"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-key-from-QName"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-key-from-QName"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-log" type="xdmp:log">
      <p:documentation>
  Logs a debug message to the log file 
   &lt;install_dir&gt;/Logs/ErrorLog.txt .
</p:documentation>

      <p:input port="source"/>

      <p:option name="ml-msg" required="true"/>
      <p:option name="ml-level" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/log.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:log"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="MSG"/>
                  <c:param name="LEVEL"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'MSG']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-msg">
            <p:pipe port="source" step="xdmp-log"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'LEVEL']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-level">
            <p:pipe port="source" step="xdmp-log"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-log"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-log"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-log-level" type="xdmp:log-level">
      <p:documentation>
  Retrieves the current server log level.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/log-level.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:log-level"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-log-level"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-log-level"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-lshift64" type="xdmp:lshift64">
      <p:documentation>
  Left-shift a 64-bit integer value.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/lshift64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:lshift64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-lshift64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-lshift64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-lshift64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-lshift64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-modules-database" type="xdmp:modules-database">
      <p:documentation>
  Returns the database ID of the modules database.  Returns 0 if the 
  current App Server uses the file system for its modules.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/modules-database.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:modules-database"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-modules-database"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-modules-database"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-modules-root" type="xdmp:modules-root">
      <p:documentation>
  Returns the current root path for modules.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/modules-root.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:modules-root"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-modules-root"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-modules-root"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-mul64" type="xdmp:mul64">
      <p:documentation>
  Muliply two 64-bit integer values, discarding overflow. 
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/mul64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:mul64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-mul64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-mul64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-mul64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-mul64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-node-database" type="xdmp:node-database">
      <p:documentation>
  Returns the database id where the parameter is stored. If
  the specified node does not come from a document in a database, then
   xdmp:node-database  returns an empty list.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-node" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/node-database.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:node-database"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NODE"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NODE']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-node">
            <p:pipe port="source" step="xdmp-node-database"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-node-database"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-node-database"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-node-uri" type="xdmp:node-uri">
      <p:documentation>
  Returns the document-uri property of the parameter or its ancestor. 
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-node" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/node-uri.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:node-uri"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NODE"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NODE']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-node">
            <p:pipe port="source" step="xdmp-node-uri"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-node-uri"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-node-uri"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-not64" type="xdmp:not64">
      <p:documentation>
  NOT a 64-bit integer value.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/not64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:not64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-not64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-not64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-not64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-octal-to-integer" type="xdmp:octal-to-integer">
      <p:documentation>
  Parses an octal string, returning an integer.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-octal" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/octal-to-integer.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:octal-to-integer"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="OCTAL"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'OCTAL']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-octal">
            <p:pipe port="source" step="xdmp-octal-to-integer"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-octal-to-integer"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-octal-to-integer"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-or64" type="xdmp:or64">
      <p:documentation>
  OR two 64-bit integer values.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/or64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:or64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-or64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-or64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-or64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-or64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-path" type="xdmp:path">
      <p:documentation>
  Returns a string whose value corresponds to the 
  path of the node.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-node" required="true"/>
      <p:option name="ml-include-document" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/path.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:path"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NODE"/>
                  <c:param name="INCLUDE_DOCUMENT"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NODE']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-node">
            <p:pipe port="source" step="xdmp-path"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'INCLUDE_DOCUMENT']" attribute-name="value"
                       name="params">
         <p:with-option name="attribute-value" select="$ml-include-document">
            <p:pipe port="source" step="xdmp-path"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-path"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-path"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-plan" type="xdmp:plan">
      <p:documentation>
  Returns an XML element recording information about how the given 
  expression will be processed by the index.  The information is a
  structured representation of the information provided in the error log
  when query trace is enabled.  The query will be processed up to the
  point of getting an estimate of the number of fragments returned by the
  index.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-expression" required="true"/>
      <p:option name="ml-maximum" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/plan.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:plan"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="EXPRESSION"/>
                  <c:param name="MAXIMUM"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'EXPRESSION']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-expression">
            <p:pipe port="source" step="xdmp-plan"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MAXIMUM']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-maximum">
            <p:pipe port="source" step="xdmp-plan"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-plan"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-plan"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-platform" type="xdmp:platform">
      <p:documentation>
  Returns the operating-system platform upon which MarkLogic Server is running 
  ("solaris", "winnt", "linux", or "macosx").
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/platform.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:platform"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-platform"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-platform"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-pretty-print" type="xdmp:pretty-print">
      <p:documentation>
  Returns a well-formatted XQuery module.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-xquery" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/pretty-print.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:pretty-print"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="XQUERY"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'XQUERY']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-xquery">
            <p:pipe port="source" step="xdmp-pretty-print"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-pretty-print"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-pretty-print"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-product-edition" type="xdmp:product-edition">
      <p:documentation>
  Returns the current MarkLogic product edition.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/product-edition.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:product-edition"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-product-edition"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-product-edition"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-query-meters" type="xdmp:query-meters">
      <p:documentation>
  Returns the current value of the resource meters for this 
  query sequence.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/query-meters.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:query-meters"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:empty/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-query-meters"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-query-meters"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-query-trace" type="xdmp:query-trace">
      <p:documentation>
  Enables or disables tracing of this query.
  When query tracing is enabled, "info" level messages
  are logged detailing the search optimizations performed.
</p:documentation>

      <p:input port="source"/>

      <p:option name="ml-enabled" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/query-trace.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:query-trace"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ENABLED"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ENABLED']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-enabled">
            <p:pipe port="source" step="xdmp-query-trace"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-query-trace"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-query-trace"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-quote" type="xdmp:quote">
      <p:documentation>
  Returns the unevaluated serialized representation
  of the input parameter as a string.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-arg" required="true"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/quote.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:quote"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ARG"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ARG']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-arg">
            <p:pipe port="source" step="xdmp-quote"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-quote"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-quote"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-quote"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-random" type="xdmp:random">
      <p:documentation>
  Returns a random unsigned integer between 0 and a number up to 64 bits long.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-max" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/random.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:random"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="MAX"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'MAX']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-max">
            <p:pipe port="source" step="xdmp-random"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-random"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-random"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-request" type="xdmp:request">
      <p:documentation>
  Returns the unique key of the current request.  
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/request.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:request"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-request"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-request"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-request-timestamp" type="xdmp:request-timestamp">
      <p:documentation>
  Returns the system timestamp for this request if the request is a query 
  statement.  Returns the empty sequence if the current request is an update
  statement.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/request-timestamp.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:request-timestamp"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-request-timestamp"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-request-timestamp"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-rethrow" type="xdmp:rethrow">
      <p:documentation>
  Within the catch section of a try-catch expression,
  re-throw the currently caught error.
</p:documentation>

      <p:input port="source"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/rethrow.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:rethrow"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-rethrow"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-rethrow"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-rshift64" type="xdmp:rshift64">
      <p:documentation>
  Right-shift a 64-bit integer value.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/rshift64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:rshift64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-rshift64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-rshift64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-rshift64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-rshift64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-schema-database" type="xdmp:schema-database">
      <p:documentation>
  Returns the database ID of the schema database 
  associated with the current database.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/schema-database.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:schema-database"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-schema-database"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-schema-database"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-security-database" type="xdmp:security-database">
      <p:documentation>
  Returns the database ID of the security database 
  associated with the current database.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/security-database.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:security-database"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-security-database"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-security-database"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-server" type="xdmp:server">
      <p:documentation>
  Returns the the ID(s) of the App Server specified in the parameter.  
  Returns the ID of the current App Server if no parameter is specified.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-name" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/server.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:server"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-server"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-server"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-server"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-server-name" type="xdmp:server-name">
      <p:documentation>
  Return the name of the App Server with the given ID.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-id" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/server-name.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:server-name"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ID"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-id">
            <p:pipe port="source" step="xdmp-server-name"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-server-name"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-server-name"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-servers" type="xdmp:servers">
      <p:documentation>
  Returns a sequence of the IDs of all the App Servers in the system.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/servers.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:servers"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-servers"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-servers"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-set" type="xdmp:set">
      <p:documentation>
  Set the value of a variable to the specified expression. The 
   xdmp:set  command allows you to introduce changes to the
  state (side effects) of a query by changing the value of a variable to 
  something other than what it is bound to.
 </p:documentation>

      <p:input port="source"/>

      <p:option name="ml-variable" required="true"/>
      <p:option name="ml-expr" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/set.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:set"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="VARIABLE"/>
                  <c:param name="EXPR"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'VARIABLE']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-variable">
            <p:pipe port="source" step="xdmp-set"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'EXPR']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-expr">
            <p:pipe port="source" step="xdmp-set"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-set"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-set"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-sleep" type="xdmp:sleep">
      <p:documentation>
  Delays for a specific amount of time.
</p:documentation>

      <p:input port="source"/>

      <p:option name="ml-msec" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/sleep.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:sleep"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="MSEC"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'MSEC']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-msec">
            <p:pipe port="source" step="xdmp-sleep"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-sleep"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-sleep"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-spawn" type="xdmp:spawn">
      <p:documentation>
  Place the specified module on the task queue for evaluation.
</p:documentation>

      <p:input port="source"/>

      <p:option name="ml-path" required="true"/>
      <p:option name="ml-vars" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/spawn.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:spawn"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="PATH"/>
                  <c:param name="VARS"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'PATH']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-path">
            <p:pipe port="source" step="xdmp-spawn"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VARS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-vars">
            <p:pipe port="source" step="xdmp-spawn"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-spawn"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-spawn"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-spawn"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-spawn-in" type="xdmp:spawn-in">
      <p:documentation>
  [DEPRECATED: use  xdmp:spawn  with the 
  database option instead] Place the specified module on the task 
  queue for evaluation.  It will be evaluated in the given database.
</p:documentation>

      <p:input port="source"/>

      <p:option name="ml-path" required="true"/>
      <p:option name="ml-ID" required="true"/>
      <p:option name="ml-vars" required="false"/>
      <p:option name="ml-modules" required="false"/>
      <p:option name="ml-root" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/spawn-in.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:spawn-in"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="PATH"/>
                  <c:param name="ID"/>
                  <c:param name="VARS"/>
                  <c:param name="MODULES"/>
                  <c:param name="ROOT"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'PATH']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-path">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ID']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-ID">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VARS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-vars">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'MODULES']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-modules">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'ROOT']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-root">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-spawn-in"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-step64" type="xdmp:step64">
      <p:documentation>
  Combines an initial hash with a subsequent hash.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-initial" required="true"/>
      <p:option name="ml-step" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/step64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:step64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="INITIAL"/>
                  <c:param name="STEP"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'INITIAL']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-initial">
            <p:pipe port="source" step="xdmp-step64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'STEP']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-step">
            <p:pipe port="source" step="xdmp-step64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-step64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-step64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-strftime" type="xdmp:strftime">
      <p:documentation>
  Formats a dateTime value using POSIX strftime.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-format" required="true"/>
      <p:option name="ml-value" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/strftime.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:strftime"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="FORMAT"/>
                  <c:param name="VALUE"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'FORMAT']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-format">
            <p:pipe port="source" step="xdmp-strftime"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VALUE']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-value">
            <p:pipe port="source" step="xdmp-strftime"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-strftime"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-strftime"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-subbinary" type="xdmp:subbinary">
      <p:documentation>
  Returns a binary node made up of a subset of the given binary node.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-source" required="true"/>
      <p:option name="ml-starting-location" required="true"/>
      <p:option name="ml-length" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/subbinary.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:subbinary"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="SOURCE"/>
                  <c:param name="STARTING_LOCATION"/>
                  <c:param name="LENGTH"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'SOURCE']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-source">
            <p:pipe port="source" step="xdmp-subbinary"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'STARTING_LOCATION']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-starting-location">
            <p:pipe port="source" step="xdmp-subbinary"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'LENGTH']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-length">
            <p:pipe port="source" step="xdmp-subbinary"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-subbinary"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-subbinary"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-trace" type="xdmp:trace">
      <p:documentation>
  Signal a trace event.  
  If trace events are activated and the event is enabled, 
  the trace event is logged.
</p:documentation>

      <p:input port="source"/>

      <p:option name="ml-name" required="true"/>
      <p:option name="ml-value" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/trace.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:trace"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NAME"/>
                  <c:param name="VALUE"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NAME']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-name">
            <p:pipe port="source" step="xdmp-trace"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'VALUE']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-value">
            <p:pipe port="source" step="xdmp-trace"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-trace"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-trace"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-triggers-database" type="xdmp:triggers-database">
      <p:documentation>
  Returns the database ID of the triggers database 
  associated with the current database.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/triggers-database.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:triggers-database"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-triggers-database"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-triggers-database"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-unpath" type="xdmp:unpath">
      <p:documentation>
  Evaluate a string as an XPath and return the corresponding node(s). 
  Any value that is the result of  xdmp:path  is a 
  valid input to  xdmp:unpath .  Any invalid inputs 
  throw an  XDMP-UNPATH  exception.  To evaluate non-XPath 
  expressions, use  xdmp:value .
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-expr" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/unpath.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:unpath"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="EXPR"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'EXPR']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-expr">
            <p:pipe port="source" step="xdmp-unpath"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-unpath"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-unpath"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-unquote" type="xdmp:unquote">
      <p:documentation>
  Parses a string as XML, returning one or more document nodes.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-arg" required="true"/>
      <p:option name="ml-default-namespace" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/unquote.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:unquote"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="ARG"/>
                  <c:param name="DEFAULT_NAMESPACE"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'ARG']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-arg">
            <p:pipe port="source" step="xdmp-unquote"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'DEFAULT_NAMESPACE']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-default-namespace">
            <p:pipe port="source" step="xdmp-unquote"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-unquote"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-unquote"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-unquote"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-uri-content-type" type="xdmp:uri-content-type">
      <p:documentation>
  Returns the content type of the given URI as matched in the mimetypes 
  configuration. xdmp:content-type continues to work too.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-uri" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/uri-content-type.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:uri-content-type"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-uri-content-type"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-uri-content-type"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-uri-content-type"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-uri-format" type="xdmp:uri-format">
      <p:documentation>
  Returns the format of the given URI as matched in the mimetypes 
  configuration. 
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-uri" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/uri-format.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:uri-format"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="URI"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'URI']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-uri">
            <p:pipe port="source" step="xdmp-uri-format"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-uri-format"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-uri-format"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-value" type="xdmp:value">
      <p:documentation>
  Evaluate an expression in the context of the current evaluating statement.
  This differs from  xdmp:eval  in that  xdmp:value 
  preserves all of the context from the calling query, so you do not
  need to re-define namespaces, variables, and so on.  Although the expression
  retains the context from the calling query, it is evaluated in its own 
  transaction with same-statement isolation.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-expr" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/value.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:value"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="EXPR"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'EXPR']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-expr">
            <p:pipe port="source" step="xdmp-value"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-value"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-value"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-version" type="xdmp:version">
      <p:documentation>
  Returns the current MarkLogic Server version.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/version.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:version"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-version"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-version"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-with-namespaces" type="xdmp:with-namespaces">
      <p:documentation>
  Evaluates the expression in the context of a specific set of namespace
  bindings.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-nsbindings" required="true"/>
      <p:option name="ml-expr" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/with-namespaces.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:with-namespaces"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="NSBINDINGS"/>
                  <c:param name="EXPR"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'NSBINDINGS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-nsbindings">
            <p:pipe port="source" step="xdmp-with-namespaces"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'EXPR']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-expr">
            <p:pipe port="source" step="xdmp-with-namespaces"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-with-namespaces"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-with-namespaces"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-xor64" type="xdmp:xor64">
      <p:documentation>
  XOR two 64-bit integer values.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="ml-x" required="true"/>
      <p:option name="ml-y" required="true"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/xor64.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:xor64"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="X"/>
                  <c:param name="Y"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'X']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-x">
            <p:pipe port="source" step="xdmp-xor64"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'Y']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-y">
            <p:pipe port="source" step="xdmp-xor64"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-xor64"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-xor64"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-xquery-version" type="xdmp:xquery-version">
      <p:documentation>
  Returns the XQuery language version of the calling module.
  Currently supported XQuery versions are:
   "0.9-ml": The legacy MarkLogic XQuery version.  This was the only
    XQuery version available on MarkLogic Server 3.2 and
    earlier.  It is based on the May 2003 XQuery Draft Recommendation,
    with MarkLogic extensions
    "1.0-ml": XQuery version 1.0, with MarkLogic extensions.  This
    is the preferred version of XQuery beginning with release 4.0.
    "1.0": Strict XQuery version 1.0.  This XQuery version complies
    as closely as possible with the published XQuery 1.0 specification.
    </p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="false"/>



      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/xquery-version.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:xquery-version"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity name="params">
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set/>
            </p:inline>
         </p:input>
      </p:identity>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-xquery-version"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-xquery-version"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-xslt-eval" type="xdmp:xslt-eval">
      <p:documentation>
   Executes an XSLT stylesheet against a node.
</p:documentation>

      <p:input port="source"/>
      <p:input port="stylesheet" sequence="false"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-input" required="true"/>
      <p:option name="ml-params" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/xslt-eval.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:replace match="//stylesheet">
         <p:input port="replacement">
            <p:pipe port="stylesheet" step="xdmp-xslt-eval"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:xslt-eval"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="INPUT"/>
                  <c:param name="PARAMS"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'INPUT']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-input">
            <p:pipe port="source" step="xdmp-xslt-eval"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'PARAMS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-params">
            <p:pipe port="source" step="xdmp-xslt-eval"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-xslt-eval"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-xslt-eval"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-xslt-eval"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>


   <p:declare-step name="xdmp-xslt-invoke" type="xdmp:xslt-invoke">
      <p:documentation>
   Executes an XSLT stylesheet against a node.
</p:documentation>

      <p:input port="source"/>
      <p:output port="result" sequence="true"/>

      <p:option name="ml-path" required="true"/>
      <p:option name="ml-input" required="true"/>
      <p:option name="ml-params" required="false"/>
      <p:option name="ml-options" required="false"/>

      <p:unwrap name="configuration" match="/ml:connection"/>
      <p:sink/>

      <p:identity>
         <p:documentation>Retrieve the source query</p:documentation>
         <p:input port="source">
            <p:data href="xquery/xdmp/xslt-invoke.xqy" content-type="text/plain"/>
         </p:input>
      </p:identity>
      <p:unescape-markup>
         <p:documentation>Any XML elements in the query need to be un-escaped.</p:documentation>
      </p:unescape-markup>
      <p:replace match="//config">
         <p:input port="replacement">
            <p:pipe port="result" step="configuration"/>
         </p:input>
      </p:replace>
      <p:add-attribute match="/*" attribute-name="step-type" attribute-value="xdmp:xslt-invoke"/>
      <p:escape-markup name="query"/>
      <p:sink/>

      <p:identity>
         <p:input port="source">
            <p:inline exclude-inline-prefixes="#all">
               <c:param-set>
                  <c:param name="PATH"/>
                  <c:param name="INPUT"/>
                  <c:param name="PARAMS"/>
                  <c:param name="OPTIONS"/>
               </c:param-set>
            </p:inline>
         </p:input>
      </p:identity>
      <p:add-attribute match="//c:param[@name = 'PATH']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-path">
            <p:pipe port="source" step="xdmp-xslt-invoke"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'INPUT']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-input">
            <p:pipe port="source" step="xdmp-xslt-invoke"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'PARAMS']" attribute-name="value">
         <p:with-option name="attribute-value" select="$ml-params">
            <p:pipe port="source" step="xdmp-xslt-invoke"/>
         </p:with-option>
      </p:add-attribute>
      <p:add-attribute match="//c:param[@name = 'OPTIONS']" attribute-name="value" name="params">
         <p:with-option name="attribute-value" select="$ml-options">
            <p:pipe port="source" step="xdmp-xslt-invoke"/>
         </p:with-option>
      </p:add-attribute>

      <ml:action name="action">
         <p:input port="source">
            <p:pipe port="result" step="query"/>
         </p:input>
         <p:input port="params">
            <p:pipe port="result" step="params"/>
         </p:input>
         <p:input port="connection">
            <p:pipe port="source" step="xdmp-xslt-invoke"/>
         </p:input>
      </ml:action>
      <p:sink/>
      <p:delete match="/ml:connection/*">
         <p:input port="source">
            <p:pipe port="source" step="xdmp-xslt-invoke"/>
         </p:input>
      </p:delete>
      <p:insert match="/*" position="last-child">
         <p:input port="insertion">
            <p:pipe port="result" step="action"/>
         </p:input>
      </p:insert>
   </p:declare-step>
</p:library>