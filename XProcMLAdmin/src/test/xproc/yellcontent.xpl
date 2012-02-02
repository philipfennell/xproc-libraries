<p:declare-step 
		xmlns:admin="http://marklogic.com/xdmp/admin"
		xmlns:ml="http://www.marklogic.com"
		xmlns:mla="http://www.marklogic.com/admin"
		xmlns:p="http://www.w3.org/ns/xproc"
		xml:base="../../../" 
		name="yellcontent" 
		xpath-version="2.0"
		version="1.0">
	<p:documentation>Creates the yellcontent database.</p:documentation>
	<p:input port="connection"/>
	<p:output port="result"/>
	
	<p:import href="build/ml-config/lib/ml-config.xpl"/>
	
	<mla:create-database-from-config>
		<p:input port="config">
			<p:inline>
				<mla:database name="_yellcontent">
					<mla:forests>
						<mla:forest name="_poicontent01" host="hp6910-772b.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent00" host="hp6910-772b.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent01" host="hp6910-772b.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent02" host="hp6910-772b.marklogic.com" datadir=""/>
						<mla:forest name="_yellcontent03" host="hp6910-772b.marklogic.com" datadir=""/>
						<mla:forest name="_yelllocations" host="hp6910-772b.marklogic.com" datadir=""/>
						<mla:forest name="_yellwebcrawl" host="hp6910-772b.marklogic.com" datadir=""/>
					</mla:forests>
				</mla:database>
			</p:inline>
		</p:input>
	</mla:create-database-from-config>
	
	<mla:trailing-wildcard-searches value="true"/>
	<mla:word-searches value="true"/>
	<mla:word-positions value="true"/>
	<mla:element-word-positions value="true"/>
	<mla:three-character-searches value="true"/>
	<mla:fast-element-character-searches value="true"/>
	<mla:uri-lexicon value="true"/>
	<mla:reindexer-enable value="false"/>
	<mla:maintain-last-modified value="false"/>
	<mla:maintain-directory-last-modified value="false"/>
	<mla:inherit-permissions value="false"/>
	<mla:inherit-collections value="false"/>
	<mla:inherit-quality value="false"/>
	<mla:in-memory-limit value="32768"/>
	<mla:in-memory-list-size value="64"/>
	<mla:in-memory-tree-size value="16"/>
	<mla:in-memory-range-index-size value="2"/>
	<mla:in-memory-reverse-index-size value="2"/>
	<mla:journal-size value="128"/>
	<mla:directory-creation value="manual"/>
	<mla:language value="en"/>
	<mla:stemmed-searches value="basic"/>
	<mla:fast-phrase-searches value="true"/>
	<mla:fast-case-sensitive-searches value="true"/>
	<mla:fast-reverse-searches value="false"/>
	<mla:fast-diacritic-sensitive-searches value="true"/>
	<mla:fast-element-word-searches value="true"/>
	<mla:fast-element-phrase-searches value="true"/>
	<mla:element-value-positions value="false"/>
	<mla:attribute-value-positions value="false"/>
	<mla:trailing-wildcard-word-positions value="false"/>
	<mla:fast-element-trailing-wildcard-searches value="false"/>
	<mla:three-character-word-positions value="false"/>
	<mla:two-character-searches value="false"/>
	<mla:one-character-searches value="false"/>
	<mla:collection-lexicon value="false"/>
	<mla:reindexer-throttle value="5"/>
	<mla:positions-list-max-size value="256"/>
	<mla:format-compatibility value="automatic"/>
	<mla:index-detection value="automatic"/>
	<mla:expunge-locks value="automatic"/>
	<mla:preallocate-journals value="false"/>
	<mla:preload-mapped-data value="true"/>
	
	<admin:save-configuration-without-restart/>
</p:declare-step>
