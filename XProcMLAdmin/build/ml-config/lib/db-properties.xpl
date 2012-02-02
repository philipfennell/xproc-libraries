<p:library xmlns:xdmp="http://marklogic.com/xdmp" xmlns:xhtml="http://www.w3.org/1999/xhtml"
           xmlns:cxml="http://xmlcalabash.com/ns/extensions/marklogic"
           xmlns:yell="http://www.yellgroup.com"
           xmlns:admin="http://marklogic.com/xdmp/admin"
           xmlns:apidoc="http://marklogic.com/xdmp/apidoc"
           xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:c="http://www.w3.org/ns/xproc-step"
           xmlns:ml="http://www.marklogic.com"
           xmlns:mla="http://www.marklogic.com/admin"
           version="1.0">
   <p:documentation>High-level library for setting database properties</p:documentation>
   <p:import href="xdmp.xpl"/>
   <p:import href="admin.xpl"/>


   <p:declare-step type="mla:attribute-value-positions">
      <p:documentation>
		  This function sets the attribute value positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-attribute-value-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-attribute-value-positions>
   </p:declare-step>


   <p:declare-step type="mla:collection-lexicon">
      <p:documentation>
		  This function sets the collection lexicon setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-collection-lexicon>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-collection-lexicon>
   </p:declare-step>


   <p:declare-step type="mla:directory-creation">
      <p:documentation>
		  This function sets the directory creation setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-directory-creation>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-directory-creation>
   </p:declare-step>


   <p:declare-step type="mla:element-value-positions">
      <p:documentation>
		  This function sets the element value positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-element-value-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-element-value-positions>
   </p:declare-step>


   <p:declare-step type="mla:element-word-positions">
      <p:documentation>
		  This function sets the element word positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-element-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-element-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:enabled">
      <p:documentation>
		  This function sets the enabled value
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-enabled>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-enabled>
   </p:declare-step>


   <p:declare-step type="mla:expunge-locks">
      <p:documentation>
		  This function sets the expunge locks setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-expunge-locks>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-expunge-locks>
   </p:declare-step>


   <p:declare-step type="mla:fast-case-sensitive-searches">
      <p:documentation>
		  This function sets the fast case sensitive searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-case-sensitive-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-case-sensitive-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-diacritic-sensitive-searches">
      <p:documentation>
		  This function sets the fast diacritic-sensitive searches 
		  setting for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-diacritic-sensitive-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-diacritic-sensitive-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-element-character-searches">
      <p:documentation>
		  This function sets the fast element character searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-element-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-element-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-element-phrase-searches">
      <p:documentation>
		  This function sets the fast element phrase searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-element-phrase-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-element-phrase-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-element-trailing-wildcard-searches">
      <p:documentation>
		  This function sets the fast element trailing wildcard searches 
		  setting for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-element-trailing-wildcard-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-element-trailing-wildcard-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-element-word-searches">
      <p:documentation>
		  This function sets the element word searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-element-word-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-element-word-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-phrase-searches">
      <p:documentation>
		  This function sets the fast phrase searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-phrase-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-phrase-searches>
   </p:declare-step>


   <p:declare-step type="mla:fast-reverse-searches">
      <p:documentation>
		  This function sets the fast reverse searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-fast-reverse-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-fast-reverse-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-fast-case-sensitive-searches">
      <p:documentation>
		  This function sets the field fast case sensitive
		  searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-fast-case-sensitive-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-fast-case-sensitive-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-fast-diacritic-sensitive-searches">
      <p:documentation>
		  This function sets the field fast diacritic sensitive
		  searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-fast-diacritic-sensitive-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-fast-diacritic-sensitive-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-fast-phrase-searches">
      <p:documentation>
		  This function sets the field fast phrase searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-fast-phrase-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-fast-phrase-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-include-document-root">
      <p:documentation>
		  This function sets the field include document root setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-include-document-root>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-include-document-root>
   </p:declare-step>


   <p:declare-step type="mla:field-name">
      <p:documentation>
		  This function sets the field name setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-name>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-name>
   </p:declare-step>


   <p:declare-step type="mla:field-one-character-searches">
      <p:documentation>
		  This function sets the field one character searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-one-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-one-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-stemmed-searches">
      <p:documentation>
		  This function sets the field stemmed searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-stemmed-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-stemmed-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-three-character-searches">
      <p:documentation>
		  This function sets the field three character searches 
		  setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-three-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-three-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-three-character-word-positions">
      <p:documentation>
		  This function sets the field three character
		  word positions setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-three-character-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-three-character-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:field-trailing-wildcard-searches">
      <p:documentation>
		  This function sets the field trailing wildcard 
		  searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-trailing-wildcard-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-trailing-wildcard-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-trailing-wildcard-word-positions">
      <p:documentation>
		  This function sets the field trailing wildcard word
		  positions setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-trailing-wildcard-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-trailing-wildcard-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:field-two-character-searches">
      <p:documentation>
		  This function sets the field two character searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-two-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-two-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:field-word-searches">
      <p:documentation>
		  This function sets the field word searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-field-word-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-field-name" select="$value"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-field-word-searches>
   </p:declare-step>


   <p:declare-step type="mla:format-compatibility">
      <p:documentation>
		  This function sets the format cpmpatibility setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-format-compatibility>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-format-compatibility>
   </p:declare-step>


   <p:declare-step type="mla:in-memory-limit">
      <p:documentation>
		  This function sets the in-memory limit setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-in-memory-limit>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-in-memory-limit>
   </p:declare-step>


   <p:declare-step type="mla:in-memory-list-size">
      <p:documentation>
		  This function sets the in-memory list size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-in-memory-list-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-in-memory-list-size>
   </p:declare-step>


   <p:declare-step type="mla:in-memory-range-index-size">
      <p:documentation>
		  This function sets the in-memory range index size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-in-memory-range-index-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-in-memory-range-index-size>
   </p:declare-step>


   <p:declare-step type="mla:in-memory-reverse-index-size">
      <p:documentation>
		  This function sets the in-memory range reverse index 
		  size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-in-memory-reverse-index-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-in-memory-reverse-index-size>
   </p:declare-step>


   <p:declare-step type="mla:in-memory-tree-size">
      <p:documentation>
		  This function sets the in-memory tree size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-in-memory-tree-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-in-memory-tree-size>
   </p:declare-step>


   <p:declare-step type="mla:index-detection">
      <p:documentation>
		  This function sets the index detection setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-index-detection>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-index-detection>
   </p:declare-step>


   <p:declare-step type="mla:inherit-collections">
      <p:documentation>
		  This function sets the inherit collections setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-inherit-collections>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-inherit-collections>
   </p:declare-step>


   <p:declare-step type="mla:inherit-permissions">
      <p:documentation>
		  This function sets the inherit permissions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-inherit-permissions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-inherit-permissions>
   </p:declare-step>


   <p:declare-step type="mla:inherit-quality">
      <p:documentation>
		  This function sets the inherit quality setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-inherit-quality>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-inherit-quality>
   </p:declare-step>


   <p:declare-step type="mla:journal-size">
      <p:documentation>
		  This function sets the journal size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-journal-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-journal-size>
   </p:declare-step>


   <p:declare-step type="mla:language">
      <p:documentation>
		  This function sets the language
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-language>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-language>
   </p:declare-step>


   <p:declare-step type="mla:maintain-directory-last-modified">
      <p:documentation>
		  This function sets the maintain directory last modified setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-maintain-directory-last-modified>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-maintain-directory-last-modified>
   </p:declare-step>


   <p:declare-step type="mla:maintain-last-modified">
      <p:documentation>
		  This function sets the maintain last modified setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-maintain-last-modified>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-maintain-last-modified>
   </p:declare-step>


   <p:declare-step type="mla:merge-enable">
      <p:documentation>
		  This function sets the merge enable setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-merge-enable>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-merge-enable>
   </p:declare-step>


   <p:declare-step type="mla:merge-max-size">
      <p:documentation>
		  This function sets the merge max size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-merge-max-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-merge-max-size>
   </p:declare-step>


   <p:declare-step type="mla:merge-min-ratio">
      <p:documentation>
		  This function sets the merge min ratio setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-merge-min-ratio>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-merge-min-ratio>
   </p:declare-step>


   <p:declare-step type="mla:merge-min-size">
      <p:documentation>
		  This function sets the merge minimum size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-merge-min-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-merge-min-size>
   </p:declare-step>


   <p:declare-step type="mla:merge-timestamp">
      <p:documentation>
		  This function sets the merge timestamp setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-merge-timestamp>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-merge-timestamp>
   </p:declare-step>


   <p:declare-step type="mla:name">
      <p:documentation>
		  This function changes the name of the database with the
		  specified ID to the specified name.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-name>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-name>
   </p:declare-step>


   <p:declare-step type="mla:one-character-searches">
      <p:documentation>
		  This function sets the one character searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-one-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-one-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:positions-list-max-size">
      <p:documentation>
		  This function sets the positions list max size setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-positions-list-max-size>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-positions-list-max-size>
   </p:declare-step>


   <p:declare-step type="mla:preallocate-journals">
      <p:documentation>
		  This function sets the preallocate journals setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-preallocate-journals>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-preallocate-journals>
   </p:declare-step>


   <p:declare-step type="mla:preload-mapped-data">
      <p:documentation>
		  This function sets the preload mapped data setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-preload-mapped-data>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-preload-mapped-data>
   </p:declare-step>


   <p:declare-step type="mla:reindexer-enable">
      <p:documentation>
		  This function sets the reindexer enable setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-reindexer-enable>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-reindexer-enable>
   </p:declare-step>


   <p:declare-step type="mla:reindexer-throttle">
      <p:documentation>
		  This function sets the reindexer throttle setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-reindexer-throttle>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-reindexer-throttle>
   </p:declare-step>


   <p:declare-step type="mla:reindexer-timestamp">
      <p:documentation>
		  This function sets the reindexer timestamp setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-reindexer-timestamp>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-reindexer-timestamp>
   </p:declare-step>


   <p:declare-step type="mla:schema-database">
      <p:documentation>
		  This function sets the schema database for a database
		  to the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-schema-database>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-schema-database>
   </p:declare-step>


   <p:declare-step type="mla:security-database">
      <p:documentation>
		  This function sets the security database for a database
		  to the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-security-database>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-security-database>
   </p:declare-step>


   <p:declare-step type="mla:stemmed-searches">
      <p:documentation>
		  This function sets the stemmed searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-stemmed-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-stemmed-searches>
   </p:declare-step>


   <p:declare-step type="mla:tf-normalization">
      <p:documentation>This function specifies whether to use the default term-frequency 
  normalization ( scaled-log ), which scales the term frequency based on the size of 
  the document, or to use the  unscaled-log , which uses term frequency as a function 
  of the actual term frequency in a document, regardless of the document size. 
  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-tf-normalization>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-tf-normalization>
   </p:declare-step>


   <p:declare-step type="mla:three-character-searches">
      <p:documentation>
		  This function sets the three character searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-three-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-three-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:three-character-word-positions">
      <p:documentation>
		  This function sets the three character word positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-three-character-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-three-character-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:trailing-wildcard-searches">
      <p:documentation>
		  This function sets the trailing wildcard searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-trailing-wildcard-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-trailing-wildcard-searches>
   </p:declare-step>


   <p:declare-step type="mla:trailing-wildcard-word-positions">
      <p:documentation>
		  This function sets the trailing wildcard word positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-trailing-wildcard-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-trailing-wildcard-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:triggers-database">
      <p:documentation>
		  This function sets the triggers database to the specified
		  database ID for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-triggers-database>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-triggers-database>
   </p:declare-step>


   <p:declare-step type="mla:two-character-searches">
      <p:documentation>
		  This function sets the two character searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-two-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-two-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:uri-lexicon">
      <p:documentation>
		  This function sets the URI lexicon setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-uri-lexicon>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-uri-lexicon>
   </p:declare-step>


   <p:declare-step type="mla:word-positions">
      <p:documentation>
		  This function sets the word positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:word-query-fast-case-sensitive-searches">
      <p:documentation>
		  This function returns the word query fast case
		  sensitive searches setting
		  for the specified database from the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-fast-case-sensitive-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-fast-case-sensitive-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-fast-diacritic-sensitive-searches">
      <p:documentation>
		  This function sets the word query fast diacritic 
		  sensitive searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-fast-diacritic-sensitive-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-fast-diacritic-sensitive-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-fast-phrase-searches">
      <p:documentation>
		  This function sets the word query fast phrase
		  searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-fast-phrase-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-fast-phrase-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-include-document-root">
      <p:documentation>
		  This function sets the word query include
		  document root setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-include-document-root>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-include-document-root>
   </p:declare-step>


   <p:declare-step type="mla:word-query-one-character-searches">
      <p:documentation>
		  This function sets the word query one character
		  searches setting
		  for the specified field in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-one-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-one-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-stemmed-searches">
      <p:documentation>
		  This function sets the word query stemmed searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-stemmed-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-stemmed-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-three-character-searches">
      <p:documentation>
		  This function sets the word query three character
		  searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-three-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-three-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-three-character-word-positions">
      <p:documentation>
		  This function sets the word query three character
		  word positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-three-character-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-three-character-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:word-query-trailing-wildcard-searches">
      <p:documentation>
		  This function sets the word query trailing
		  wildcard searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-trailing-wildcard-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-trailing-wildcard-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-trailing-wildcard-word-positions">
      <p:documentation>
		  This function sets the word query trailing wildcard 
		  word positions setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-trailing-wildcard-word-positions>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-trailing-wildcard-word-positions>
   </p:declare-step>


   <p:declare-step type="mla:word-query-two-character-searches">
      <p:documentation>
		  This function sets the word query two character
		  searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-two-character-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-two-character-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-query-word-searches">
      <p:documentation>
		  This function sets the word query word searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-query-word-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-query-word-searches>
   </p:declare-step>


   <p:declare-step type="mla:word-searches">
      <p:documentation>
		  This function sets the word searches setting
		  for the specified database in the configuration.
	  </p:documentation>
      <p:input port="source"/>
      <p:output port="result" sequence="false"/>

      <p:option name="value" required="true"/>

      <admin:database-set-word-searches>
         <p:with-option name="ml-database-id" select="/ml:connection/@database-id"/>
         <p:with-option name="ml-value" select="$value"/>
      </admin:database-set-word-searches>
   </p:declare-step>
</p:library>