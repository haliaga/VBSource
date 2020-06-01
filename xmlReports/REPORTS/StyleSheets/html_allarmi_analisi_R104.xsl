<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <HTML>
      <BODY>
	<H2 align="center">Report Allarmi Emissioni R-104</H2>
        <TABLE BORDER="1" cellpadding="0" cellspacing="0" align="center">
          <TR>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Data Inizio</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      	            <div align="center"><font size="-1"><b>Ora Inizio</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Data Fine</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Ora Fine</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Camino Unico</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Adsorbitore A</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Adsorbitore B</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Adsorbitore C</b></font></div>
    		</TD>
            <TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Adsorbitore D</b></font></div>
    		</TD>
          </TR>
          <xsl:for-each select="report/record">
          <TR>  
              <TD align="center"><font size="3"><xsl:value-of select="field0"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field1"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field2"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field3"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field4"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field5"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field6"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field7"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field8"/></font></TD>
           </TR> 
          </xsl:for-each>
        </TABLE>
	<P><b>Data inizio:</b><xsl:value-of select="report/parameter_values/date_from"/> <br></br>
	<b>Data fine:</b><xsl:value-of select="report/parameter_values/date_to"/></P>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>