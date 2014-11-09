var xslFile = "Untitled1.xsl";
var xmlFile = "index.xml";

var myXslStylesheet;
var myXmlData;
                    
function init() {
    if(document.implementation.createDocument) {
        var request = new XMLHttpRequest();
        request.overrideMimeType('text/xml');                    
        request.open("GET", xslFile , false);
        request.send(null);
        myXslStylesheet = request.responseXML;
        request.overrideMimeType('text/xml');      
        request.open("GET",xmlFile,false);
        request.send(null);
        myXmlData = request.responseXML;                    
    } else {
        // IE ?!? Nahhh ! :)
    }
}
                    
function doTransformation() 
{
    var myXslProc; 

    if(document.implementation.createDocument) {
        // init a processor
        // create a XSLT processor
        // Mozilla has a very nice processor object
        myXslProc = new XSLTProcessor();
        myXslProc.importStylesheet(myXslStylesheet);
    
        // do the transform (domDocument is the current HTML page you're on)
        myXslProc.setParameter("","columnSorts",columnSorts);
        myXslProc.setParameter("","query",query);
        myXslProc.setParameter("","type",'notHTML');

        var fragment = myXslProc.transformToFragment(myXmlData, document);

        var tmpDiv = document.getElementById("myTab");
        tmpDiv.parentNode.replaceChild(fragment,tmpDiv);
    } else {
        // IE ?!? Nahhh ! :)
    }
}

function sortColumn(column) 
{
    columnSorts = column;
    doTransformation();
}

function queryGo(q) 
{
    query = q;
    doTransformation();
}


init();