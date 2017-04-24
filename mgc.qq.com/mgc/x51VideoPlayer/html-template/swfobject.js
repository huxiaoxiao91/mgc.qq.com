/*!	SWFObject v2.2 <http://code.google.com/p/swfobject/> 
	is released under the MIT License <http://www.opensource.org/licenses/mit-license.php> 
*/
var swfobject=function(){function aq(){var f,h,g;if(!ax){try{f=aI.getElementsByTagName("body")[0].appendChild(aa("span")),f.parentNode.removeChild(f)}catch(e){return}for(ax=!0,h=aF.length,g=0;h>g;g++){aF[g]()}}}function ap(b){ax?b():aF[aF.length]=b}function ao(a){if(typeof aJ.addEventListener!=aQ){aJ.addEventListener("load",a,!1)}else{if(typeof aI.addEventListener!=aQ){aI.addEventListener("load",a,!1)}else{if(typeof aJ.attachEvent!=aQ){Z(aJ,"onload",a)}else{if("function"==typeof aJ.onload){var d=aJ.onload;aJ.onload=function(){d(),a()}}else{aJ.onload=a}}}}}function an(){aG?am():al()}function am(){var b,a,h=aI.getElementsByTagName("body")[0],e=aa(aP);e.setAttribute("type",aM),b=h.appendChild(e),b?(a=0,function(){if(typeof b.GetVariable!=aQ){var c=b.GetVariable("$version");c&&(c=c.split(" ")[1].split(","),ar.pv=[parseInt(c[0],10),parseInt(c[1],10),parseInt(c[2],10)])}else{if(10>a){return a++,setTimeout(arguments.callee,10),void 0}}h.removeChild(e),b=null,al()}()):al()}function al(){var w,v,u,t,s,r,q,p,o,m,a,x=aE.length;if(x>0){for(w=0;x>w;w++){if(v=aE[w].id,u=aE[w].callbackFn,t={success:!1,id:v},ar.pv[0]>0){if(s=ab(v)){if(!Y(aE[w].swfVersion)||ar.wk&&ar.wk<312){if(aE[w].expressInstall&&aj()){for(r={},r.data=aE[w].expressInstall,r.width=s.getAttribute("width")||"0",r.height=s.getAttribute("height")||"0",s.getAttribute("class")&&(r.styleclass=s.getAttribute("class")),s.getAttribute("align")&&(r.align=s.getAttribute("align")),q={},p=s.getElementsByTagName("param"),o=p.length,m=0;o>m;m++){"movie"!=p[m].getAttribute("name").toLowerCase()&&(q[p[m].getAttribute("name")]=p[m].getAttribute("value"))}ai(r,q,v,u)}else{ah(s),u&&u(t)}}else{W(v,!0),u&&(t.success=!0,t.ref=ak(v),u(t))}}}else{W(v,!0),u&&(a=ak(v),a&&typeof a.SetVariable!=aQ&&(t.success=!0,t.ref=a),u(t))}}}}function ak(h){var a,g=null,b=ab(h);return b&&"OBJECT"==b.nodeName&&(typeof b.SetVariable!=aQ?g=b:(a=b.getElementsByTagName(aP)[0],a&&(g=a))),g}function aj(){return !aw&&Y("6.0.65")&&(ar.win||ar.mac)&&!(ar.wk&&ar.wk<312)}function ai(a,p,o,n){var m,l,i,f;aw=!0,az=n||null,ay={success:!1,id:o},m=ab(o),m&&("OBJECT"==m.nodeName?(aB=ag(m),aA=null):(aB=m,aA=o),a.id=aL,(typeof a.width==aQ||!/%$/.test(a.width)&&parseInt(a.width,10)<310)&&(a.width="310"),(typeof a.height==aQ||!/%$/.test(a.height)&&parseInt(a.height,10)<137)&&(a.height="137"),aI.title=aI.title.slice(0,47)+" - Flash Player Installation",l=ar.ie&&ar.win?"ActiveX":"PlugIn",i="MMredirectURL="+encodeURI(window.location).toString().replace(/&/g,"%26")+"&MMplayerType="+l+"&MMdoctitle="+aI.title,typeof p.flashvars!=aQ?p.flashvars+="&"+i:p.flashvars=i,ar.ie&&ar.win&&4!=m.readyState&&(f=aa("div"),o+="SWFObjectNew",f.setAttribute("id",o),m.parentNode.insertBefore(f,m),m.style.display="none",function(){4==m.readyState?m.parentNode.removeChild(m):setTimeout(arguments.callee,10)}()),af(a,p,o))}function ah(d){if(ar.ie&&ar.win&&4!=d.readyState){var c=aa("div");d.parentNode.insertBefore(c,d),c.parentNode.replaceChild(ag(d),c),d.style.display="none",function(){4==d.readyState?d.parentNode.removeChild(d):setTimeout(arguments.callee,10)}()}else{d.parentNode.replaceChild(ag(d),d)}}function ag(b){var k,j,i,h,l=aa("div");if(ar.win&&ar.ie){l.innerHTML=b.innerHTML}else{if(k=b.getElementsByTagName(aP)[0],k&&(j=k.childNodes)){for(i=j.length,h=0;i>h;h++){1==j[h].nodeType&&"PARAM"==j[h].nodeName||8==j[h].nodeType||l.appendChild(j[h].cloneNode(!0))}}}return l}function af(x,w,v){var u,s,r,q,n,e,b,a,t=ab(v);if(ar.wk&&ar.wk<312){return u}if(t){if(typeof x.id==aQ&&(x.id=v),ar.ie&&ar.win){s="";for(r in x){x[r]!=Object.prototype[r]&&("data"==r.toLowerCase()?w.movie=x[r]:"styleclass"==r.toLowerCase()?s+=' class="'+x[r]+'"':"classid"!=r.toLowerCase()&&(s+=" "+r+'="'+x[r]+'"'))}q="";for(n in w){w[n]!=Object.prototype[n]&&(q+='<param name="'+n+'" value="'+w[n]+'" />')}t.outerHTML='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+s+">"+q+"</object>",aD[aD.length]=x.id,u=ab(x.id)}else{e=aa(aP),e.setAttribute("type",aM);for(b in x){x[b]!=Object.prototype[b]&&("styleclass"==b.toLowerCase()?e.setAttribute("class",x[b]):"classid"!=b.toLowerCase()&&e.setAttribute(b,x[b]))}for(a in w){w[a]!=Object.prototype[a]&&"movie"!=a.toLowerCase()&&ae(e,a,w[a])}t.parentNode.replaceChild(e,t),u=e}}return u}function ae(f,e,h){var g=aa("param");g.setAttribute("name",e),g.setAttribute("value",h),f.appendChild(g)}function ad(d){var c=ab(d);c&&"OBJECT"==c.nodeName&&(ar.ie&&ar.win?(c.style.display="none",function(){4==c.readyState?ac(d):setTimeout(arguments.callee,10)}()):c.parentNode.removeChild(c))}function ac(e){var f,d=ab(e);if(d){for(f in d){"function"==typeof d[f]&&(d[f]=null)}d.parentNode.removeChild(d)}}function ab(e){var d=null;try{d=aI.getElementById(e)}catch(f){}return d}function aa(b){return aI.createElement(b)}function Z(e,d,f){e.attachEvent(d,f),aC[aC.length]=[e,d,f]}function Y(e){var d=ar.pv,f=e.split(".");return f[0]=parseInt(f[0],10),f[1]=parseInt(f[1],10)||0,f[2]=parseInt(f[2],10)||0,d[0]>f[0]||d[0]==f[0]&&d[1]>f[1]||d[0]==f[0]&&d[1]==f[1]&&d[2]>=f[2]?!0:!1}function X(n,m,l,k){var i,b,a;ar.ie&&ar.mac||(i=aI.getElementsByTagName("head")[0],i&&(b=l&&"string"==typeof l?l:"screen",k&&(av=null,au=null),av&&au==b||(a=aa("style"),a.setAttribute("type","text/css"),a.setAttribute("media",b),av=i.appendChild(a),ar.ie&&ar.win&&typeof aI.styleSheets!=aQ&&aI.styleSheets.length>0&&(av=aI.styleSheets[aI.styleSheets.length-1]),au=b),ar.ie&&ar.win?av&&typeof av.addRule==aP&&av.addRule(n,m):av&&typeof aI.createTextNode!=aQ&&av.appendChild(aI.createTextNode(n+" {"+m+"}"))))}function W(e,d){if(at){var f=d?"visible":"hidden";ax&&ab(e)?ab(e).style.visibility=f:X("#"+e,"visibility:"+f)}}function z(a){var f=/[\\\"<>\.;]/,e=null!=f.exec(a);return e&&typeof encodeURIComponent!=aQ?encodeURIComponent(a):a}var aB,aA,az,ay,av,au,aQ="undefined",aP="object",aO="Shockwave Flash",aN="ShockwaveFlash.ShockwaveFlash",aM="application/x-shockwave-flash",aL="SWFObjectExprInst",aK="onreadystatechange",aJ=window,aI=document,aH=navigator,aG=!1,aF=[an],aE=[],aD=[],aC=[],ax=!1,aw=!1,at=!0,ar=function(){var v,k=typeof aI.getElementById!=aQ&&typeof aI.getElementsByTagName!=aQ&&typeof aI.createElement!=aQ,j=aH.userAgent.toLowerCase(),i=aH.platform.toLowerCase(),h=i?/win/.test(i):/win/.test(j),e=i?/mac/.test(i):/mac/.test(j),d=/webkit/.test(j)?parseFloat(j.replace(/^.*webkit\/(\d+(\.\d+)?).*$/,"$1")):!1,c=!1,b=[0,0,0],a=null;if(typeof aH.plugins!=aQ&&typeof aH.plugins[aO]==aP){a=aH.plugins[aO].description,!a||typeof aH.mimeTypes!=aQ&&aH.mimeTypes[aM]&&!aH.mimeTypes[aM].enabledPlugin||(aG=!0,c=!1,a=a.replace(/^.*\s+(\S+\s+\S+$)/,"$1"),b[0]=parseInt(a.replace(/^(.*)\..*$/,"$1"),10),b[1]=parseInt(a.replace(/^.*\.(.*)\s.*$/,"$1"),10),b[2]=/[a-zA-Z]/.test(a)?parseInt(a.replace(/^.*[a-zA-Z]+(.*)$/,"$1"),10):0)}else{if(typeof aJ.ActiveXObject!=aQ){try{v=new ActiveXObject(aN),v&&(a=v.GetVariable("$version"),a&&(c=!0,a=a.split(" ")[1].split(","),b=[parseInt(a[0],10),parseInt(a[1],10),parseInt(a[2],10)]))}catch(u){}}}return{w3:k,pv:b,wk:d,ie:c,win:h,mac:e}}();return function(){ar.w3&&((typeof aI.readyState!=aQ&&"complete"==aI.readyState||typeof aI.readyState==aQ&&(aI.getElementsByTagName("body")[0]||aI.body))&&aq(),ax||(typeof aI.addEventListener!=aQ&&aI.addEventListener("DOMContentLoaded",aq,!1),ar.ie&&ar.win&&(aI.attachEvent(aK,function(){"complete"==aI.readyState&&(aI.detachEvent(aK,arguments.callee),aq())}),aJ==top&&function(){if(!ax){try{aI.documentElement.doScroll("left")}catch(b){return setTimeout(arguments.callee,0),void 0}aq()}}()),ar.wk&&function(){return ax?void 0:/loaded|complete/.test(aI.readyState)?(aq(),void 0):(setTimeout(arguments.callee,0),void 0)}(),ao(aq)))}(),function(){ar.ie&&ar.win&&window.attachEvent("onunload",function(){var g,l,k,j,i,h=aC.length;for(g=0;h>g;g++){aC[g][0].detachEvent(aC[g][1],aC[g][2])}for(l=aD.length,k=0;l>k;k++){ad(aD[k])}for(j in ar){ar[j]=null}ar=null;for(i in swfobject){swfobject[i]=null}swfobject=null})}(),{registerObject:function(g,f,j,i){if(ar.w3&&g&&f){var h={};h.id=g,h.swfVersion=f,h.expressInstall=j,h.callbackFn=i,aE[aE.length]=h,W(g,!1)}else{i&&i({success:!1,id:g})}},getObjectById:function(b){return ar.w3?ak(b):void 0},embedSWF:function(v,u,t,s,r,q,p,o,n,b){var a={success:!1,id:u};ar.w3&&!(ar.wk&&ar.wk<312)&&v&&u&&t&&s&&r?(W(u,!1),ap(function(){var j,i,h,g,f,e,d;if(t+="",s+="",j={},n&&typeof n===aP){for(i in n){j[i]=n[i]}}if(j.data=v,j.width=t,j.height=s,h={},o&&typeof o===aP){for(g in o){h[g]=o[g]}}if(p&&typeof p===aP){for(f in p){typeof h.flashvars!=aQ?h.flashvars+="&"+f+"="+p[f]:h.flashvars=f+"="+p[f]}}if(Y(r)){e=af(j,h,u),j.id==u&&W(u,!0),a.success=!0,a.ref=e}else{if(q&&aj()){return j.data=q,ai(j,h,u,b),void 0}if("boolean"==typeof $SYS.is_mobile&&1==$SYS.is_mobile){return}d="您未安装Flash Player或者版本过低，<br />点击“确定”前往在线安装，点击“取消”自行安装。";try{$.dialog.confirm(d,function(){window.location.href="http://get.adobe.com/cn/flashplayer/"})}catch(c){confirm(d)&&(window.location.href="http://get.adobe.com/cn/flashplayer/")}}b&&b(a)})):b&&b(a)},switchOffAutoHideShow:function(){at=!1},ua:ar,getFlashPlayerVersion:function(){return{major:ar.pv[0],minor:ar.pv[1],release:ar.pv[2]}},hasFlashPlayerVersion:Y,createSWF:function(e,d,f){return ar.w3?af(e,d,f):void 0},showExpressInstall:function(f,e,h,g){ar.w3&&aj()&&ai(f,e,h,g)},removeSWF:function(b){ar.w3&&ad(b)},createCSS:function(f,e,h,g){ar.w3&&X(f,e,h,g)},addDomLoadEvent:ap,addLoadEvent:ao,getQueryParamValue:function(f){var h,g,e=aI.location.search||aI.location.hash;if(e){if(/\?/.test(e)&&(e=e.split("?")[1]),null==f){return z(e)}for(h=e.split("&"),g=0;g<h.length;g++){if(h[g].substring(0,h[g].indexOf("="))==f){return z(h[g].substring(h[g].indexOf("=")+1))}}}return""},expressInstallCallback:function(){if(aw){var b=ab(aL);b&&aB&&(b.parentNode.replaceChild(aB,b),aA&&(W(aA,!0),ar.ie&&ar.win&&(aB.style.display="block")),az&&az(ay)),aw=!1}}}}();