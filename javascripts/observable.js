!function(){var Observable,extend,__slice=[].slice;Observable=function(value){var listeners,notify,self;if(typeof(value!=null?value.observe:void 0)==="function"){return value}listeners=[];notify=function(newValue){return listeners.forEach(function(listener){return listener(newValue)})};self=function(newValue){if(arguments.length>0){if(value!==newValue){value=newValue;notify(newValue)}}return value};extend(self,{observe:function(listener){return listeners.push(listener)},each:function(){var args,_ref;args=1<=arguments.length?__slice.call(arguments,0):[];if(value!=null){return(_ref=[value]).forEach.apply(_ref,args)}}});if(Array.isArray(value)){Object.extend(self,{each:function(){var args;args=1<=arguments.length?__slice.call(arguments,0):[];return value.forEach.apply(value,args)},map:function(){var args;args=1<=arguments.length?__slice.call(arguments,0):[];return value.map.apply(value,args)},remove:function(item){var ret;ret=value.remove(item);notify(value);return ret},push:function(item){var ret;ret=value.push(item);notify(value);return ret},pop:function(){var ret;ret=value.pop();notify(value);return ret}})}return self};module.exports=Observable;extend=function(){var name,source,sources,target,_i,_len;target=arguments[0],sources=2<=arguments.length?__slice.call(arguments,1):[];for(_i=0,_len=sources.length;_i<_len;_i++){source=sources[_i];for(name in source){target[name]=source[name]}}return target}}.call(this);