
((digest . "7cc37acbd46b3f67e038d8386d434305") (undo-list nil (56 . 62) nil (54 . 56) nil (54 . 55) nil (#("  if ($('#magazine').length) {
    var articles = $('.magazine').get();
    var location = 0;
    var next = $('#next');
    var prev = $('#prev');

    function pagerUpdate(newlocation) {
      if (newlocation <= 0) $(next).hide();
      else $(next).show();
      if (newlocation >= (articles.length - 1)) $(prev).hide();
      else $(prev).show();
    }

    function setLocation(newlocation) {
      $(articles).eq(location).fadeOut('normal', function () {
        pagerUpdate(newlocation);
        $(articles).eq(newlocation).fadeIn('normal');
        location = newlocation;
      });
    }

    $(next).click(function () { setLocation(location - 1); });
    $(prev).click(function () { setLocation(location + 1); });

    $(articles).fadeOut(0);
    setLocation(0);
  }
" 0 2 (fontified t) 2 4 (fontified t face font-lock-keyword-face) 4 8 (fontified t) 8 19 (fontified t face font-lock-string-face) 19 35 (fontified t) 35 38 (fontified t face font-lock-keyword-face) 38 39 (fontified t) 39 47 (fontified t face font-lock-variable-name-face) 47 52 (fontified t) 52 63 (fontified t face font-lock-string-face) 63 76 (fontified t) 76 79 (fontified t face font-lock-keyword-face) 79 80 (fontified t) 80 88 (fontified t face font-lock-variable-name-face) 88 98 (fontified t) 98 101 (fontified t face font-lock-keyword-face) 101 102 (fontified t) 102 106 (fontified t face font-lock-variable-name-face) 106 111 (fontified t) 111 118 (fontified t face font-lock-string-face) 118 125 (fontified t) 125 128 (fontified t face font-lock-keyword-face) 128 129 (fontified t) 129 133 (fontified t face font-lock-variable-name-face) 133 138 (fontified t) 138 145 (fontified t face font-lock-string-face) 145 153 (fontified t) 153 161 (fontified t face font-lock-keyword-face) 161 162 (fontified t) 162 173 (fontified t face font-lock-function-name-face) 173 174 (fontified t) 174 185 (fontified t face font-lock-variable-name-face) 185 187 (fontified t) 187 188 (fontified t js--pstate ((nil 3 function 207 ("pagerUpdate") 410) (nil 1 function 40 t 64) (((nil 1 function 3 t 27)) -2305843009213693952 toplevel nil nil nil))) 188 195 (fontified t) 195 197 (fontified t face font-lock-keyword-face) 197 239 (fontified t) 239 243 (fontified t face font-lock-keyword-face) 243 266 (fontified t) 266 268 (fontified t face font-lock-keyword-face) 268 330 (fontified t) 330 334 (fontified t face font-lock-keyword-face) 334 355 (fontified t) 355 356 (fontified t js--pend (nil 3 function 207 ("pagerUpdate") 410)) 356 362 (fontified t) 362 370 (fontified t face font-lock-keyword-face) 370 371 (fontified t) 371 382 (fontified t face font-lock-function-name-face) 382 383 (fontified t) 383 394 (fontified t face font-lock-variable-name-face) 394 396 (fontified t) 396 397 (fontified t js--pstate ((nil 3 function 416 ("setLocation") 650) (((nil 3 function 207 ("pagerUpdate") 410)) 1 function 40 t 64) (((nil 1 function 3 t 27)) -2305843009213693952 toplevel nil nil nil))) 397 437 (fontified t) 437 445 (fontified t face font-lock-string-face) 445 447 (fontified t) 447 455 (fontified t face font-lock-keyword-face) 455 459 (fontified t) 459 460 (fontified t js--pstate ((nil 5 function 501 t 642) (nil 3 function 416 ("setLocation") 650) (((nil 3 function 207 ("pagerUpdate") 410)) 1 function 40 t 64) (((nil 1 function 3 t 27)) -2305843009213693952 toplevel nil nil nil))) 460 461 (fontified t) 461 538 (fontified t) 538 546 (fontified t face font-lock-string-face) 546 587 (fontified t) 587 588 (fontified t js--pend (nil 5 function 501 t 642)) 588 595 (fontified t) 595 596 (fontified t js--pend (((nil 5 function 501 t 642)) 3 function 416 ("setLocation") 650)) 596 616 (fontified t) 616 624 (fontified t face font-lock-keyword-face) 624 628 (fontified t) 628 629 (fontified t js--pstate ((nil 4 function 670 t 712) (((((nil 5 function 501 t 642)) 3 function 416 ("setLocation") 650) (nil 3 function 207 ("pagerUpdate") 410)) 1 function 40 t 64) (((nil 1 function 3 t 27)) -2305843009213693952 toplevel nil nil nil))) 629 657 (fontified t) 657 658 (fontified t js--pend (nil 4 function 670 t 712)) 658 679 (fontified t) 679 687 (fontified t face font-lock-keyword-face) 687 691 (fontified t) 691 692 (fontified t js--pstate ((nil 4 function 733 t 775) (((nil 4 function 670 t 712) (((nil 5 function 501 t 642)) 3 function 416 ("setLocation") 650) (nil 3 function 207 ("pagerUpdate") 410)) 1 function 40 t 64) (((nil 1 function 3 t 27)) -2305843009213693952 toplevel nil nil nil))) 692 720 (fontified t) 720 721 (fontified t js--pend (nil 4 function 733 t 775)) 721 777 (fontified t)) . -54) (t 20711 . 49274) ((marker) . -31) ((marker) . -31) ((marker) . -72) ((marker) . -72) ((marker) . -94) ((marker) . -94) ((marker) . -121) ((marker) . -121) ((marker) . -148) ((marker) . -148) ((marker) . -149) ((marker) . -149) ((marker) . -189) ((marker) . -189) ((marker) . -233) ((marker) . -233) ((marker) . -260) ((marker) . -260) ((marker) . -324) ((marker) . -324) ((marker) . -351) ((marker) . -351) ((marker) . -357) ((marker) . -357) ((marker) . -358) ((marker) . -358) ((marker) . -398) ((marker) . -398) ((marker) . -461) ((marker) . -461) ((marker) . -495) ((marker) . -495) ((marker) . -549) ((marker) . -549) ((marker) . -581) ((marker) . -581) ((marker) . -591) ((marker) . -591) ((marker) . -597) ((marker) . -597) ((marker) . -598) ((marker) . -598) ((marker) . -661) ((marker) . -661) ((marker) . -724) ((marker) . -724) ((marker) . -725) ((marker) . -725) ((marker) . -753) ((marker) . -753) ((marker) . -773) ((marker) . -773) ((marker) . -777) ((marker) . -777) ((marker) . -777)))
