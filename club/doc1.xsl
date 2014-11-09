<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:param name="clubId" select="'Penafiel'"/>
    
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="lea:games | lea:players"/>
    
    <xsl:template match="lea:club">
        <xsl:if test="current()/@id = $clubId">
            <h2>Club Info</h2>
           
             <table border="1">
                <tr>
                    <td bgcolor="#9acd32"> Acronym:</td>
                    <td> 
                        <xsl:value-of select="lea:acronym"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32"> City:</td>
                    <td> 
                        <xsl:value-of select="lea:city"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32"> Stadium:</td>
                    <td> 
                        <xsl:value-of select="lea:stadium"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32"> Description:</td>
                    <td> 
                        <xsl:value-of select="lea:description"/> 
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#9acd32"> Weblink:</td>
                    <td> 
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="lea:webLink"/>
                            </xsl:attribute>
                            <xsl:value-of select="lea:webLink"/>
                        </a> 
                    </td>
                </tr>                                
            </table>
            <h3> Stats :</h3>
            <table border="1">
                <tr bgcolor="#9acd32">
                    <th style="text-align:left">Name</th>
                    <th style="text-align:left">Current score</th>
                    <th style="text-align:left">Number of games</th>
                    <th style="text-align:left">Number of wins</th>
                    <th style="text-align:left">Number of ties</th>
                    <th style="text-align:left">Number of loses</th>
                    <th style="text-align:left">Number of goals scored</th>
                    <th style="text-align:left">Average of goals scored</th>
                    <th style="text-align:left">Average of goals conceeded</th>
                </tr>
                 <xsl:call-template name="clubStats">
                     <xsl:with-param name="clID" select="@id"/>
                 </xsl:call-template>
            </table>
            
            <h3> Players :</h3>
            <xsl:call-template name="teamPlayers">
                <xsl:with-param name="clubId" select="@id"/>
            </xsl:call-template>
            
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name='teamPlayers'>
        <xsl:param name="clubId"/>        
        <table border="1">
            <tr bgcolor="#9acd32">
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Position</th>
                <th style="text-align:left">Nick</th>
                <th style="text-align:left">Nationality</th>
                <th style="text-align:left">Birthdate</th>
            </tr>
            <xsl:for-each select="//lea:club[@id=$clubId]/lea:teamPlayers/lea:teamPlayer">
                <xsl:call-template name="teamPlayer">
                    <xsl:with-param name="playerId" select="@id"/>
                </xsl:call-template>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template name="teamPlayer">
        <xsl:param name="playerId"/>
        <xsl:for-each select="//lea:player[@id=$playerId]">
            <tr>
                <td><xsl:value-of select="@id"/></td>
                <td><xsl:value-of select="@position"/></td>
                <td><xsl:value-of select="lea:nick"/></td>
                <td><xsl:value-of select="lea:nationality"/></td>
                <td><xsl:value-of select="lea:birthDate"/></td>
            </tr>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name='clubStats'>
        <xsl:param name="clID"/>
        <tr>
            <td><xsl:value-of select="$clID"/></td>
            <td>
                <xsl:call-template name="currentScore">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>                
                <xsl:call-template name="numberOfGames">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="numberOfWins">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="numerOfTies">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="numberOfLoses">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="numberOfGoalsScored">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="averageGoalsScored">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="averageGoalsConceeded">
                    <xsl:with-param name="clubid" select="$clID"/>
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template name="averageGoalsScored">
<!--        WORKS-->
        <xsl:param name="clubid"/>
        <xsl:variable name="numberOfGames">
            <xsl:call-template name="numberOfGames">
                <xsl:with-param name="clubid" select="$clubid"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="numberOfGoals">
            <xsl:call-template name="numberOfGoalsScored">
                <xsl:with-param name="clubid" select="$clubid"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:value-of select="format-number($numberOfGoals div $numberOfGames, '##0.00')"/>
    </xsl:template>
    
    <xsl:template name="averageGoalsConceeded">
        <xsl:param name="clubid"/>
        <xsl:variable name="numberOfGoalsConceeded">
            <xsl:call-template name="numberOfGoalsConceeded">
                <xsl:with-param name="clubid" select="$clubid"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="numberOfGames">
            <xsl:call-template name="numberOfGames">
                <xsl:with-param name="clubid" select="$clubid"/>
            </xsl:call-template>
        </xsl:variable>              
        <xsl:value-of select="format-number($numberOfGoalsConceeded div $numberOfGames, '##0.00')"/>
    </xsl:template>
    
    <xsl:template name="numberOfGoalsScored">
        <xsl:param name="clubid"/>
        <xsl:value-of select="sum(//lea:goals[@clubId=$clubid])"/>
    </xsl:template>
  
    <xsl:template name="numberOfGoalsConceeded">
        <xsl:param name="clubid"/>
        <xsl:value-of select="sum(//lea:game[(@firstTeam=$clubid) or (@secondTeam=$clubid)]/lea:result/lea:goals[@clubId!=$clubid])"/>
    </xsl:template>
  
    <xsl:template name="numerOfTies">
        <xsl:param name="clubid"/>
        <xsl:value-of select="count(//lea:game[(@firstTeam=$clubid) or (@secondTeam=$clubid)]/lea:result[ ./lea:goals[@clubId=$clubid] = ./lea:goals[@clubId != $clubid]] )"/>
    </xsl:template>
  
    <xsl:template name="numberOfWins">
        <xsl:param name="clubid"/>
        <xsl:value-of select="count(//lea:game[(@firstTeam=$clubid) or (@secondTeam=$clubid)]/lea:result[ ./lea:goals[@clubId=$clubid] > ./lea:goals[@clubId != $clubid]] )"/>
    </xsl:template>  
    
    <xsl:template name="numberOfLoses">        
        <xsl:param name="clubid"/>
        <xsl:value-of select="count(//lea:game[(@firstTeam=$clubid) or (@secondTeam=$clubid)]/lea:result[ ./lea:goals[@clubId!=$clubid] > ./lea:goals[@clubId = $clubid]] )"/>
    </xsl:template> 
    
    <xsl:template name="numberOfGames">
        <xsl:param name="clubid"/>     
        <xsl:value-of select="count(//lea:game[(@firstTeam=$clubid) or (@secondTeam=$clubid)])"/>       
    </xsl:template>
    
    <xsl:template name="currentScore">
        <xsl:param name="clubid"/> 
        <xsl:variable name="clubWins">
            <xsl:call-template name="numberOfWins">
                <xsl:with-param name="clubid" select="$clubid"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="clubTies">
            <xsl:call-template name="numerOfTies">
                <xsl:with-param name="clubid" select="$clubid"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:value-of select="$clubWins * 3 + $clubTies"/>
    </xsl:template>
  
</xsl:stylesheet>