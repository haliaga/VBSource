<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <HTML>
      <BODY>
	<H2 align="center">Rigenerazioni recupero esano RC-110</H2>
        <TABLE BORDER="1" cellpadding="0" cellspacing="0" align="center">
          <TR>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Data</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Ora fine</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Adsorbitore</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Raporto<br></br>solvente/vapore</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Solvente<br></br>recuperato<br></br>(lt)</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Vapore<br></br>consumato<br></br>(kg)</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Solvente<br></br>accumulato<br></br>(lt)</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Concentrazione<br></br>adsorbitore<br></br>(mg/m3)</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Saturazione<br></br>(%)</b></font></div>
    		</TD>
		<TD width="10%" height="25"> 
      			<div align="center"><font size="-1"><b>Tempo<br></br>adsorbimento<br></br>(min)</b></font></div>
    		</TD>
          </TR>
          <xsl:for-each select="report/record">
          <TR>  
              <TD align="center"><font size="3"><xsl:value-of select="field0"/></font></TD>
              <TD align="right"><font size="3"><xsl:value-of select="field1"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field2"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field5"/></font></TD>		
		<TD align="right"><font size="3"><xsl:value-of select="field3"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field4"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field8"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field6"/></font></TD>		
		<TD align="right"><font size="3"><xsl:value-of select="field7"/></font></TD>
		<TD align="right"><font size="3"><xsl:value-of select="field9"/></font></TD>
           </TR> 
          </xsl:for-each>
        </TABLE>

	<P><b>Data inizio:</b><xsl:value-of select="report/parameter_values/date_from"/> <br></br>
	<b>Data fine:</b><xsl:value-of select="report/parameter_values/date_to"/></P>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>