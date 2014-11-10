<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:param name="clubId" select="'Penafiel'"/>
    
    <xsl:template match="/">
        <head>
            <link rel="stylesheet" type="text/css" href="my.css"/>
        </head>
        <body>
            <div class="container">
                <xsl:apply-templates/>
            </div>
        </body>
    </xsl:template>
    
    <xsl:template match="lea:games | lea:players"/>
    
    <xsl:template match="lea:club">
        <xsl:if test="current()/@id = $clubId">
            <div class="page-header">
                <h1>Club Info</h1>
            </div>
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td > Acronym:</td>
                    <td> 
                        <xsl:value-of select="lea:acronym"/> 
                    </td>
                </tr>
                <tr>
                    <td > City:</td>
                    <td> 
                        <xsl:value-of select="lea:city"/> 
                    </td>
                </tr>
                <tr>
                    <td > Stadium:</td>
                    <td> 
                        <xsl:value-of select="lea:stadium"/> 
                    </td>
                </tr>
                <tr>
                    <td > Description:</td>
                    <td> 
                        <xsl:value-of select="lea:description"/> 
                    </td>
                </tr>
                <tr>
                    <td > Weblink:</td>
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
            <div class="page-header">
                <h3>Stats:</h3>
            </div>
            <table class="table table-striped table-bordered table-hover" >
                <tr >
                    <th >Name</th>
                    <th >Current score</th>
                    <th >Number of games</th>
                    <th >Number of wins</th>
                    <th >Number of ties</th>
                    <th >Number of loses</th>
                    <th >Number of goals scored</th>
                    <th >Average of goals scored</th>
                    <th >Average of goals conceeded</th>
                </tr>
                 <xsl:call-template name="clubStats">
                     <xsl:with-param name="clID" select="@id"/>
                 </xsl:call-template>
            </table>
            
            <div class="page-header">
                <h3>Players:</h3>
            </div>
            <xsl:call-template name="teamPlayers">
                <xsl:with-param name="clubId" select="@id"/>
            </xsl:call-template>
            
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name='teamPlayers'>
        <xsl:param name="clubId"/>        
        <table class="table table-striped table-bordered table-hover">
            <tr >
                <th >Name</th>
                <th >Position</th>
                <th >Nick</th>
                <th >Nationality</th>
                <th >Birthdate</th>
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