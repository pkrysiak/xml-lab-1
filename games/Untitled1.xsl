<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Edited by XMLSpy® -->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lea="http://ssdi.di.fct.unl.pt/ctxml/soccerLeague">
    
    <xsl:output method="html" encoding="UTF-8"/>
    
    <xsl:param name="type" select="'html'"/>
    <xsl:param name="columnSorts" select="0"/>
    <xsl:param name="query"/>
    
    <xsl:template match="/">
        <xsl:variable name="allLines" select="count(*/lea:soccerLeague/lea:games/lea:game)"/>
        
        <xsl:choose>
            <xsl:when test="$type = 'html'">
                
                <html>
                    <head>
                        <title></title>
                        
                        <script type="text/javascript"> 
                            var columnSorts = <xsl:value-of select="$columnSorts"/>;
                            var query = '<xsl:value-of select="$query"/>';
                        </script>
                        
                        <script type="text/javascript" src="applyXSLT-vizTab.js"/> 
                    </head>
                    <body>
                        <form name="opsForm" action="">
                            <input type="text" name="queryText" value="{$query}"/>
                            <input type="button" value="pesquisar" onclick="javascript:queryGo(document.opsForm.queryText.value)"/>
                            <input type="button" value="limpar pesquisa" onclick="javascript:document.opsForm.queryText.value='';javascript:queryGo('')"/><br/>
                        </form>
                        <xsl:apply-templates select="*/lea:soccerLeague"/>
                    </body>
                </html>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*/lea:soccerLeague"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="soccerLeague">
        <xsl:variable name="tabRef" select="generate-id(.)"/>
        <div id="myTab">
            <table id="{$tabRef}">
                <thead>
                    <th><a href="javascript:sortColumn(0)"><xsl:attribute name="title">limpa ordenação</xsl:attribute>Idx</a></th>
                    <xsl:for-each select="lea:soccerLeague/lea:games">
                        <th>
                            <a href="javascript:sortColumn({position()})">
                                <xsl:attribute name="title">ordena por coluna <xsl:value-of select="position()"/></xsl:attribute>
                                <xsl:value-of select="."/>
                            </a>
                        </th>
                    </xsl:for-each>
                </thead>
                <xsl:for-each select="lea:game[contains(descendant-or-self::*,$query)]">
                    <xsl:sort select="./lea:game[position() = $columnSorts]" order="ascending"/>
                    <tr>
                        <td><xsl:value-of select="count(preceding-sibling::*)"/></td> 
                        <xsl:for-each select="lea:game">
                            <td>
                                <xsl:value-of select="."/>
                            </td>
                        </xsl:for-each>
                    </tr>
                </xsl:for-each>
            </table>
        </div>    
    </xsl:template>
    
    
</xsl:stylesheet>
