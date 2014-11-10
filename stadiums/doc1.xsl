<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="my.css"/>
            </head>
            <body>
                <div class="container">
                    <xsl:apply-templates/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="lea:players | lea:clubs"/>
    
    <xsl:template match="lea:games">
        <div class="page-header">
            <h1>Stadiums Info:</h1>
        </div>
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <th style="text-align:left">Name</th>
                <th style="text-align:left">Number of Games</th>
                <th style="text-align:left">Total Spectators</th>
            </tr>
            <xsl:apply-templates select="lea:game"/>
        </table>
    </xsl:template>
    
    <xsl:template match="//lea:game">
        <xsl:variable name="stadium">
            <xsl:value-of select="./lea:location"/>
        </xsl:variable>
        <tr>
            <td><xsl:value-of select="$stadium"/></td>
            <td>
                <xsl:call-template name="numberGames">
                    <xsl:with-param name="std" select="$stadium"/>
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="totalSpectators">
                    <xsl:with-param name="std" select="$stadium"/>
                </xsl:call-template>
            </td>
        </tr>        
    </xsl:template>
    
    <xsl:template name="numberGames">
        <xsl:param name="std"/>
        <xsl:value-of select="count(//lea:game[./lea:location = $std])"/>
    </xsl:template>
    
    <xsl:template name="totalSpectators">
        <xsl:param name="std"/>
        <xsl:value-of select="sum(//lea:spectatorsNumber[../lea:location = $std])"/>
    </xsl:template>
   
</xsl:stylesheet>