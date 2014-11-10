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
    
    <xsl:template match="lea:game">
        <xsl:if test="current()/@week = $weekId">
            <xsl:variable name="teamOne">
                <xsl:value-of select="@firstTeam"/>
            </xsl:variable>
            <xsl:variable name="teamTwo">
                <xsl:value-of select="@secondTeam"/>
            </xsl:variable>
        <h2>Game Info</h2>
            <table border="1">
                <tr>
                    <td bgcolor="#9acd32">Week:</td>
                    <td> 
                        <xsl:value-of select="@week"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">1st Team:</td>
                    <td> 
                        <xsl:value-of select="$teamOne"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">2nd Team:</td>
                    <td> 
                        <xsl:value-of select="$teamTwo"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Location:</td>
                    <td> 
                        <xsl:value-of select="lea:location"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">Spectators Number:</td>
                    <td> 
                        <xsl:value-of select="lea:spectatorsNumber"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">1st Team Goals:</td>
                    <td> 
                        <xsl:value-of select="lea:result/lea:goals[@clubId=$teamOne]"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32">2nd Team Goals:</td>
                    <td> 
                        <xsl:value-of select="lea:result/lea:goals[@clubId=$teamTwo]"/> 
                    </td>
                </tr>
            </table>
            
            <h3>Initial Players:</h3>
            <xsl:call-template name="initPlayers">
                <xsl:with-param name="weekId" select="@week"/>
            </xsl:call-template>
            
            <h3>Substitutions:</h3>
            <xsl:call-template name="subs">
                <xsl:with-param name="weekId" select="@week"/>
            </xsl:call-template>
            
            <h3>Scoring Players:</h3>
            <xsl:call-template name="scorePlayers">
                <xsl:with-param name="weekId" select="@week"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
     
    <xsl:template name='initPlayers'>
        <xsl:param name="weekId"/>        
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Team</th>
            </tr>
                <xsl:for-each select="//lea:game[@week=$weekId]/lea:initialPlayers/lea:initialPlayer">
                    <tr>
                        <td><xsl:value-of select="./@playerId"/></td>
                        <td><xsl:value-of select="./@plClubId"/></td>
                    </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template name='subs'>
        <xsl:param name="weekId"/>        
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Substituted Player</th>
                <th style="text-align:left">Team</th>
            </tr>
            <xsl:for-each select="//lea:game[@week=$weekId]/lea:substitutions/lea:substitution">
                <tr>
                    <td><xsl:value-of select="./@playerId"/></td>
                    <td><xsl:value-of select="./@substitutedPlayerId"/></td>
                    <td><xsl:value-of select="./@clubId"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template name='scorePlayers'>
        <xsl:param name="weekId"/>        
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Team</th>
            </tr>
            <xsl:for-each select="//lea:game[@week=$weekId]/lea:scoringPlayers/lea:scoringPlayer">
                <tr>
                    <td><xsl:value-of select="./@playerId"/></td>
                    <td><xsl:value-of select="./@clubId"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>