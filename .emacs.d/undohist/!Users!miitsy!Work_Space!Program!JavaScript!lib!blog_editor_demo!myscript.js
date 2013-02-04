
((digest . "698b7f9ef6b1b2a5ec4c6c3f8abb682c") (undo-list nil (5104 . 5105) nil (#(" " 0 1 (face font-lock-comment-delimiter-face)) . 5104) nil (#(" " 0 1 (fontified t)) . 1137) nil (1137 . 1138) nil (5104 . 5105) nil (5103 . 5104) nil (5102 . 5103) nil (5182 . 5183) nil (5182 . 5183) nil (5182 . 5183) nil (#("/*
(c) Copyrights 2007 - 2008

Original idea by by Binny V A, http://www.openjs.com/scripts/events/keyboard_shortcuts/
 
jQuery Plugin by Tzury Bar Yochay 
tzury.by@gmail.com
http://evalinux.wordpress.com
http://facebook.com/profile.php?id=513676303

Project's sites: 
http://code.google.com/p/js-hotkeys/
http://github.com/tzuryby/hotkeys/tree/master

License: same as jQuery license. 

USAGE:
    // simple usage
    $(document).bind('keydown', 'Ctrl+c', function(){ alert('copy anyone?');});
    
    // special options such as disableInIput
    $(document).bind('keydown', {combi:'Ctrl+x', disableInInput: true} , function() {});
    
Note:
    This plugin wraps the following jQuery methods: $.fn.find, $.fn.bind and $.fn.unbind
*/

(function (jQuery){
    // keep reference to the original $.fn.bind, $.fn.unbind and $.fn.find
    jQuery.fn.__bind__ = jQuery.fn.bind;
    jQuery.fn.__unbind__ = jQuery.fn.unbind;
    jQuery.fn.__find__ = jQuery.fn.find;
    
    var hotkeys = {
        version: '0.7.9',
        override: /keypress|keydown|keyup/g,
        triggersMap: {},
        
        specialKeys: { 27: 'esc', 9: 'tab', 32:'space', 13: 'return', 8:'backspace', 145: 'scroll', 
            20: 'capslock', 144: 'numlock', 19:'pause', 45:'insert', 36:'home', 46:'del',
            35:'end', 33: 'pageup', 34:'pagedown', 37:'left', 38:'up', 39:'right',40:'down', 
            109: '-', 
            112:'f1',113:'f2', 114:'f3', 115:'f4', 116:'f5', 117:'f6', 118:'f7', 119:'f8', 
            120:'f9', 121:'f10', 122:'f11', 123:'f12', 191: '/'},
        
        shiftNums: { \"`\":\"~\", \"1\":\"!\", \"2\":\"@\", \"3\":\"#\", \"4\":\"$\", \"5\":\"%\", \"6\":\"^\", \"7\":\"&\", 
            \"8\":\"*\", \"9\":\"(\", \"0\":\")\", \"-\":\"_\", \"=\":\"+\", \";\":\":\", \"'\":\"\\\"\", \",\":\"<\", 
            \".\":\">\",  \"/\":\"?\",  \"\\\\\":\"|\" },
        
        newTrigger: function (type, combi, callback) { 
            // i.e. {'keyup': {'ctrl': {cb: callback, disableInInput: false}}}
            var result = {};
            result[type] = {};
            result[type][combi] = {cb: callback, disableInInput: false};
            return result;
        }
    };
    // add firefox num pad char codes
    //if (jQuery.browser.mozilla){
    // add num pad char codes
    hotkeys.specialKeys = jQuery.extend(hotkeys.specialKeys, { 96: '0', 97:'1', 98: '2', 99: 
        '3', 100: '4', 101: '5', 102: '6', 103: '7', 104: '8', 105: '9', 106: '*', 
        107: '+', 109: '-', 110: '.', 111 : '/'
        });
    //}
    
    // a wrapper around of $.fn.find 
    // see more at: http://groups.google.com/group/jquery-en/browse_thread/thread/18f9825e8d22f18d
    jQuery.fn.find = function( selector ) {
        this.query = selector;
        return jQuery.fn.__find__.apply(this, arguments);
	};
    
    jQuery.fn.unbind = function (type, combi, fn){
        if (jQuery.isFunction(combi)){
            fn = combi;
            combi = null;
        }
        if (combi && typeof combi === 'string'){
            var selectorId = ((this.prevObject && this.prevObject.query) || (this[0].id && this[0].id) || this[0]).toString();
            var hkTypes = type.split(' ');
            for (var x=0; x<hkTypes.length; x++){
                delete hotkeys.triggersMap[selectorId][hkTypes[x]][combi];
            }
        }
        // call jQuery original unbind
        return  this.__unbind__(type, fn);
    };
    
    jQuery.fn.bind = function(type, data, fn){
        // grab keyup,keydown,keypress
        var handle = type.match(hotkeys.override);
        
        if (jQuery.isFunction(data) || !handle){
            // call jQuery.bind only
            return this.__bind__(type, data, fn);
        }
        else{
            // split the job
            var result = null,            
            // pass the rest to the original $.fn.bind
            pass2jq = jQuery.trim(type.replace(hotkeys.override, ''));
            
            // see if there are other types, pass them to the original $.fn.bind
            if (pass2jq){
                result = this.__bind__(pass2jq, data, fn);
            }            
            
            if (typeof data === \"string\"){
                data = {'combi': data};
            }
            if(data.combi){
                for (var x=0; x < handle.length; x++){
                    var eventType = handle[x];
                    var combi = data.combi.toLowerCase(),
                        trigger = hotkeys.newTrigger(eventType, combi, fn),
                        selectorId = ((this.prevObject && this.prevObject.query) || (this[0].id && this[0].id) || this[0]).toString();
                        
                    //trigger[eventType][combi].propagate = data.propagate;
                    trigger[eventType][combi].disableInInput = data.disableInInput;
                    
                    // first time selector is bounded
                    if (!hotkeys.triggersMap[selectorId]) {
                        hotkeys.triggersMap[selectorId] = trigger;
                    }
                    // first time selector is bounded with this type
                    else if (!hotkeys.triggersMap[selectorId][eventType]) {
                        hotkeys.triggersMap[selectorId][eventType] = trigger[eventType];
                    }
                    // make trigger point as array so more than one handler can be bound
                    var mapPoint = hotkeys.triggersMap[selectorId][eventType][combi];
                    if (!mapPoint){
                        hotkeys.triggersMap[selectorId][eventType][combi] = [trigger[eventType][combi]];
                    }
                    else if (mapPoint.constructor !== Array){
                        hotkeys.triggersMap[selectorId][eventType][combi] = [mapPoint];
                    }
                    else {
                        hotkeys.triggersMap[selectorId][eventType][combi][mapPoint.length] = trigger[eventType][combi];
                    }
                    
                    // add attribute and call $.event.add per matched element
                    this.each(function(){
                        // jQuery wrapper for the current element
                        var jqElem = jQuery(this);
                        
                        // element already associated with another collection
                        if (jqElem.attr('hkId') && jqElem.attr('hkId') !== selectorId){
                            selectorId = jqElem.attr('hkId') + \";\" + selectorId;
                        }
                        jqElem.attr('hkId', selectorId);
                    });
                    result = this.__bind__(handle.join(' '), data, hotkeys.handler)
                }
            }
            return result;
        }
    };
    // work-around for opera and safari where (sometimes) the target is the element which was last 
    // clicked with the mouse and not the document event it would make sense to get the document
    hotkeys.findElement = function (elem){
        if (!jQuery(elem).attr('hkId')){
            if (jQuery.browser.opera || jQuery.browser.safari){
                while (!jQuery(elem).attr('hkId') && elem.parentNode){
                    elem = elem.parentNode;
                }
            }
        }
        return elem;
    };
    // the event handler
    hotkeys.handler = function(event) {
        var target = hotkeys.findElement(event.currentTarget), 
            jTarget = jQuery(target),
            ids = jTarget.attr('hkId');
        
        if(ids){
            ids = ids.split(';');
            var code = event.which,
                type = event.type,
                special = hotkeys.specialKeys[code],
                // prevent f5 overlapping with 't' (or f4 with 's', etc.)
                character = !special && String.fromCharCode(code).toLowerCase(),
                shift = event.shiftKey,
                ctrl = event.ctrlKey,            
                // patch for jquery 1.2.5 && 1.2.6 see more at:  
                // http://groups.google.com/group/jquery-en/browse_thread/thread/83e10b3bb1f1c32b
                alt = event.altKey || event.originalEvent.altKey,
                mapPoint = null;

            for (var x=0; x < ids.length; x++){
                if (hotkeys.triggersMap[ids[x]][type]){
                    mapPoint = hotkeys.triggersMap[ids[x]][type];
                    break;
                }
            }
            
            //find by: id.type.combi.options            
            if (mapPoint){ 
                var trigger;
                // event type is associated with the hkId
                if(!shift && !ctrl && !alt) { // No Modifiers
                    trigger = mapPoint[special] ||  (character && mapPoint[character]);
                }
                else{
                    // check combinations (alt|ctrl|shift+anything)
                    var modif = '';
                    if(alt) modif +='alt+';
                    if(ctrl) modif+= 'ctrl+';
                    if(shift) modif += 'shift+';
                    // modifiers + special keys or modifiers + character or modifiers + shift character or just shift character
                    trigger = mapPoint[modif+special];
                    if (!trigger){
                        if (character){
                            trigger = mapPoint[modif+character] 
                                || mapPoint[modif+hotkeys.shiftNums[character]]
                                // '$' can be triggered as 'Shift+4' or 'Shift+$' or just '$'
                                || (modif === 'shift+' && mapPoint[hotkeys.shiftNums[character]]);
                        }
                    }
                }
                if (trigger){
                    var result = false;
                    for (var x=0; x < trigger.length; x++){
                        if(trigger[x].disableInInput){
                            // double check event.currentTarget and event.target
                            var elem = jQuery(event.target);
                            if (jTarget.is(\"input\") || jTarget.is(\"textarea\") || jTarget.is(\"select\") 
                                || elem.is(\"input\") || elem.is(\"textarea\") || elem.is(\"select\")) {
                                return true;
                            }
                        }                       
                        // call the registered callback function
                        result = result || trigger[x].cb.apply(this, [event]);
                    }
                    return result;
                }
            }
        }
    };
    // place it under window so it can be extended and overridden by others
    window.hotkeys = hotkeys;
    return jQuery;
})(jQuery);
" 0 2 (fontified t face font-lock-comment-delimiter-face) 2 495 (fontified t face font-lock-comment-face) 495 10693 (fontified nil)) . 6190) ((marker . 5783) . -175) ((marker . 5783) . -175) ((marker . 5750) . -205) ((marker . 5750) . -205) ((marker . 5690) . -250) ((marker . 5690) . -250) ((marker . 5270) . -415) ((marker . 5270) . -415) ((marker . 5325) . -395) ((marker . 5325) . -395) ((marker . 5348) . -388) ((marker . 5348) . -388) ((marker . 5428) . -387) ((marker . 5428) . -387) ((marker . 5450) . -353) ((marker . 5450) . -353) ((marker . 5489) . -352) ((marker . 5489) . -352) ((marker . 5525) . -306) ((marker . 5525) . -306) ((marker . 5568) . -269) ((marker . 5568) . -269) ((marker . 5617) . -251) ((marker . 5617) . -251) ((marker . 5815) . -156) ((marker . 5815) . -156) ((marker . 5832) . -121) ((marker . 5832) . -121) ((marker . 5908) . -119) ((marker . 5908) . -119) ((marker . 5937) . -31) ((marker . 5937) . -31) ((marker . 5991) . -30) ((marker . 5991) . -30) ((marker . 6019) . -3) ((marker . 6019) . -3) ((marker . 6196) . -10693) ((marker . 6196) . -10693) nil (6190 . 16883) nil (#("/*" 0 1 (fontified t face font-lock-comment-delimiter-face) 1 2 (fontified t face font-lock-comment-delimiter-face)) . 5422) nil (#(" " 0 1 (fontified t face font-lock-comment-face)) . 6220) nil (5422 . 5423) nil (5422 . 5423) nil (#("/_" 0 1 (fontified t) 1 2 (fontified t)) . 5519) nil (5520 . 5521) nil (5519 . 5520) nil (#("/*" 0 2 (fontified t face font-lock-comment-delimiter-face)) . 5519) nil (#(" */" 0 3 (fontified t face font-lock-comment-face)) . 6150) nil (#("
" 0 1 (fontified t face font-lock-comment-face)) . 5518) ((marker . 5234) . -1) ((marker . 5234) . -1) ((marker) . -1) ((marker) . -1) nil (#("        " 0 8 (fontified t)) . 5519) ((marker) . -8) ((marker) . -8) nil (#("document.execCommand" 0 20 (fontified t)) . 5527) ((marker) . -20) ((marker) . -20) nil (#("('insertBro" 0 1 (fontified t) 1 10 (fontified t face font-lock-string-face) 10 11 (fontified t face font-lock-string-face)) . 5547) ((marker*) . 1) ((marker) . -10) ((marker*) . 11) ((marker) . -1) nil (5557 . 5558) nil (#("OnReturn'" 0 9 (fontified t face font-lock-string-face)) . 5557) ((marker) . -9) nil (#(")" 0 1 (fontified t)) . 5566) ((marker*) . 1) ((marker) . -1) nil (5566 . 5567) nil (#(", flas" 0 2 (fontified t) 2 3 (fontified t) 3 4 (fontified t) 4 5 (fontified t) 5 6 (fontified t)) . 5566) nil (5571 . 5572) nil (5570 . 5571) nil (5569 . 5570) nil (#("asle" 0 1 (fontified t) 1 2 (fontified t) 2 3 (fontified t) 3 4 (fontified t)) . 5569) nil (5572 . 5573) nil (5571 . 5572) nil (5570 . 5571) nil (#("lse" 0 3 (fontified t face font-lock-constant-face)) . 5570) nil (#(", 'true'" 0 2 (fontified t) 2 3 (fontified t face font-lock-string-face) 3 7 (fontified t face font-lock-string-face) 7 8 (fontified t face font-lock-string-face)) . 5573) nil (#(")" 0 1 (fontified t)) . 5581) nil (#(";" 0 1 (fontified t)) . 5582) nil (#("/*" 0 2 (fontified t face font-lock-comment-delimiter-face)) . 6342) nil (#("*/" 0 2 (fontified t face font-lock-comment-face)) . 6583) nil (#("
" 0 1 (fontified t)) . 6228) ((marker . 4915) . -1) ((marker . 4915) . -1) nil (#("      " 0 6 (fontified t)) . 6229) nil (6225 . 6227) nil (6219 . 6226) nil (6219 . 6220) nil (6219 . 6226) nil (5576 . 5580) nil (#("false" 0 5 (fontified t face font-lock-string-face)) . 5576) (t 20623 . 16699) nil (5576 . 5581) nil (#("true" 0 4 (fontified t face font-lock-string-face)) . 5576) (t 20623 . 16662) nil (#("      
" 0 7 (fontified t)) . 6219) ((marker . 5348) . -7) ((marker . 5348) . -7) nil (#("
" 0 1 (fontified t)) . 6219) ((marker . 4915) . -1) ((marker . 4915) . -1) nil (#("      }" 0 7 (fontified t)) . 6219) nil (#("  " 0 2 (fontified t)) . -6225) 6228 nil (6229 . 6235) nil (6228 . 6229) nil (6583 . 6585) nil (6342 . 6344) (t 20623 . 16579) nil (5582 . 5583) nil (5581 . 5582) nil (5573 . 5581) nil (5570 . 5573) nil (#("s" 0 1 (fontified t)) . -5570) nil (#("l" 0 1 (fontified t)) . -5571) nil (#("e" 0 1 (fontified t)) . -5572) nil (5569 . 5573) nil (#("l" 0 1 (fontified t)) . -5569) nil (#("a" 0 1 (fontified t)) . -5570) nil (#("s" 0 1 (fontified t)) . -5571) nil (5566 . 5572) nil (#(")" 0 1 (fontified t)) . -5566) ((marker*) . 1) ((marker) . -1) nil (5566 . 5567) nil (5557 . 5566) nil (#("o" 0 1 (fontified t face font-lock-string-face)) . -5557) nil (5547 . 5558) nil (5527 . 5547) nil (5519 . 5527) nil (5518 . 5519) nil (6150 . 6153) nil (5519 . 5521) nil (#("/" 0 1 (fontified t)) . -5519) nil (#("_" 0 1 (fontified t)) . -5520) nil (5519 . 5521) nil (#("*" 0 1 (fontified t)) . 5422) nil (#("/" 0 1 (fontified t face font-lock-comment-delimiter-face)) . 5422) nil (6220 . 6221) nil (5422 . 5424) nil (#("/*
(c) Copyrights 2007 - 2008

Original idea by by Binny V A, http://www.openjs.com/scripts/events/keyboard_shortcuts/
 
jQuery Plugin by Tzury Bar Yochay 
tzury.by@gmail.com
http://evalinux.wordpress.com
http://facebook.com/profile.php?id=513676303

Project's sites: 
http://code.google.com/p/js-hotkeys/
http://github.com/tzuryby/hotkeys/tree/master

License: same as jQuery license. 

USAGE:
    // simple usage
    $(document).bind('keydown', 'Ctrl+c', function(){ alert('copy anyone?');});
    
    // special options such as disableInIput
    $(document).bind('keydown', {combi:'Ctrl+x', disableInInput: true} , function() {});
    
Note:
    This plugin wraps the following jQuery methods: $.fn.find, $.fn.bind and $.fn.unbind
*/

(function (jQuery){
    // keep reference to the original $.fn.bind, $.fn.unbind and $.fn.find
    jQuery.fn.__bind__ = jQuery.fn.bind;
    jQuery.fn.__unbind__ = jQuery.fn.unbind;
    jQuery.fn.__find__ = jQuery.fn.find;
    
    var hotkeys = {
        version: '0.7.9',
        override: /keypress|keydown|keyup/g,
        triggersMap: {},
        
        specialKeys: { 27: 'esc', 9: 'tab', 32:'space', 13: 'return', 8:'backspace', 145: 'scroll', 
            20: 'capslock', 144: 'numlock', 19:'pause', 45:'insert', 36:'home', 46:'del',
            35:'end', 33: 'pageup', 34:'pagedown', 37:'left', 38:'up', 39:'right',40:'down', 
            109: '-', 
            112:'f1',113:'f2', 114:'f3', 115:'f4', 116:'f5', 117:'f6', 118:'f7', 119:'f8', 
            120:'f9', 121:'f10', 122:'f11', 123:'f12', 191: '/'},
        
        shiftNums: { \"`\":\"~\", \"1\":\"!\", \"2\":\"@\", \"3\":\"#\", \"4\":\"$\", \"5\":\"%\", \"6\":\"^\", \"7\":\"&\", 
            \"8\":\"*\", \"9\":\"(\", \"0\":\")\", \"-\":\"_\", \"=\":\"+\", \";\":\":\", \"'\":\"\\\"\", \",\":\"<\", 
            \".\":\">\",  \"/\":\"?\",  \"\\\\\":\"|\" },
        
        newTrigger: function (type, combi, callback) { 
            // i.e. {'keyup': {'ctrl': {cb: callback, disableInInput: false}}}
            var result = {};
            result[type] = {};
            result[type][combi] = {cb: callback, disableInInput: false};
            return result;
        }
    };
    // add firefox num pad char codes
    //if (jQuery.browser.mozilla){
    // add num pad char codes
    hotkeys.specialKeys = jQuery.extend(hotkeys.specialKeys, { 96: '0', 97:'1', 98: '2', 99: 
        '3', 100: '4', 101: '5', 102: '6', 103: '7', 104: '8', 105: '9', 106: '*', 
        107: '+', 109: '-', 110: '.', 111 : '/'
        });
    //}
    
    // a wrapper around of $.fn.find 
    // see more at: http://groups.google.com/group/jquery-en/browse_thread/thread/18f9825e8d22f18d
    jQuery.fn.find = function( selector ) {
        this.query = selector;
        return jQuery.fn.__find__.apply(this, arguments);
	};
    
    jQuery.fn.unbind = function (type, combi, fn){
        if (jQuery.isFunction(combi)){
            fn = combi;
            combi = null;
        }
        if (combi && typeof combi === 'string'){
            var selectorId = ((this.prevObject && this.prevObject.query) || (this[0].id && this[0].id) || this[0]).toString();
            var hkTypes = type.split(' ');
            for (var x=0; x<hkTypes.length; x++){
                delete hotkeys.triggersMap[selectorId][hkTypes[x]][combi];
            }
        }
        // call jQuery original unbind
        return  this.__unbind__(type, fn);
    };
    
    jQuery.fn.bind = function(type, data, fn){
        // grab keyup,keydown,keypress
        var handle = type.match(hotkeys.override);
        
        if (jQuery.isFunction(data) || !handle){
            // call jQuery.bind only
            return this.__bind__(type, data, fn);
        }
        else{
            // split the job
            var result = null,            
            // pass the rest to the original $.fn.bind
            pass2jq = jQuery.trim(type.replace(hotkeys.override, ''));
            
            // see if there are other types, pass them to the original $.fn.bind
            if (pass2jq){
                result = this.__bind__(pass2jq, data, fn);
            }            
            
            if (typeof data === \"string\"){
                data = {'combi': data};
            }
            if(data.combi){
                for (var x=0; x < handle.length; x++){
                    var eventType = handle[x];
                    var combi = data.combi.toLowerCase(),
                        trigger = hotkeys.newTrigger(eventType, combi, fn),
                        selectorId = ((this.prevObject && this.prevObject.query) || (this[0].id && this[0].id) || this[0]).toString();
                        
                    //trigger[eventType][combi].propagate = data.propagate;
                    trigger[eventType][combi].disableInInput = data.disableInInput;
                    
                    // first time selector is bounded
                    if (!hotkeys.triggersMap[selectorId]) {
                        hotkeys.triggersMap[selectorId] = trigger;
                    }
                    // first time selector is bounded with this type
                    else if (!hotkeys.triggersMap[selectorId][eventType]) {
                        hotkeys.triggersMap[selectorId][eventType] = trigger[eventType];
                    }
                    // make trigger point as array so more than one handler can be bound
                    var mapPoint = hotkeys.triggersMap[selectorId][eventType][combi];
                    if (!mapPoint){
                        hotkeys.triggersMap[selectorId][eventType][combi] = [trigger[eventType][combi]];
                    }
                    else if (mapPoint.constructor !== Array){
                        hotkeys.triggersMap[selectorId][eventType][combi] = [mapPoint];
                    }
                    else {
                        hotkeys.triggersMap[selectorId][eventType][combi][mapPoint.length] = trigger[eventType][combi];
                    }
                    
                    // add attribute and call $.event.add per matched element
                    this.each(function(){
                        // jQuery wrapper for the current element
                        var jqElem = jQuery(this);
                        
                        // element already associated with another collection
                        if (jqElem.attr('hkId') && jqElem.attr('hkId') !== selectorId){
                            selectorId = jqElem.attr('hkId') + \";\" + selectorId;
                        }
                        jqElem.attr('hkId', selectorId);
                    });
                    result = this.__bind__(handle.join(' '), data, hotkeys.handler)
                }
            }
            return result;
        }
    };
    // work-around for opera and safari where (sometimes) the target is the element which was last 
    // clicked with the mouse and not the document event it would make sense to get the document
    hotkeys.findElement = function (elem){
        if (!jQuery(elem).attr('hkId')){
            if (jQuery.browser.opera || jQuery.browser.safari){
                while (!jQuery(elem).attr('hkId') && elem.parentNode){
                    elem = elem.parentNode;
                }
            }
        }
        return elem;
    };
    // the event handler
    hotkeys.handler = function(event) {
        var target = hotkeys.findElement(event.currentTarget), 
            jTarget = jQuery(target),
            ids = jTarget.attr('hkId');
        
        if(ids){
            ids = ids.split(';');
            var code = event.which,
                type = event.type,
                special = hotkeys.specialKeys[code],
                // prevent f5 overlapping with 't' (or f4 with 's', etc.)
                character = !special && String.fromCharCode(code).toLowerCase(),
                shift = event.shiftKey,
                ctrl = event.ctrlKey,            
                // patch for jquery 1.2.5 && 1.2.6 see more at:  
                // http://groups.google.com/group/jquery-en/browse_thread/thread/83e10b3bb1f1c32b
                alt = event.altKey || event.originalEvent.altKey,
                mapPoint = null;

            for (var x=0; x < ids.length; x++){
                if (hotkeys.triggersMap[ids[x]][type]){
                    mapPoint = hotkeys.triggersMap[ids[x]][type];
                    break;
                }
            }
            
            //find by: id.type.combi.options            
            if (mapPoint){ 
                var trigger;
                // event type is associated with the hkId
                if(!shift && !ctrl && !alt) { // No Modifiers
                    trigger = mapPoint[special] ||  (character && mapPoint[character]);
                }
                else{
                    // check combinations (alt|ctrl|shift+anything)
                    var modif = '';
                    if(alt) modif +='alt+';
                    if(ctrl) modif+= 'ctrl+';
                    if(shift) modif += 'shift+';
                    // modifiers + special keys or modifiers + character or modifiers + shift character or just shift character
                    trigger = mapPoint[modif+special];
                    if (!trigger){
                        if (character){
                            trigger = mapPoint[modif+character] 
                                || mapPoint[modif+hotkeys.shiftNums[character]]
                                // '$' can be triggered as 'Shift+4' or 'Shift+$' or just '$'
                                || (modif === 'shift+' && mapPoint[hotkeys.shiftNums[character]]);
                        }
                    }
                }
                if (trigger){
                    var result = false;
                    for (var x=0; x < trigger.length; x++){
                        if(trigger[x].disableInInput){
                            // double check event.currentTarget and event.target
                            var elem = jQuery(event.target);
                            if (jTarget.is(\"input\") || jTarget.is(\"textarea\") || jTarget.is(\"select\") 
                                || elem.is(\"input\") || elem.is(\"textarea\") || elem.is(\"select\")) {
                                return true;
                            }
                        }                       
                        // call the registered callback function
                        result = result || trigger[x].cb.apply(this, [event]);
                    }
                    return result;
                }
            }
        }
    };
    // place it under window so it can be extended and overridden by others
    window.hotkeys = hotkeys;
    return jQuery;
})(jQuery);
" 0 2 (fontified t face font-lock-comment-delimiter-face) 2 495 (fontified t face font-lock-comment-face)) . 6190) ((marker . 5270) . -250) ((marker . 5270) . -250) ((marker . 5325) . -205) ((marker . 5325) . -205) ((marker . 5348) . -175) ((marker . 5348) . -175) ((marker . 5428) . -156) ((marker . 5428) . -156) ((marker . 5450) . -121) ((marker . 5450) . -121) ((marker . 5489) . -119) ((marker . 5489) . -119) ((marker . 5525) . -31) ((marker . 5525) . -31) ((marker . 5568) . -30) ((marker . 5568) . -30) ((marker . 5617) . -3) ((marker . 5617) . -3) ((marker . 6196) . -10693) ((marker . 6196) . -10693) nil (6190 . 16883) nil (#(" " 0 1 (fontified t)) . 5182) nil (#("/" 0 1 (fontified t)) . 5182) nil (#("/" 0 1 (fontified t face font-lock-comment-delimiter-face)) . 5182) nil (#("/" 0 1 (fontified t)) . -5102) ((marker . 6528) . -1) nil (#("/" 0 1 (fontified t face font-lock-comment-delimiter-face)) . -5103) ((marker . 6528) . -1) nil (#(" " 0 1 (fontified t face font-lock-comment-delimiter-face)) . -5104) ((marker . 6528) . -1) nil (#(" " 0 1 (fontified t)) . -1137) 1137 nil (#("else" 0 4 (fontified t face font-lock-keyword-face)) . 1137) nil (#("
" 0 1 (fontified t)) . 1129) ((marker . 5815) . -1) ((marker . 5815) . -1) nil (#("          return true;" 0 10 (fontified t) 10 16 (fontified t face font-lock-keyword-face) 16 17 (fontified t) 17 21 (fontified t face font-lock-constant-face) 21 22 (fontified t)) . 1129) nil (#("
" 0 1 (fontified t)) . 1129) ((marker) . -1) ((marker) . -1) nil (#("          element.getAttribute('class') === classname) " 0 31 (fontified t) 31 38 (fontified t face font-lock-string-face) 38 53 (fontified t) 53 54 (fontified t js--pend (nil 4 function 932 t 1159)) 54 55 (fontified t)) . 1129) nil (#("
" 0 1 (fontified t)) . 1129) ((marker . 5815) . -1) ((marker . 5815) . -1) nil (1127 . 1128) nil (1116 . 1127) nil (1102 . 1116) nil (1101 . 1102) nil (1100 . 1101) nil (1086 . 1100) nil (1085 . 1086) nil (1065 . 1085) nil (1062 . 1065) nil (1050 . 1062) nil (#(" " 0 1 (fontified t)) . -1049) nil (1049 . 1050) nil (1048 . 1049) nil (1043 . 1048) nil (1027 . 1043) nil (#("C" 0 1 (fontified t)) . -1027) nil (1013 . 1028) nil (1003 . 1013) nil (999 . 1003) nil (#("o" 0 1 (fontified t)) . -999) nil (#("f" 0 1 (fontified t)) . -1000) nil (#("r" 0 1 (fontified t)) . -1001) nil (999 . 1002) nil (989 . 999) nil (#("          var classlist = element.classList" 0 10 (fontified t) 10 13 (fontified t face font-lock-keyword-face) 13 14 (fontified t) 14 23 (fontified t face font-lock-variable-name-face) 23 34 (fontified t) 34 43 (fontified t)) . 989) nil (1015 . 1032) nil (#("l" 0 1 (fontified t)) . -1015) nil (#("e" 0 1 (fontified t)) . -1016) nil (999 . 1017) nil (989 . 999) nil (990 . 991) nil (989 . 990) nil (988 . 989) nil (989 . 999) nil (988 . 989) nil (987 . 988) nil (#(" " 0 1 (fontified t)) . -987) nil (#("&" 0 1 (fontified t)) . -988) nil (#("&" 0 1 (fontified t)) . -989) nil (#(" " 0 1 (fontified t)) . -990) nil (1115 . 1122) nil (1143 . 1144) nil (1142 . 1143) nil (1134 . 1142) nil (1133 . 1134) nil (1123 . 1133) nil (1115 . 1123) nil (1109 . 1115) nil (1108 . 1109) nil (1102 . 1108) nil (#("  " 0 2 (fontified nil)) . -1101) (1103 . 1104) nil (1097 . 1103) nil (1096 . 1097) nil (1092 . 1094) 1088 nil (#("      
" 0 6 (fontified t) 6 7 (fontified t)) . 1088) ((marker) . -7) ((marker) . -7) nil (1086 . 1087) nil (#("}" 0 1 (fontified t js--pend (nil 4 function 932 t 1159))) . -1093) ((marker*) . 1) ((marker) . -1) nil (1072 . 1073) (#("         " 0 1 (fontified nil) 1 9 (fontified nil)) . 1072) ((marker) . -1) ((marker) . -1) (#("
" 0 1 (fontified t)) . -1073) 1087 ((marker) . -1) ((marker) . -1) nil (#("{" 0 1 (fontified t)) . -1073) nil (1060 . 1068) (#("      " 0 6 (fontified t)) . 1060) 1066 nil (#("}" 0 1 (fontified t js--pend (nil 4 function 932 t 1159))) . -1066) ((marker*) . 1) ((marker) . -1) nil (#(" " 0 1 (fontified t)) . -1067) nil (1045 . 1047) 1057 nil (#("{" 0 1 (fontified t)) . -1036) nil (953 . 961) (#("      " 0 6 (fontified t)) . 953) 986 nil (923 . 925) 950 nil (917 . 918) nil (916 . 917) nil (915 . 916) nil (895 . 915) nil (#("t" 0 1 (fontified t)) . -895) nil (#("u" 0 1 (fontified t)) . -896) nil (892 . 897) nil (889 . 892) nil (885 . 889) nil (884 . 885) nil (872 . 881) (t 20602 . 30546) nil (3798 . 3799) nil (3797 . 3798) nil (3793 . 3797) nil (#("c" 0 1 (fontified t)) . -3793) nil (3793 . 3794) nil (3784 . 3787) nil (#("log" 0 3 (fontified t)) . 3784) nil (3787 . 3793) nil (3776 . 3787) nil (3772 . 3776) nil (3771 . 3772) (t 20513 . 53427) nil (#("
" 0 1 (fontified t)) . 4192) nil (#("      alert('test2');" 0 12 (fontified t) 12 19 (fontified t face font-lock-string-face) 19 21 (fontified t)) . 4192) nil (#("
" 0 1 (fontified t)) . 4148) nil (#("      alert('test1');" 0 12 (fontified t) 12 19 (fontified t face font-lock-string-face) 19 21 (fontified t)) . 4148) (t 20513 . 53401) nil (2692 . 2693) nil (2691 . 2692) nil (2683 . 2691) nil (2676 . 2683) nil (2675 . 2676) nil (2665 . 2675) nil (2650 . 2665) nil (2644 . 2650) nil (2643 . 2644) nil (2642 . 2643) nil (2641 . 2642) nil (2633 . 2641) nil (2626 . 2633) nil (2625 . 2626) nil (2614 . 2625) nil (2599 . 2614) nil (2593 . 2599) nil (2592 . 2593) nil (#("." 0 1 (fontified t)) . 2273) nil (#(")" 0 1 (fontified t js--pend (((nil 5 function 1995 ("callback") 2033)) 3 function 1908 ("open") 2566))) . 2273) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 2273) nil (#("k" 0 1 (fontified t)) . 2273) nil (#("c" 0 1 (fontified t)) . 2273) nil (#("i" 0 1 (fontified t)) . 2273) nil (#("l" 0 1 (fontified t)) . 2273) nil (#("c" 0 1 (fontified t)) . 2273) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 2273) nil (#("(" 0 1 (fontified t)) . 2273) nil (#("unbind" 0 6 (fontified t)) . 2273) nil (2288 . 2289) nil (2287 . 2288) nil (#("9" 0 1 (fontified t)) . -2287) nil (#("." 0 1 (fontified t)) . -2288) nil (2279 . 2289) nil (2273 . 2279) (t 20513 . 53204) nil (4133 . 4134) nil (4132 . 4133) nil (4124 . 4132) nil (4119 . 4124) nil (4113 . 4119) nil (4112 . 4113) nil (4067 . 4068) nil (4066 . 4067) nil (4058 . 4066) nil (4053 . 4058) nil (#("l" 0 1 (fontified t)) . -4053) nil (#("a" 0 1 (fontified t)) . -4054) nil (4053 . 4055) nil (4047 . 4053) nil (4046 . 4047) (t 20513 . 53141) nil (#("a" 0 1 (fontified t face font-lock-string-face)) . -4208) nil (4207 . 4208) (t 20513 . 53102) nil (#("
" 0 1 (fontified t)) . 2293) nil (#("        alert('confirm!');" 0 14 (fontified t) 14 24 (fontified t face font-lock-string-face) 24 26 (fontified t)) . 2293) nil (#("
" 0 1 (fontified t)) . 2499) nil (#("        alert('cancel');" 0 14 (fontified t) 14 22 (fontified t face font-lock-string-face) 22 24 (fontified t)) . 2499) nil (#("
" 0 1 (fontified t)) . 4005) nil (#("      alert('callback');" 0 12 (fontified t) 12 22 (fontified t face font-lock-string-face) 22 24 (fontified t)) . 4005) (t 20513 . 52847) nil (4028 . 4029) nil (4027 . 4028) nil (4022 . 4027) nil (#("a" 0 1 (fontified t face font-lock-string-face)) . -4022) nil (#("b" 0 1 (fontified t face font-lock-string-face)) . -4023) nil (4016 . 4024) nil (4011 . 4016) nil (4005 . 4011) nil (4004 . 4005) nil (#("
" 0 1 (fontified t)) . 4143) nil (#("      alert(reserve.nodeType);" 0 30 (fontified t)) . 4143) nil (#("        
" 0 8 (fontified t) 8 9 (fontified t)) . 4242) nil (#("
" 0 1 (fontified t)) . 4242) nil (4242 . 4251) nil (#("        alert('test');" 0 14 (fontified t) 14 20 (fontified t face font-lock-string-face) 20 22 (fontified t)) . 4242) nil (2522 . 2523) nil (2521 . 2522) nil (2512 . 2521) nil (2507 . 2512) nil (2499 . 2507) nil (2498 . 2499) nil (2318 . 2319) nil (2317 . 2318) nil (2306 . 2317) nil (2301 . 2306) nil (2293 . 2301) nil (2292 . 2293) (t 20513 . 52678) nil (4261 . 4262) nil (#(" " 0 1 (fontified t face font-lock-string-face)) . -4261) (t 20513 . 52478) nil (4211 . 4212) nil (4210 . 4211) nil (4203 . 4210) nil (4198 . 4203) nil (4190 . 4198) nil (4189 . 4190) (t 20513 . 52427) nil (4120 . 4121) nil (4119 . 4120) nil (4102 . 4119) nil (4097 . 4102) nil (4091 . 4097) nil (4090 . 4091) nil (#("
" 0 1 (fontified t)) . -4046) nil (4046 . 4047) (t 20513 . 52067) nil (4134 . 4136) nil (#("
" 0 1 (rear-nonsticky t fontified t)) . 4315) nil (#("      }" 0 6 (fontified t) 6 7 (fontified t js--pend (nil 4 function 3922 ("d" "callback") nil))) . 4315) nil (#("
" 0 1 (fontified t)) . 4315) nil (#("    } else {" 0 4 (fontified t) 4 5 (fontified t js--pend (nil 4 function 3922 ("d" "callback") nil)) 5 6 (fontified t) 6 10 (fontified t face font-lock-keyword-face) 10 12 (fontified t)) . 4315) nil (#("  " 0 2 (fontified t)) . -4319) 4315 nil (#("  " 0 2 (fontified t)) . -4274) 4268 nil (4267 . 4268) nil (4260 . 4266) (4260 . 4261) nil (nil rear-nonsticky nil 4259 . 4260) (nil fontified nil 4259 . 4260) (nil fontified nil 4210 . 4259) (nil fontified nil 4209 . 4210) (nil fontified nil 4207 . 4209) (nil fontified nil 4204 . 4207) (nil fontified nil 4180 . 4204) (nil fontified nil 4177 . 4180) (nil fontified nil 4169 . 4177) (nil fontified nil 4168 . 4169) (nil fontified nil 4165 . 4168) (nil fontified nil 4157 . 4165) (4157 . 4260) nil (#("
" 0 1 (fontified t)) . 4221) nil (#("        reserve.parentNode.appendChild(tempNode);" 0 49 (fontified t)) . 4221) nil (#("
" 0 1 (fontified t)) . 4221) nil (#("        var tempNode = document.createTextNode(' ');" 0 8 (fontified t) 8 11 (fontified t face font-lock-keyword-face) 11 12 (fontified t) 12 20 (fontified t face font-lock-variable-name-face) 20 23 (fontified t) 23 47 (fontified t) 47 50 (fontified t face font-lock-string-face) 50 52 (fontified t)) . 4221) nil (4324 . 4330) (4324 . 4325) nil (4323 . 4324) nil (4322 . 4323) nil (4321 . 4322) nil (4312 . 4321) nil (4311 . 4312) nil (4291 . 4311) nil (#("r" 0 1 (fontified t)) . -4291) nil (4284 . 4292) nil (#("v" 0 1 (fontified t)) . -4284) nil (#("e" 0 1 (fontified t)) . -4285) nil (#("r" 0 1 (fontified t)) . -4286) nil (4282 . 4287) nil (4274 . 4282) nil (#("        $(reverse).after" 0 24 (fontified t)) . 4274) nil (4292 . 4298) nil (4291 . 4292) nil (4283 . 4291) nil (4282 . 4283) nil (4274 . 4282) nil (#("        reverse.parent(" 0 23 (fontified t)) . 4274) nil (4296 . 4297) nil (4295 . 4296) nil (#("d" 0 1 (fontified t)) . -4295) nil (4282 . 4296) nil (4274 . 4282) nil (4273 . 4274) nil (4272 . 4273) nil (4271 . 4272) nil (4269 . 4271) nil (#(" " 0 1 (fontified t face font-lock-string-face)) . -4269) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . -4270) nil (4267 . 4271) nil (4249 . 4267) nil (4229 . 4249) nil (4221 . 4229) nil (4220 . 4221) nil (4219 . 4220) nil (4213 . 4219) nil (#("  " 0 2 (fontified nil)) . -4212) (4214 . 4215) nil (#("e" 0 1 (fontified t)) . -4214) nil (#("l" 0 1 (fontified t)) . -4215) nil (#("s" 0 1 (fontified t)) . -4216) nil (#("e" 0 1 (fontified t face font-lock-keyword-face)) . -4217) nil (4214 . 4218) nil (4206 . 4214) nil (4205 . 4206) nil (4157 . 4165) (#("      " 0 6 (fontified t)) . 4157) 4189 nil (4155 . 4156) nil (4154 . 4155) nil (4153 . 4154) nil (4133 . 4153) nil (4130 . 4133) nil (4124 . 4130) nil (4123 . 4124) (t 20513 . 51584) nil (#("
" 0 1 (fontified t)) . 4524) nil (#("    }" 0 4 (fontified t) 4 5 (fontified t js--pend (((((nil 4 function 3922 ("d" "callback") nil)) nil (:name "[Automatically Generated Class]") nil "d" nil)) 3 function 3621 t nil))) . 4524) nil (#("
" 0 1 (fontified t)) . 4524) nil (#("    function callbackBefore() {" 0 4 (fontified t) 4 12 (fontified t face font-lock-keyword-face) 12 13 (fontified t) 13 27 (fontified t face font-lock-function-name-face) 27 30 (fontified t) 30 31 (fontified t js--pstate ((nil 4 function 4528 ("callbackBefore") nil) (((((nil 4 function 3922 ("d" "callback") nil)) nil (:name "[Automatically Generated Class]") nil "d" nil)) 3 function 3621 t nil) (((nil 3 function 3402 t nil) (nil 3 function 3205 t nil) (nil 3 function 2957 t nil) (nil 3 function 2572 ("close") nil) (((nil 5 function 2458 t nil) (nil 5 function 2279 t nil) (nil 5 function 1995 ("callback") 2033)) 3 function 1908 ("open") 2566) (nil 3 function 1730 ("updateBody") 1814) (nil 3 function 1633 ("updateTitle") 1724) (nil 3 function 1348 ("updateDate") 1627) (((nil 3 function 1112 t 1299)) 2 function 1071 ("isTagName") 1304) (((nil 3 function 887 t 1062)) 2 function 845 ("hasClass") 1067) (nil 2 function 606 ("contains") 841) (nil 2 function 379 ("getMonthName") 602) (nil 2 function 137 ("stripTag") 375)) 1 function 54 t nil) (((nil 1 function 3 t 46)) -2305843009213693952 toplevel nil nil nil)))) . 4524) (t 20513 . 51579) nil (#("
" 0 1 (fontified t)) . 4328) nil (#("        var reserve = $('a[href=\"#reserveLink\"]')[0];" 0 8 (fontified t) 8 11 (fontified t face font-lock-keyword-face) 11 12 (fontified t) 12 19 (fontified t face font-lock-variable-name-face) 19 22 (fontified t) 22 24 (fontified t) 24 25 (fontified t face font-lock-string-face) 25 32 (fontified t face font-lock-string-face) 32 33 (fontified t face font-lock-string-face) 33 45 (fontified t face font-lock-string-face) 45 46 (fontified t face font-lock-string-face) 46 47 (fontified t face font-lock-string-face) 47 48 (fontified t face font-lock-string-face) 48 49 (rear-nonsticky t fontified t) 49 52 (fontified t) 52 53 (rear-nonsticky t fontified t)) . 4328) nil (4563 . 4569) (4563 . 4564) nil (4562 . 4563) nil (4542 . 4550) (#("      " 0 6 (fontified t)) . 4542) 4550 nil (4515 . 4523) (#("      " 0 6 (fontified t)) . 4515) nil (#("
" 0 1 (fontified t)) . 4515) nil (#("      var reserve = $('a[href=\"#reserveLink\"]')[0];" 0 6 (fontified t) 6 9 (fontified t face font-lock-keyword-face) 9 10 (fontified t) 10 17 (fontified t face font-lock-variable-name-face) 17 20 (fontified t) 20 22 (fontified t) 22 23 (fontified t face font-lock-string-face) 23 30 (fontified t face font-lock-string-face) 30 31 (fontified t face font-lock-string-face) 31 43 (fontified t face font-lock-string-face) 43 44 (fontified t face font-lock-string-face) 44 45 (fontified t face font-lock-string-face) 45 46 (fontified t face font-lock-string-face) 46 47 (rear-nonsticky t fontified t) 47 50 (fontified t) 50 51 (rear-nonsticky t fontified t)) . 4515) nil (4491 . 4499) (#("      " 0 6 (fontified t)) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("      callbackBefore();" 0 23 (fontified t)) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("    d.cancel = function () {" 0 15 (fontified t) 15 23 (fontified t face font-lock-keyword-face) 23 27 (fontified t) 27 28 (fontified t js--pstate ((nil 6 function 4495 ("d" "cancel") nil) (nil 4 function 3922 ("d" "callback") nil) (nil 3 function 3621 t nil) (((nil 3 function 3402 t nil) (nil 3 function 3205 t nil) (nil 3 function 2957 t nil) (nil 3 function 2572 ("close") nil) (((nil 5 function 2458 t nil) (nil 5 function 2279 t nil) (nil 5 function 1995 ("callback") 2033)) 3 function 1908 ("open") 2566) (nil 3 function 1730 ("updateBody") 1814) (nil 3 function 1633 ("updateTitle") 1724) (nil 3 function 1348 ("updateDate") 1627) (((nil 3 function 1112 t 1299)) 2 function 1071 ("isTagName") 1304) (((nil 3 function 887 t 1062)) 2 function 845 ("hasClass") 1067) (nil 2 function 606 ("contains") 841) (nil 2 function 379 ("getMonthName") 602) (nil 2 function 137 ("stripTag") 375)) 1 function 54 t nil) (((nil 1 function 3 t 46)) -2305843009213693952 toplevel nil nil nil)))) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("    // ユーザがダイアログをキャンセルした" 0 4 (fontified t) 4 7 (fontified t face font-lock-comment-delimiter-face) 7 24 (fontified t face font-lock-comment-face)) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("    };" 0 4 (fontified t) 4 5 (fontified t) 5 6 (fontified t)) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("      }" 0 7 (fontified t)) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("        return false;" 0 8 (fontified t) 8 14 (fontified t face font-lock-keyword-face) 14 15 (fontified t) 15 20 (fontified t face font-lock-constant-face) 20 21 (fontified t)) . 4491) nil (#("
" 0 1 (fontified t)) . 4491) nil (#("        alert('入力値が不正です!');" 0 14 (fontified t) 14 15 (fontified t face font-lock-string-face) 15 24 (fontified t face font-lock-string-face) 24 25 (fontified t face font-lock-string-face) 25 27 (fontified t)) . 4491) nil (4253 . 4254) nil (4251 . 4253) nil (4237 . 4251) nil (#("{" 0 1 (fontified t)) . -4237) nil (4201 . 4203) nil (#("\"" 0 1 (fontified t face font-lock-string-face)) . -4201) nil (4201 . 4202) nil (#("
" 0 1 (fontified t)) . 4237) nil (#("        callbackBefore();" 0 25 (fontified t)) . 4237) nil (4189 . 4197) (#("      " 0 6 (fontified t)) . 4189) nil (#("
" 0 1 (fontified t)) . 4189) nil (#("
" 0 1 (fontified t)) . 4189) nil (4187 . 4188) nil (4186 . 4187) nil (4185 . 4186) nil (4180 . 4185) nil (4177 . 4180) nil (4171 . 4177) nil (nil fontified nil 4170 . 4171) (nil fontified nil 4124 . 4170) (nil fontified nil 4123 . 4124) (nil fontified nil 4097 . 4123) (nil fontified nil 4091 . 4097) (nil fontified nil 4090 . 4091) (nil fontified nil 4047 . 4090) (nil fontified nil 4046 . 4047) (nil fontified nil 4020 . 4046) (nil fontified nil 4015 . 4020) (nil fontified nil 4014 . 4015) (nil fontified nil 4011 . 4014) (nil fontified nil 4005 . 4011) (nil fontified nil 4004 . 4005) (nil fontified nil 4003 . 4004) (nil fontified nil 4000 . 4003) (nil fontified nil 3999 . 4000) (nil fontified nil 3998 . 3999) (nil fontified nil 3997 . 3998) (nil fontified nil 3983 . 3997) (nil fontified nil 3976 . 3983) (nil fontified nil 3975 . 3976) (nil fontified nil 3973 . 3975) (nil fontified nil 3970 . 3973) (nil fontified nil 3963 . 3970) (nil fontified nil 3962 . 3963) (nil fontified nil 3959 . 3962) (nil fontified nil 3953 . 3959) (3953 . 4171) nil (#("      var reserve = $('a[href=\"#reserveLink\"]')[0];
      var range = document.createRange();
      range.selectNode(reserve.parentNode);
      selection.addRange(range);
      selection.collapse(reserve.nextSibling);
" 0 6 (fontified t) 6 9 (fontified t face font-lock-keyword-face) 9 10 (fontified t) 10 17 (fontified t face font-lock-variable-name-face) 17 20 (fontified t) 20 22 (fontified t) 22 23 (fontified t face font-lock-string-face) 23 30 (fontified t face font-lock-string-face) 30 44 (fontified t face font-lock-string-face) 44 45 (fontified t face font-lock-string-face) 45 46 (fontified t face font-lock-string-face) 46 47 (rear-nonsticky t fontified t) 47 50 (fontified t) 50 51 (rear-nonsticky t fontified t) 51 52 (rear-nonsticky t fontified t) 52 58 (fontified t) 58 61 (fontified t face font-lock-keyword-face) 61 62 (fontified t) 62 67 (fontified t face font-lock-variable-name-face) 67 93 (fontified t) 93 94 (fontified t) 94 137 (fontified t) 137 138 (fontified t) 138 144 (fontified t) 144 170 (fontified t) 170 171 (fontified t) 171 217 (fontified t) 217 218 (rear-nonsticky t fontified t)) . -4564) nil (3954 . 3955) nil (3953 . 3954) nil (3952 . 3953) nil (3945 . 3949) nil (2498 . 2503) (2489 . 2497) nil (#("cancel" 0 6 (fontified t)) . 2489) nil (2366 . 2370) nil (#("
" 0 1 (fontified t)) . 2035) nil (#("        cancel: function () { return true; }" 0 8 (fontified t) 8 14 (fontified t face font-lock-function-name-face) 14 16 (fontified t) 16 24 (fontified t face font-lock-keyword-face) 24 28 (fontified t) 28 29 (fontified t js--pstate ((nil 5 function 2043 ("cancel") 2079) (((nil 5 function 1995 ("callback") 2033)) 3 function 1908 ("open") 2566) (((nil 3 function 1730 ("updateBody") 1814) (nil 3 function 1633 ("updateTitle") 1724) (nil 3 function 1348 ("updateDate") 1627) (((nil 3 function 1112 t 1299)) 2 function 1071 ("isTagName") 1304) (((nil 3 function 887 t 1062)) 2 function 845 ("hasClass") 1067) (nil 2 function 606 ("contains") 841) (nil 2 function 379 ("getMonthName") 602) (nil 2 function 137 ("stripTag") 375)) 1 function 54 t nil) (((nil 1 function 3 t 46)) -2305843009213693952 toplevel nil nil nil))) 29 30 (fontified t) 30 36 (fontified t face font-lock-keyword-face) 36 37 (fontified t) 37 41 (fontified t face font-lock-constant-face) 41 43 (fontified t) 43 44 (fontified t js--pend (nil 5 function 2043 ("cancel") 2079))) . 2035) (t 20513 . 51385) nil (4128 . 4136) (#("      " 0 6 (fontified t)) . 4128) 4179 nil (nil rear-nonsticky nil 4178 . 4179) (nil fontified nil 4175 . 4179) (nil fontified nil 4174 . 4175) (nil fontified nil 4173 . 4174) (nil fontified nil 4172 . 4173) (nil fontified nil 4158 . 4172) (nil fontified nil 4151 . 4158) (nil fontified nil 4150 . 4151) (nil fontified nil 4148 . 4150) (nil fontified nil 4145 . 4148) (nil fontified nil 4138 . 4145) (nil fontified nil 4137 . 4138) (nil fontified nil 4134 . 4137) (nil fontified nil 4128 . 4134) (4128 . 4179) nil (4127 . 4128) nil (nil rear-nonsticky nil 4452 . 4453) (nil fontified nil 4449 . 4453) (nil fontified nil 4448 . 4449) (nil fontified nil 4447 . 4448) (nil fontified nil 4446 . 4447) (nil fontified nil 4432 . 4446) (nil fontified nil 4425 . 4432) (nil fontified nil 4424 . 4425) (nil fontified nil 4422 . 4424) (nil fontified nil 4419 . 4422) (nil fontified nil 4412 . 4419) (nil fontified nil 4411 . 4412) (nil fontified nil 4408 . 4411) (nil fontified nil 4402 . 4408) (4402 . 4453) nil (4401 . 4402) nil (nil rear-nonsticky nil 4535 . 4536) (nil fontified nil 4532 . 4536) (nil fontified nil 4531 . 4532) (nil fontified nil 4530 . 4531) (nil fontified nil 4529 . 4530) (nil fontified nil 4515 . 4529) (nil fontified nil 4508 . 4515) (nil fontified nil 4507 . 4508) (nil fontified nil 4505 . 4507) (nil fontified nil 4502 . 4505) (nil fontified nil 4495 . 4502) (nil fontified nil 4494 . 4495) (nil fontified nil 4491 . 4494) (nil fontified nil 4485 . 4491) (4485 . 4536) nil (#("      var reserve = $('a[href=\"#reserveLink\"]')[0];" 0 6 (fontified t) 6 9 (fontified t face font-lock-keyword-face) 9 10 (fontified t) 10 17 (fontified t face font-lock-variable-name-face) 17 20 (fontified t) 20 22 (fontified t) 22 23 (fontified t face font-lock-string-face) 23 30 (fontified t face font-lock-string-face) 30 44 (fontified t face font-lock-string-face) 44 45 (fontified t face font-lock-string-face) 45 46 (fontified t face font-lock-string-face) 46 47 (rear-nonsticky t fontified t) 47 51 (fontified t)) . 4485) (t 20513 . 51311) nil (4489 . 4491) 4485 nil (nil fontified nil 4534 . 4535) (nil fontified nil 4530 . 4534) (nil fontified nil 4529 . 4530) (nil fontified nil 4528 . 4529) (nil fontified nil 4527 . 4528) (nil fontified nil 4513 . 4527) (nil fontified nil 4506 . 4513) (nil fontified nil 4505 . 4506) (nil fontified nil 4503 . 4505) (nil fontified nil 4500 . 4503) (nil fontified nil 4493 . 4500) (nil fontified nil 4492 . 4493) (nil fontified nil 4489 . 4492) (nil fontified nil 4485 . 4489) (4485 . 4535) nil (#("
" 0 1 (fontified t rear-nonsticky t)) . 3863) nil (#("    var reserve = $('a[href=\"#reserveLink\"]')[0];" 0 4 (fontified t) 4 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 15 (fontified t face font-lock-variable-name-face) 15 18 (fontified t) 18 20 (fontified t) 20 21 (fontified t face font-lock-string-face) 21 28 (fontified t face font-lock-string-face) 28 42 (fontified t face font-lock-string-face) 42 43 (fontified t face font-lock-string-face) 43 44 (fontified t face font-lock-string-face) 44 45 (rear-nonsticky t fontified t) 45 49 (fontified t)) . 3863) nil (#("
" 0 1 (fontified t)) . 4707) nil (#("    funct" 0 9 (fontified t)) . 4707) nil (4711 . 4716) nil (4707 . 4711) nil (4706 . 4707) (t 20513 . 51101) nil (4103 . 4104) nil (4102 . 4103) nil (4101 . 4102) nil (4091 . 4101) nil (#("a" 0 1 (fontified t)) . -4091) nil (#("b" 0 1 (fontified t)) . -4092) nil (4091 . 4093) nil (#("c" 0 1 (fontified t)) . -4091) nil (4090 . 4092) nil (#("a" 0 1 (fontified t)) . -4090) nil (#("b" 0 1 (fontified t)) . -4091) nil (#("a" 0 1 (fontified t)) . -4092) nil (4090 . 4093) nil (#("b" 0 1 (fontified t)) . -4090) nil (#("b" 0 1 (fontified t)) . -4091) nil (4087 . 4092) nil (4079 . 4087) nil (4078 . 4079) (t 20513 . 51064) nil (4168 . 4180) nil (#("attr" 0 4 (fontified t)) . 4168) nil (#("]" 0 1 (fontified t)) . 4185) nil (#("0" 0 1 (fontified t)) . 4185) nil (#("[" 0 1 (fontified t)) . 4185) nil (#(")" 0 1 (fontified t)) . 4167) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 4167) nil (#("]" 0 1 (fontified t)) . 4167) nil (#("\"" 0 1 (fontified t face font-lock-string-face)) . 4167) nil (#("k" 0 1 (fontified t)) . 4167) nil (#("n" 0 1 (fontified t)) . 4167) nil (#("i" 0 1 (fontified t)) . 4167) nil (#("L" 0 1 (fontified t)) . 4167) nil (#("e" 0 1 (fontified t)) . 4167) nil (#("v" 0 1 (fontified t)) . 4167) nil (#("r" 0 1 (fontified t)) . 4167) nil (#("e" 0 1 (fontified t)) . 4167) nil (#("s" 0 1 (fontified t)) . 4167) nil (#("e" 0 1 (fontified t)) . 4167) nil (#("r" 0 1 (fontified t)) . 4167) nil (#("#" 0 1 (fontified t)) . 4167) nil (#("\"" 0 1 (fontified t face font-lock-string-face)) . 4167) nil (#("=" 0 1 (fontified t)) . 4167) nil (#("f" 0 1 (fontified t)) . 4167) nil (#("e" 0 1 (fontified t)) . 4167) nil (#("r" 0 1 (fontified t)) . 4167) nil (#("h" 0 1 (fontified t)) . 4167) nil (#("[" 0 1 (fontified t)) . 4167) nil (#("a" 0 1 (fontified t)) . 4167) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 4167) nil (#("(" 0 1 (fontified t)) . 4167) nil (#("$" 0 1 (fontified t)) . 4167) nil (#(" " 0 1 (fontified t)) . 4167) nil (#("=" 0 1 (fontified t)) . 4167) nil (#(" " 0 1 (fontified t)) . 4167) nil (#("v" 0 1 (fontified t)) . -4160) nil (#("a" 0 1 (fontified t)) . -4161) nil (#("r" 0 1 (fontified t)) . -4162) nil (#(" " 0 1 (fontified t)) . -4163) nil (#("
" 0 1 (rear-nonsticky t fontified t)) . 4224) nil (#("        selection.collapse(reserve.nextSibling);" 0 48 (fontified t)) . 4224) nil (#("
" 0 1 (fontified t)) . 4224) nil (#("        selection.addRange(range);" 0 8 (fontified t) 8 34 (fontified t)) . 4224) nil (#("
" 0 1 (fontified t)) . 4224) nil (#("        range.selectNode(reserve.parentNode);" 0 45 (fontified t)) . 4224) nil (#("
" 0 1 (fontified t)) . 4224) nil (#("        var range = document.createRange();" 0 8 (fontified t) 8 11 (fontified t face font-lock-keyword-face) 11 12 (fontified t) 12 17 (fontified t face font-lock-variable-name-face) 17 43 (fontified t)) . 4224) nil (4605 . 4606) nil (4604 . 4605) nil (4603 . 4604) nil (4597 . 4603) nil (#("b" 0 1 (fontified t)) . -4597) nil (4589 . 4598) nil (4583 . 4589) nil (4582 . 4583) nil (#("
" 0 1 (fontified t)) . 4854) nil (nil fontified nil 4853 . 4854) (nil fontified nil 4807 . 4853) (nil fontified nil 4806 . 4807) (nil fontified nil 4780 . 4806) (nil fontified nil 4774 . 4780) (nil fontified nil 4773 . 4774) (nil fontified nil 4730 . 4773) (nil fontified nil 4729 . 4730) (nil fontified nil 4703 . 4729) (nil fontified nil 4698 . 4703) (nil fontified nil 4697 . 4698) (nil fontified nil 4694 . 4697) (nil fontified nil 4688 . 4694) (4688 . 4854) nil (#("      var range = document.createRange();
      range.selectNode(reserve.parentNode);
      selection.addRange(range);
      selection.collapse(reserve.nextSibling);
" 0 6 (fontified t) 6 9 (fontified t face font-lock-keyword-face) 9 10 (fontified t) 10 15 (fontified t face font-lock-variable-name-face) 15 41 (fontified t) 41 42 (fontified t) 42 85 (fontified t) 85 86 (fontified t) 86 92 (fontified t) 92 118 (fontified t) 118 119 (fontified t) 119 165 (fontified t) 165 166 (rear-nonsticky t fontified t)) . -4605) nil (4855 . 4859) (4855 . 4856) nil (4854 . 4855) nil (4853 . 4854) nil (4852 . 4853) nil (4851 . 4852) nil (4850 . 4851) nil (4849 . 4850) nil (#(" " 0 1 (fontified t)) . -4849) nil (#("(" 0 1 (fontified t)) . -4850) nil (#(")" 0 1 (fontified t)) . -4851) nil (#(" " 0 1 (fontified t)) . -4852) nil (4852 . 4853) nil (4851 . 4852) nil (4850 . 4851) nil (4846 . 4850) nil (4826 . 4846) nil (4822 . 4826) nil (4821 . 4822) nil (#("  " 0 2 (fontified t)) . -3867) 3863 nil (nil rear-nonsticky nil 3914 . 3915) (nil fontified nil 3914 . 3915) (nil fontified nil 3910 . 3914) (nil fontified nil 3909 . 3910) (nil fontified nil 3908 . 3909) (nil fontified nil 3907 . 3908) (nil fontified nil 3893 . 3907) (nil fontified nil 3886 . 3893) (nil fontified nil 3885 . 3886) (nil fontified nil 3883 . 3885) (nil fontified nil 3880 . 3883) (nil fontified nil 3873 . 3880) (nil fontified nil 3872 . 3873) (nil fontified nil 3869 . 3872) (nil fontified nil 3863 . 3869) (3863 . 3915) nil (#("
" 0 1 (fontified t)) . 4555) nil (#("      var reserve = $('a[href=\"#reserveLink\"]')[0];" 0 6 (fontified t) 6 9 (fontified t face font-lock-keyword-face) 9 10 (fontified t) 10 17 (fontified t face font-lock-variable-name-face) 17 20 (fontified t) 20 22 (fontified t) 22 23 (fontified t face font-lock-string-face) 23 30 (fontified t face font-lock-string-face) 30 44 (fontified t face font-lock-string-face) 44 45 (fontified t face font-lock-string-face) 45 46 (fontified t face font-lock-string-face) 46 47 (rear-nonsticky t fontified t) 47 51 (fontified t)) . 4555) (t 20513 . 50896) nil (#("
" 0 1 (fontified t)) . 4773) nil (#("  " 0 2 (fontified t)) . -4732) 4732 nil (#("  " 0 2 (fontified t)) . -4699) 4699 nil (#("  " 0 2 (fontified t)) . -4655) 4655 nil (#("  " 0 2 (fontified t)) . -4613) 4607 nil (nil fontified nil 4780 . 4781) (nil fontified nil 4732 . 4780) (nil fontified nil 4731 . 4732) (nil fontified nil 4705 . 4731) (nil fontified nil 4697 . 4705) (nil fontified nil 4696 . 4697) (nil fontified nil 4651 . 4696) (nil fontified nil 4650 . 4651) (nil fontified nil 4624 . 4650) (nil fontified nil 4619 . 4624) (nil fontified nil 4618 . 4619) (nil fontified nil 4615 . 4618) (nil fontified nil 4607 . 4615) (4607 . 4781) nil (4606 . 4607) (t 20513 . 50862) nil (4216 . 4217) nil (4215 . 4216) nil (4214 . 4215) nil (4209 . 4214) nil (4194 . 4203) nil (4182 . 4200) nil (4174 . 4182) nil (4173 . 4174) (t 20513 . 50813) nil (4289 . 4301) nil (4174 . 4219) nil (4174 . 4175) nil (4174 . 4208) nil (4174 . 4175) (t 20513 . 50691) nil (#("
" 0 1 (fontified t)) . 4174) nil (#("        selection.addRange(range);" 0 8 (fontified t) 8 34 (fontified t)) . 4174) nil (#("
" 0 1 (fontified t)) . 4174) nil (#("        range.selectNode(reserve.parentNode);" 0 45 (fontified t)) . 4174) nil (#("
" 0 1 (fontified t)) . 4174) nil (#("        var range = document.createRange();" 0 8 (fontified t) 8 11 (fontified t face font-lock-keyword-face) 11 12 (fontified t) 12 17 (fontified t face font-lock-variable-name-face) 17 20 (fontified t) 20 43 (fontified t)) . 4174) (t 20513 . 50643) nil (4334 . 4335) nil (4333 . 4334) nil (4326 . 4333) nil (#("s" 0 1 (fontified t)) . -4326) nil (#("e" 0 1 (fontified t)) . -4327) nil (#("r" 0 1 (fontified t)) . -4328) nil (4325 . 4329) nil (#("8" 0 1 (fontified t)) . -4325) nil (#("r" 0 1 (fontified t)) . -4326) nil (#("a" 0 1 (fontified t)) . -4327) nil (4325 . 4328) nil (#("r" 0 1 (fontified t)) . -4325) nil (4310 . 4326) nil (#("c" 0 1 (fontified t)) . -4310) nil (#("t" 0 1 (fontified t)) . -4311) nil (4307 . 4312) nil (4299 . 4307) nil (4298 . 4299) nil (#("
" 0 1 (fontified t)) . 4264) nil (#("        range.setStartAfter(reserve);" 0 8 (fontified t) 8 13 (fontified t) 13 37 (fontified t)) . 4264) (t 20513 . 50587) nil (4243 . 4250) nil (#("range" 0 5 (fontified t)) . 4243) (t 20513 . 50544) nil (4260 . 4261) nil (4259 . 4260) nil (4242 . 4259) nil (4226 . 4242) nil (#("s" 0 1 (fontified t)) . -4226) nil (#("e" 0 1 (fontified t)) . -4227) nil (4226 . 4228) nil (4218 . 4226) nil (4217 . 4218) (t 20513 . 50449) nil (#("
" 0 1 (fontified t)) . 4321) nil (#("        closer();" 0 17 (fontified t)) . 4321) (t 20513 . 50419) nil (4169 . 4172) nil (4121 . 4124) nil (4110 . 4114) nil (#("v" 0 1 (fontified t)) . -4117) nil (4110 . 4118) nil (4239 . 4247) (#("      " 0 6 (fontified t)) . 4239) 4249 nil (4201 . 4209) (#("      " 0 6 (fontified t)) . 4201) 4209 nil (4157 . 4165) (#("      " 0 6 (fontified t)) . 4157) nil (nil rear-nonsticky nil 4267 . 4268) (nil fontified nil 4267 . 4268) (nil fontified nil 4235 . 4267) (nil fontified nil 4234 . 4235) (nil fontified nil 4210 . 4234) (nil fontified nil 4199 . 4210) (nil fontified nil 4198 . 4199) (nil fontified nil 4175 . 4198) (nil fontified nil 4172 . 4175) (nil fontified nil 4167 . 4172) (nil fontified nil 4166 . 4167) (nil fontified nil 4163 . 4166) (nil fontified nil 4157 . 4163) (4157 . 4268) nil (#("
" 0 1 (fontified t)) . 4434) nil (#("      selection.addRange(range);" 0 32 (fontified t)) . 4434) nil (#("
" 0 1 (fontified t)) . 4434) nil (#("      range.setStartAfter(reserve);" 0 11 (fontified t) 11 35 (fontified t)) . 4434) nil (#("
" 0 1 (fontified t)) . 4434) nil (#("      var range = document.createRange();" 0 6 (fontified t) 6 9 (fontified t face font-lock-keyword-face) 9 10 (fontified t) 10 15 (fontified t face font-lock-variable-name-face) 15 18 (fontified t) 18 41 (fontified t)) . 4434) nil (#("a" 0 1 (fontified t)) . -4466) nil (4466 . 4467) (t 20513 . 50290) nil (4543 . 4544) nil (4542 . 4543) nil (4536 . 4542) nil (4518 . 4536) nil (4512 . 4518) nil (4511 . 4512) nil (4474 . 4475) nil (4473 . 4474) nil (4472 . 4473) nil (4452 . 4472) nil (#("c" 0 1 (fontified t)) . -4452) nil (4452 . 4453) nil (#("getSelection().getRangeAt(0);" 0 29 (fontified t)) . 4452) (t 20513 . 48335) nil (#("
" 0 1 (fontified t)) . 4482) nil (#("      alert(range);" 0 19 (fontified t)) . 4482) nil (#("
" 0 1 (fontified t)) . 4434) nil (#("      $('#e_body').focus();" 0 8 (fontified t) 8 17 (fontified t face font-lock-string-face) 17 27 (fontified t)) . 4434) (t 20513 . 48315) nil (4528 . 4529) nil (4527 . 4528) nil (4521 . 4527) nil (4516 . 4521) nil (4510 . 4516) nil (4509 . 4510) (t 20513 . 48281) nil (4508 . 4509) nil (4507 . 4508) nil (4505 . 4507) nil (4494 . 4505) nil (4493 . 4494) nil (4492 . 4493) nil (4488 . 4492) nil (4468 . 4488) nil (4462 . 4468) nil (4461 . 4462) nil (4460 . 4461) nil (4459 . 4460) nil (4458 . 4459) nil (4452 . 4458) nil (4451 . 4452) nil (4441 . 4451) nil (4440 . 4441) nil (4434 . 4440) nil (#("      $('" 0 8 (fontified t) 8 9 (fontified t face font-lock-string-face)) . 4434) nil (4441 . 4443) nil (4440 . 4441) nil (4434 . 4440) nil (4433 . 4434) nil (#("
" 0 1 (fontified t)) . 3705) nil (#("    var range = selection.getRangeAt(0);" 0 4 (fontified t) 4 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 13 (fontified t face font-lock-variable-name-face) 13 40 (fontified t)) . 3705) (t 20513 . 48216) nil (4501 . 4508) nil (#("reverse" 0 7 (fontified t)) . 4501) (t 20513 . 48195) nil (4481 . 4486) nil (#(")" 0 1 (fontified t js--pend (nil 4 function 4376 ("d" "cancel") nil))) . 4481) nil (#("0" 0 1 (fontified t)) . 4481) nil (#("(" 0 1 (fontified t)) . 4481) nil (#("().getRangeAt" 0 13 (fontified t)) . 4481) nil (#("getSelection" 0 12 (fontified t)) . 4481) nil (3744 . 3745) nil (3743 . 3744) nil (3742 . 3743) nil (#(")" 0 1 (fontified t)) . -3742) nil (3742 . 3743) nil (3741 . 3742) nil (3729 . 3741) nil (3709 . 3729) nil (3705 . 3709) nil (3704 . 3705) (t 20513 . 48089) nil (4491 . 4492) nil (4490 . 4491) nil (4482 . 4490) nil (4468 . 4482) nil (4467 . 4468) nil (4465 . 4467) nil (4454 . 4465) nil (4453 . 4454) nil (4452 . 4453) nil (#("." 0 1 (fontified t)) . -4452) nil (4440 . 4453) nil (4434 . 4440) nil (4433 . 4434) nil (#("
" 0 1 (fontified t)) . 4434) nil (#("      $('#e_body p')[0].selectionStart = $('#e_body p')[0].selectionEnd = 5;" 0 8 (fontified t) 8 9 (fontified t face font-lock-string-face) 9 18 (fontified t face font-lock-string-face) 18 19 (fontified t face font-lock-string-face) 19 43 (fontified t) 43 44 (fontified t face font-lock-string-face) 44 53 (fontified t face font-lock-string-face) 53 54 (fontified t face font-lock-string-face) 54 76 (fontified t)) . 4434) nil (#("
" 0 1 (fontified t)) . 4434) nil (#("      $('#e_body p').focus();" 0 8 (fontified t) 8 19 (fontified t face font-lock-string-face) 19 29 (fontified t)) . 4434) (t 20513 . 47342) nil (4515 . 4517) nil (4450 . 4452) nil (4478 . 4480) (t 20513 . 47322) nil (4460 . 4461) nil (4459 . 4460) nil (4458 . 4459) nil (4457 . 4458) nil (#("e" 0 1 (fontified t)) . -4457) nil (4452 . 4458) nil (4451 . 4452) nil (4441 . 4451) nil (4440 . 4441) nil (4434 . 4440) nil (4433 . 4434) (t 20513 . 47300) nil (4505 . 4506) nil (4499 . 4505) nil (#("N" 0 1 (fontified t)) . -4499) nil (4488 . 4500) nil (4485 . 4488) nil (4484 . 4485) nil (4474 . 4484) nil (4455 . 4474) nil (4452 . 4455) nil (#("." 0 1 (fontified t)) . -4452) nil (#("s" 0 1 (fontified t)) . -4453) nil (#("e" 0 1 (fontified t)) . -4454) nil (#("l" 0 1 (fontified t)) . -4455) nil (#("e" 0 1 (fontified t)) . -4456) nil (#("c" 0 1 (fontified t)) . -4457) nil (4452 . 4458) nil (4451 . 4452) nil (4444 . 4451) nil (#("_" 0 1 (fontified t face font-lock-string-face)) . -4444) nil (4443 . 4445) nil (#("e" 0 1 (fontified t face font-lock-string-face)) . -4443) nil (4441 . 4444) nil (4440 . 4441) nil (4434 . 4440) nil (#("      selection.collapse(reserve);" 0 34 (fontified t)) . 4434) (t 20513 . 46167) nil (#("
" 0 1 (fontified t)) . 3617) nil (#("
" 0 1 (fontified t)) . 3617) nil (#("
" 0 1 (fontified t)) . 3617) nil (#("  });" 0 2 (fontified t) 2 3 (fontified t js--pend (((nil 3 function 3436 t nil) (nil 3 function 3239 t nil) (nil 3 function 2991 t nil) (nil 3 function 2606 ("close") nil) (((nil 5 function 2499 t nil) (nil 5 function 2324 t nil) (nil 5 function 2043 ("cancel") 2079) (nil 5 function 1995 ("callback") 2033)) 3 function 1908 ("open") 2566) (nil 3 function 1730 ("updateBody") 1814) (nil 3 function 1633 ("updateTitle") 1724) (nil 3 function 1348 ("updateDate") 1627) (((nil 3 function 1112 t 1299)) 2 function 1071 ("isTagName") 1304) (((nil 3 function 887 t 1062)) 2 function 845 ("hasClass") 1067) (nil 2 function 606 ("contains") 841) (nil 2 function 379 ("getMonthName") 602) (nil 2 function 137 ("stripTag") 375)) 1 function 54 t nil)) 3 5 (fontified t)) . 3617) nil (#("
" 0 1 (fontified t)) . 3617) nil (#("    alert($('#test')[0].selectionStart);" 0 12 (fontified t) 12 19 (fontified t face font-lock-string-face) 19 40 (fontified t)) . 3617) nil (#("
" 0 1 (fontified t)) . 3617) nil (#("  $('#testButton').click(function () {" 0 4 (fontified t) 4 17 (fontified t face font-lock-string-face) 17 25 (fontified t) 25 33 (fontified t face font-lock-keyword-face) 33 37 (fontified t) 37 38 (fontified t js--pstate ((nil 3 function 3642 t nil) (((nil 3 function 3436 t nil) (nil 3 function 3239 t nil) (nil 3 function 2991 t nil) (nil 3 function 2606 ("close") nil) (((nil 5 function 2499 t nil) (nil 5 function 2324 t nil) (nil 5 function 2043 ("cancel") 2079) (nil 5 function 1995 ("callback") 2033)) 3 function 1908 ("open") 2566) (nil 3 function 1730 ("updateBody") 1814) (nil 3 function 1633 ("updateTitle") 1724) (nil 3 function 1348 ("updateDate") 1627) (((nil 3 function 1112 t 1299)) 2 function 1071 ("isTagName") 1304) (((nil 3 function 887 t 1062)) 2 function 845 ("hasClass") 1067) (nil 2 function 606 ("contains") 841) (nil 2 function 379 ("getMonthName") 602) (nil 2 function 137 ("stripTag") 375)) 1 function 54 t nil) (((nil 1 function 3 t 46)) -2305843009213693952 toplevel nil nil nil)))) . 3617) nil (#("
" 0 1 (fontified t)) . 3617) (t 20513 . 46150)))
