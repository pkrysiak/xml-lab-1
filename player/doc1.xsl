<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="lea:players">
        <h2>Players Info</h2>
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Position</th>
                <th style="text-align:left">Nick</th>
                <th style="text-align:left">Nationality</th>
                <th style="text-align:left">Birth Date</th>
                <th style="text-align:left">Played Club</th>
            </tr>
            <xsl:apply-templates select="lea:player"/>
        </table>
    </xsl:template>
    
    <xsl:template match="lea:player">
        <tr>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="@position"/></td>
            <td><xsl:value-of select="lea:nick"/></td>
            <td><xsl:value-of select="lea:nationality"/></td>
            <td><xsl:value-of select="lea:birthDate"/></td>
            <td><xsl:value-of select="lea:playedClubs/lea:playedClub/@clubref"/></td>
        </tr>                
    </xsl:template>
   
</xsl:stylesheet>