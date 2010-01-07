// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function isVisible( elem ){
        var $elem = $(elem);
        //First check if elem is hidden through css as this is not very costly:
        if($elem.getStyle('display') == 'none' || $elem.getStyle('visibility') == 'hidden' ){
                //elem is set through CSS stylesheet or inline to invisible
                return false;
        }
        //Now check for the elem being outside of the viewport
        var $elemOffset = $elem.viewportOffset();
        if($elemOffset.left < 0 || $elemOffset.top < 0){ 
        //elem is left of or above viewport
                return false;
        }
        var vp = document.viewport.getDimensions();
        if($elemOffset.left > vp.width || $elemOffset.top > vp.height){ 
        //elem is below or right of vp
                return false;
        }
        //Now check for elements positioned on top:
        //TODO: build check for this using prototype...
        //Neither of these was true, so the elem was visible:
        return true;
}


function getPageSize(){	
	var xScroll, yScroll;
	
	if (window.innerHeight && window.scrollMaxY) {	
		xScroll = document.body.scrollWidth;
		yScroll = window.innerHeight + window.scrollMaxY;
	} else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
		xScroll = document.body.scrollWidth;
		yScroll = document.body.scrollHeight;
	} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
		xScroll = document.body.offsetWidth;
		yScroll = document.body.offsetHeight;
	}
	
	var windowWidth, windowHeight;
	if (self.innerHeight) {	// all except Explorer
		windowWidth = self.innerWidth;
		windowHeight = self.innerHeight;
	} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
		windowWidth = document.documentElement.clientWidth;
		windowHeight = document.documentElement.clientHeight;
	} else if (document.body) { // other Explorers
		windowWidth = document.body.clientWidth;
		windowHeight = document.body.clientHeight;
	}	
	
	// for small pages with total height less then height of the viewport
	if(yScroll < windowHeight){
		pageHeight = windowHeight;
	} else { 
		pageHeight = yScroll;
	}

	// for small pages with total width less then width of the viewport
	if(xScroll < windowWidth){	
		pageWidth = windowWidth;
	} else {
		pageWidth = xScroll;
	}


	arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight) 
	return arrayPageSize;
}

function overlay(){
	h = document.body.scrollHeight;
	$('overlay').setStyle( { height: h +'px' }).show();
	$('wait_box').show();
}
