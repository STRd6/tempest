!function(){module.exports=function(code,_arg){var height,methods,sandbox,width,_ref;_ref=_arg!=null?_arg:{},width=_ref.width,height=_ref.height,methods=_ref.methods;if(width==null){width=800}if(height==null){height=600}if(methods==null){methods={}}sandbox=window.open("","sandbox","width="+width+",height="+height);Object.extend(sandbox,methods);sandbox.Function(code)();return sandbox}}.call(this);