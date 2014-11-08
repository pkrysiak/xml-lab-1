<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:param name="weekId" select="'wk7'"/>
    
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="lea:game">
        <h2>Game Info</h2>
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Week</th>
                <th style="text-align:left">First Team</th>
                <th style="text-align:left">Second Team</th>
                <th style="text-align:left">Location</th>
                <th style="text-align:left">Number of Spectators</th>
                <th style="text-align:left">Result</th>
                <th style="text-align:left">Initial Players</th>
                <th style="text-align:left">Substitutions</th>
                <th style="text-align:left">Scoring Players</th>
            </tr>
        </table>
    </xsl:template>
    
    <xsl:template name="rows">
        <xsl:for-each select="//lea:game[@week = $weekId]">
            <tr>
                <td><xsl:value-of select="$weekId"/></td>
                <td><xsl:value-of select="@firstTeam"/></td>
                <td><xsl:value-of select="@secondTeam"/></td>
                <td><xsl:value-of select="lea:location"/></td>
                <td>
                    <xsl:for-each select="lea:result/lea:goal">
                        <xsl:value-of select="current()/lea:goal"/>
                    </xsl:for-each>
                </td>
                <td>
                    <xsl:for-each select="lea:initialPlayers/lea:initialPlayer">
                        <xsl:value-of select="current()/lea:initialPlayer"/>
                    </xsl:for-each>
                </td>
                <td>
                    
                </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>    
        </xsl:for-each>
         
        
     
    </xsl:template>
</xsl:stylesheet>