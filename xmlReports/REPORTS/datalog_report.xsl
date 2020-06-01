<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <HTML>
      <BODY>
	    <p><b>Report name:</b>
		<xsl:value-of select="report_definition/name"/>
	    </p>
	    <p><b>Report Description:</b>
	    	<xsl:value-of select="report_definition/description"/>
	    </p>
	    <p><b>SQL Commmand:</b>
	    	<xsl:value-of select="report_definition/sql_command"/>
	    </p>


		<p>
			<b>Parameters:</b>	    
		</p>

        <TABLE BORDER="2">
          <TR>
            <TD><b>Name</b></TD>
            <TD><b>Description</b></TD>
            <TD><b>Default value</b></TD>
          </TR>
          <xsl:for-each select="report_definition/parameter_list/parameter">
          <TR>  
              <TD><xsl:value-of select="name"/></TD>
              <TD><xsl:value-of select="description"/></TD>
              <TD><xsl:value-of select="default_value"/></TD>
           </TR> 
          </xsl:for-each>
        </TABLE>

		<p>
			<b>Stylesheets:</b>	    
		</p>

        <TABLE BORDER="2">
          <TR>
            <TD><b>Path</b></TD>
          </TR>
          <xsl:for-each select="report_definition/stylesheet_list/stylesheet">
          <TR>  
              <TD><xsl:value-of select="path"/></TD>
           </TR> 
          </xsl:for-each>
        </TABLE>

      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>