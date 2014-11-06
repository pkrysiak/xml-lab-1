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
                <th> Scored goals</th>
                <th> Number of games played </th>
                <th> Number of initial games </th>
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
            <td>
                <xsl:call-template name="scoredGoals">
                    <xsl:with-param name="playerid" select="@id"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="numberOfGamesPlayed">
                    <xsl:with-param name="playerid" select="@id"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="numberOfInitialGamesPlayed">
                    <xsl:with-param name="playerid" select="@id"/>
                </xsl:call-template>
            </td>
        </tr>                
    </xsl:template>
    
    <xsl:template name="scoredGoals">
        <xsl:param name="playerid"/>
        <xsl:value-of select="count(//lea:scoringPlayer[@playerId=$playerid])"/>
    </xsl:template>
   
    <xsl:template name="numberOfGamesPlayed">
        <xsl:param name="playerid"/>
        <xsl:value-of select="count(//lea:game[ ./lea:initialPlayers/lea:initialPlayer[@playerId=$playerid] or ./lea:substitutions/lea:substitution[@playerid=$playerid]])"/>
    </xsl:template>
   
    <xsl:template name="numberOfInitialGamesPlayed">
<!--        sth calculated wrong-->
        <xsl:param name="playerid"/>
        <xsl:value-of select="count(//lea:initialPlayer[@playerId=$playerid])"/>
    </xsl:template>
</xsl:stylesheet>