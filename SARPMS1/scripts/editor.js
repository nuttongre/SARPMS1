// FCKeditor Class
var FCKeditor = function( instanceName, width, height, toolbarSet, value )
{
  // Properties
  this.InstanceName  = instanceName ;
  this.Width      = width      || '550' ;
  this.Height      = height    || '200' ;
  this.ToolbarSet    = toolbarSet  || 'Default' ;
  this.Value      = value      || '' ;
  this.BasePath    = '../scripts/fckeditor/' ;
  this.CheckBrowser  = true ;
  this.DisplayErrors  = true ;
  this.EnableSafari  = false ;    // This is a temporary property, while Safari support is under development.

  this.Config      = new Object() ;

  // Events
  this.OnError    = null ;  // function( source, errorNumber, errorDescription )
}

FCKeditor.prototype.Create = function()
{
  // Check for errors
  if ( !this.InstanceName || this.InstanceName.length == 0 )
  {
    this._ThrowError( 701, 'You must specify a instance name.' ) ;
    return ;
  }

  document.write( '<div>' ) ;

  if ( !this.CheckBrowser || this._IsCompatibleBrowser() )
  {
    document.write( '<input type="hidden" id="' + this.InstanceName + '" name="' + this.InstanceName + '" value="' + this._HTMLEncode( this.Value ) + '" />' ) ;
    document.write( this._GetConfigHtml() ) ;
    document.write( this._GetIFrameHtml() ) ;
  }
  else
  {
    var sWidth  = this.Width.toString().indexOf('%')  > 0 ? this.Width  : this.Width  + 'px' ;
    var sHeight = this.Height.toString().indexOf('%') > 0 ? this.Height : this.Height + 'px' ;
    document.write('<textarea name="' + this.InstanceName + '" id="' + this.InstanceName + 'textarea" rows="4" cols="40" style="WIDTH: ' + sWidth + '; HEIGHT: ' + sHeight + '" wrap="virtual">' + this._HTMLEncode( this.Value ) + '<\/textarea>') ;
  }

  document.write( '</div>' ) ;
}

FCKeditor.prototype.ReplaceTextarea = function()
{
  if ( !this.CheckBrowser || this._IsCompatibleBrowser() )
  {
    var oTextarea = document.getElementById( this.InstanceName ) ;
    
    if ( !oTextarea )
      oTextarea = document.getElementsByName( this.InstanceName )[0] ;
    
    if ( !oTextarea || oTextarea.tagName != 'TEXTAREA' )
    {
      alert( 'Error: The TEXTAREA id "' + this.InstanceName + '" was not found' ) ;
      return ;
    }

    oTextarea.style.display = 'none' ;
    this._InsertHtmlBefore( this._GetConfigHtml(), oTextarea ) ;
    this._InsertHtmlBefore( this._GetIFrameHtml(), oTextarea ) ;
  }
}

FCKeditor.prototype._InsertHtmlBefore = function( html, element )
{
  if ( element.insertAdjacentHTML )  // IE
    element.insertAdjacentHTML( 'beforeBegin', html ) ;
  else                // Gecko
  {
    var oRange = document.createRange() ;
    oRange.setStartBefore( element ) ;
    var oFragment = oRange.createContextualFragment( html );
    element.parentNode.insertBefore( oFragment, element ) ;
  }
}

FCKeditor.prototype._GetConfigHtml = function()
{
  var sConfig = '' ;
  for ( var o in this.Config )
  {
    if ( sConfig.length > 0 ) sConfig += '&amp;' ;
    sConfig += escape(o) + '=' + escape( this.Config[o] ) ;
  }

  return '<input type="hidden" id="' + this.InstanceName + '___Config" value="' + sConfig + '" />' ;
}

FCKeditor.prototype._GetIFrameHtml = function()
{
  var sLink = this.BasePath + 'editor/fckeditor.html?InstanceName=' + this.InstanceName ;
  if (this.ToolbarSet) sLink += '&Toolbar=' + this.ToolbarSet ;

  return '<iframe id="' + this.InstanceName + '___Frame" src="' + sLink + '" width="' + this.Width + '" height="' + this.Height + '" frameborder="no" scrolling="no"></iframe>' ;
}

FCKeditor.prototype._IsCompatibleBrowser = function()
{
  var sAgent = navigator.userAgent.toLowerCase() ;

  // Internet Explorer
  if ( sAgent.indexOf("msie") != -1 && sAgent.indexOf("mac") == -1 && sAgent.indexOf("opera") == -1 )
  {
    var sBrowserVersion = navigator.appVersion.match(/MSIE (.\..)/)[1] ;
    return ( sBrowserVersion >= 5.5 ) ;
  }
  // Gecko
  else if ( navigator.product == "Gecko" && navigator.productSub >= 20030210 )
    return true ;
  // Safari
  else if ( this.EnableSafari && sAgent.indexOf( 'safari' ) != -1 )
    return ( sAgent.match( /safari\/(\d+)/ )[1] >= 312 ) ;  // Build must be at least 312 (1.3)
  else
    return false ;
}

FCKeditor.prototype._ThrowError = function( errorNumber, errorDescription )
{
  this.ErrorNumber    = errorNumber ;
  this.ErrorDescription  = errorDescription ;

  if ( this.DisplayErrors )
  {
    document.write( '<div style="COLOR: #ff0000">' ) ;
    document.write( '[ FCKeditor Error ' + this.ErrorNumber + ': ' + this.ErrorDescription + ' ]' ) ;
    document.write( '</div>' ) ;
  }

  if ( typeof( this.OnError ) == 'function' )
    this.OnError( this, errorNumber, errorDescription ) ;
}

FCKeditor.prototype._HTMLEncode = function( text )
{
  if ( typeof( text ) != "string" )
    text = text.toString() ;

  text = text.replace(/&/g, "&amp;") ;
  text = text.replace(/"/g, "&quot;") ;
  text = text.replace(/</g, "&lt;") ;
  text = text.replace(/>/g, "&gt;") ;
  text = text.replace(/'/g, "&#39;") ;

  return text ;
} 