<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		exclude-result-prefixes="xs">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/xml"/>

    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:dcterms="http://purl.org/dc/terms/">
        <rdf:Description rdf:about="$Source: $">
        	<dcterms:creator>Philip A. R. Fennell</dcterms:creator><!-- $Author: $ -->
            <dcterms:hasVersion>$Revision: $</dcterms:hasVersion>
            <dcterms:dateSubmitted>$Date: $</dcterms:dateSubmitted>
        	<dcterms:rights>Copyright 2009 All Rights Reserved.</dcterms:rights>
        	<dcterms:format>application/xslt+xml</dcterms:format>
        	<dcterms:description>Converts a plain text recordloader config file to XML.</dcterms:description>
        </rdf:Description>
    </rdf:RDF>

    <xsl:template match="/">
		
    </xsl:template>

</xsl:transform>
