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
    
    <xsl:template match="lea:players | lea:clubs"/>
    
    <xsl:template match="lea:games">
        <h2>Game Info</h2>
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Week</th>
                <th style="text-align:left">1st Team</th>
                <th style="text-align:left">2nd Team</th>
                <th style="text-align:left">Location</th>
                <th style="text-align:left">No. of Spectators</th>
                <th style="text-align:left">1st Team Goals</th>
                <th style="text-align:left">2nd Team Goals</th>
                <th style="text-align:left">Initial Players 1st Team</th>
                <th style="text-align:left">Initial Players 2nd Team</th>
                <th style="text-align:left">Substitutions 1st Team</th>
                <th style="text-align:left">Substitutions 2nd Team</th>
                <th style="text-align:left">Scoring Players 1st Team</th>
                <th style="text-align:left">Scoring Players 2nd Team</th>
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
                        <xsl:for-each select="./lea:initialPlayers/lea:initialPlayer[@plClubId=$clubOne]">
                            <xsl:value-of select="./@playerId"/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:initialPlayers/lea:initialPlayer[@plClubId=$clubTwo]">
                            <xsl:value-of select="./@playerId"/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:substitutions/lea:substitution[@plClubId=$clubOne]">
                            <xsl:value-of select="./@playerId"/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:substitutions/lea:substitution[@plClubId=$clubTwo]">
                            <xsl:value-of select="./@playerId"/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:scoringPlayers/lea:scoringPlayer[@clubId=$clubOne]">
                            <xsl:value-of select="./@playerId"/>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="./lea:scoringPlayers/lea:scoringPlayer[@clubId=$clubTwo]">
                            <xsl:value-of select="./@playerId"/>
                        </xsl:for-each>
                    </td>
                </tr>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>