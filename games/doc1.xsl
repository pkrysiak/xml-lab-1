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
    
    <xsl:template match="lea:players | lea:clubs"/>
    
    <xsl:template match="lea:games">
        <h2>Game Info</h2>
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Week</th>
                <th style="text-align:left">First Team</th>
                <th style="text-align:left">Second Team</th>
                <th style="text-align:left">Location</th>
                <th style="text-align:left">Number of Spectators</th>
                <th style="text-align:left">First Team Goals</th>
                <th style="text-align:left">Second Team Goals</th>
                <th style="text-align:left">Initial Players</th>
                <th style="text-align:left">Substitutions</th>
                <th style="text-align:left">Scoring Players</th>
            </tr>
            <xsl:apply-templates select="lea:game"/>
        </table>
    </xsl:template>
    
    <xsl:template match="//lea:game">
        <xsl:for-each select=".">
            <xsl:variable name="clubOne">
                <xsl:value-of select="@firstTeam"/>
            </xsl:variable>
            <xsl:variable name="clubTwo">
                <xsl:value-of select="@secondTeam"/>
            </xsl:variable>
                <tr>
                    <td><xsl:value-of select="./@week"/></td>
                    <td><xsl:value-of select="$clubOne"/></td>
                    <td><xsl:value-of select="$clubTwo"/></td>
                    <td><xsl:value-of select="./lea:location"/></td>
                    <td><xsl:value-of select="./lea:spectatorsNumber"/></td>
                    <td><xsl:value-of select="./lea:result/lea:goals[@clubId=$clubOne]"/></td>
                    <td><xsl:value-of select="./lea:result/lea:goals[@clubId=$clubTwo]"/></td>
                    <td>
                        <xsl:for-each select="./lea:initialPlayers/lea:initialPlayer">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:substitutions/lea:substitution">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:scoringPlayers/lea:scoringPlayer">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </td>
                </tr>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>