<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:param name="plName" select="'Samaris'"/>
    
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="lea:clubs | lea:games"/>
    
    <xsl:template match="lea:player">
        <xsl:if test="current()/@id = $plName">
            <h2>Players Info</h2>
            
            <table border="1">
                <tr>
                    <td bgcolor="#9acd32">Player:</td>
                    <td> 
                        <xsl:value-of select="$plName"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Position:</td>
                    <td> 
                        <xsl:value-of select="@position"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Nickname:</td>
                    <td> 
                        <xsl:value-of select="lea:nick"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Nationality:</td>
                    <td> 
                        <xsl:value-of select="lea:nationality"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Birth Date:</td>
                    <td> 
                        <xsl:value-of select="lea:birthDate"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Player:</td>
                    <td> 
                        <xsl:value-of select="lea:playedClubs/lea:playedClub/@clubref"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Scored Goals:</td>
                    <td>
                        <xsl:call-template name="scoredGoals">
                            <xsl:with-param name="playerid" select="@id"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">No. Games Played</td>
                    <td>
                        <xsl:call-template name="numberOfGamesPlayed">
                            <xsl:with-param name="playerid" select="@id"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">No. Initial Games Played</td>
                    <td>
                        <xsl:call-template name="numberOfInitialGamesPlayed">
                            <xsl:with-param name="playerid" select="@id"/>
                        </xsl:call-template>
                    </td>
                </tr>
                <xsl:apply-templates select="lea:player"/>
            </table>
        </xsl:if>
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