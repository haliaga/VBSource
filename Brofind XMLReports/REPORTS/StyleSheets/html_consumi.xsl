<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <HTML>
      <BODY>
	<H2 align="center">Consumi e solvente recuperato</H2>
        <TABLE BORDER="1" cellpadding="0" cellspacing="0" align="center">
          <TR>
		<TD width="14%" height="25"> 
      			<div align="center"><font size="-1"><b>Solvente recuperato RC-104 (lt)</b></font></div>
    		</TD>
		<TD width="14%" height="25"> 
      			<div align="center"><font size="-1"><b>Solvente recuperato RC-110 (lt)</b></font></div>
    		</TD>
		<TD width="14%" height="25"> 
      			<div align="center"><font size="-1"><b>Vapore consumato RC-104 (kg)</b></font></div>
    		</TD>
		<TD width="14%" height="25"> 
      			<div align="center"><font size="-1"><b>Vapore consumato RC-110 (kg)</b></font></div>
    		</TD>
          </TR>
          <xsl:for-each select="report/record">
          <TR>  
             	<TD align="right"><font size="3"><xsl:value-of select="field1"/></font></TD>
              	<TD align="right"><font size="3"><xsl:value-of select="field4"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field7"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field10"/></font></TD>
           </TR> 
          </xsl:for-each>
        </TABLE>

	<P><b>Data inizio:</b><xsl:value-of select="report/parameter_values/date_from"/> <br></br>
	<b>Data fine:</b><xsl:value-of select="report/parameter_values/date_to"/></P>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>