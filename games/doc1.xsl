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
            <head>
                <link rel="stylesheet" type="text/css" href="my.css"/>
            </head>
            <body>
                <div class="container">
                    <div class="page-header">
                        <h1>Games info</h1>
                        <small>Week:  <xsl:value-of select="$weekId"/></small>
                    </div>
                    <xsl:apply-templates/>
                </div>
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
            <div class="page-header">
                <h2>Game Info</h2>
            </div>
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td >Week:</td>
                    <td> 
                        <xsl:value-of select="@week"/> 
                    </td>
                </tr>
                <tr>
                    <td >1st Team:</td>
                    <td> 
                        <xsl:value-of select="$teamOne"/> 
                    </td>
                </tr>
                <tr>
                    <td >2nd Team:</td>
                    <td> 
                        <xsl:value-of select="$teamTwo"/> 
                    </td>
                </tr>
                <tr>
                    <td >Location:</td>
                    <td> 
                        <xsl:value-of select="lea:location"/> 
                    </td>
                </tr>
                <tr>
                    <td >Spectators Number:</td>
                    <td> 
                        <xsl:value-of select="lea:spectatorsNumber"/> 
                    </td>
                </tr>
                <tr>
                    <td >1st Team Goals:</td>
                    <td> 
                        <xsl:value-of select="lea:result/lea:goals[@clubId=$teamOne]"/> 
                    </td>
                </tr>
                <tr>
                    <td >2nd Team Goals:</td>
                    <td> 
                        <xsl:value-of select="lea:result/lea:goals[@clubId=$teamTwo]"/> 
                    </td>
                </tr>
            </table>
            
            <div class="page-header">
                <h1>Initial players</h1>
            </div>
            <xsl:call-template name="initPlayers">
                <xsl:with-param name="weekId" select="@week"/>
                <xsl:with-param name="gameId" select="@id"/>
            </xsl:call-template>
            
            <div class="page-header">
                <h1>Substitutions:</h1>
            </div>
            <xsl:call-template name="subs">
                <xsl:with-param name="weekId" select="@week"/>
                <xsl:with-param name="gameId" select="@id"/>
            </xsl:call-template>
            
            <div class="page-header">
                <h1>Scoring players</h1>
            </div>
            <xsl:call-template name="scorePlayers">
                <xsl:with-param name="weekId" select="@week"/>
                <xsl:with-param name="gameId" select="@id"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
     
    <xsl:template name='initPlayers'>
        <xsl:param name="weekId"/>  
        <xsl:param name="gameId"/>
        <table class="table table-striped table-bordered table-hover">
            <tr >
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Team</th>
            </tr>
                <xsl:for-each select="//lea:game[@id=$gameId and @week=$weekId]/lea:initialPlayers/lea:initialPlayer">
                    <tr>
                        <td><xsl:value-of select="./@playerId"/></td>
                        <td><xsl:value-of select="./@plClubId"/></td>
                    </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template name='subs'>
        <xsl:param name="weekId"/> 
        <xsl:param name="gameId"/>
        <table class="table table-striped table-bordered table-hover">
            <tr >
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Substituted Player</th>
                <th style="text-align:left">Team</th>
            </tr>
            <xsl:for-each select="//lea:game[@id=$gameId and @week=$weekId]/lea:substitutions/lea:substitution">
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
        <xsl:param name="gameId"/>
        <table class="table table-striped table-bordered table-hover">
            <tr >
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Team</th>
            </tr>
            <xsl:for-each select="//lea:game[@id=$gameId and @week=$weekId]/lea:scoringPlayers/lea:scoringPlayer">
                <tr>
                    <td><xsl:value-of select="./@playerId"/></td>
                    <td><xsl:value-of select="./@clubId"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>