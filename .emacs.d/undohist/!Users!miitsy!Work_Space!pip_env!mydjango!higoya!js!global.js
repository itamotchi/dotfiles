
((digest . "e25535e64648d5a75e22d88ac2f60b60") (undo-list nil (184 . 185) nil (171 . 184) nil (113 . 114) nil (100 . 113) nil (48 . 49) nil (35 . 48) (t 20682 . 29839) nil (145 . 146) nil (144 . 145) nil (#("
" 0 1 (fontified t)) . -144) ((marker) . -1) ((marker) . -1) nil (144 . 145) nil (143 . 144) nil (142 . 143) nil (124 . 142) nil (121 . 124) nil (120 . 121) nil (119 . 120) nil (118 . 119) nil (117 . 118) nil (103 . 117) nil (#("c" 0 1 (fontified t)) . -103) nil (91 . 104) nil (34 . 35) nil (19 . 34) nil (17 . 19) nil (#("
" 0 1 (fontified t)) . 24) ((marker) . -1) ((marker) . -1) ((marker) . -1) nil (22 . 23) nil (21 . 22) nil (20 . 21) nil (19 . 20) nil (#(")" 0 1 (fontified t)) . -19) nil (#("(" 0 1 (fontified t)) . -20) nil (#(")" 0 1 (fontified t)) . -21) ((marker*) . 1) ((marker) . -1) nil (#(")" 0 1 (fontified t)) . -22) ((marker*) . 1) ((marker) . -1) nil (22 . 23) nil (21 . 22) nil (20 . 21) nil (19 . 20) nil (#(")" 0 1 (fontified t)) . -19) ((marker*) . 1) ((marker) . -1) nil (19 . 20) nil (18 . 19) nil (17 . 18) nil (16 . 17) nil (15 . 16) nil (14 . 15) nil (13 . 14) nil (12 . 13) nil (2 . 12) nil (1 . 2) nil (2 . 3) nil (1 . 2) nil (44 . 45) nil (36 . 44) nil (#("r" 0 1 (fontified t)) . -36) nil (#("e" 0 1 (fontified t)) . -37) nil (25 . 38) nil (23 . 25) nil (23 . 24) nil (#("  /*
    タブによって部屋の見取り図と、フロアマップを変化させる
    タブボタン：#room_tab > li
    タブ詳細：#room_detail > dl
    フロアマップ：img#activeroom(マップ自体は別の画像で、これはそのマップに対してハイライトさせている画像)
    タブボタンとタブ詳細は属性値'data-tabkey'によって判別させる
   */
  var tabs = $('#room_tab li').get();
  var details = $('#room_detail dl').get();
  var current = ''

  function selectTab(newkey) {
    $(tabs).not('[data-tabkey=' + newkey + ']').removeClass('selected');
    $(tabs).filter('[data-tabkey=' + newkey + ']').addClass('selected');
    if (newkey === 'all') {
      // タブキー\"all\"は、すべての詳細を表示させる。
      $(details).addClass('selected');
      // ハイライトはなしにする。=ダミーを使う
      $('#activeroom').attr('src', '/image/dummy.gif');
    } else {
      $(details).not('[data-tabkey=' + newkey + ']').removeClass('selected');
      $(details).filter('[data-tabkey=' + newkey + ']').addClass('selected');
      $('#activeroom').attr('src', '/image/room_' + newkey + '.gif');
    }
    current = newtype;
  }

  $(tabs).click(function () { selectTab($(this).attr('data-tabkey')); });
  current = $(tabs).eq(0).attr('data-tabkey');
  selectTab(current);
" 0 2 (fontified t) 2 4 (face font-lock-comment-delimiter-face fontified t) 4 199 (face font-lock-comment-face fontified t) 199 202 (fontified t) 202 205 (face font-lock-keyword-face fontified t) 205 206 (fontified t) 206 210 (face font-lock-variable-name-face fontified t) 210 215 (fontified t) 215 229 (face font-lock-string-face fontified t) 229 240 (fontified t) 240 243 (face font-lock-keyword-face fontified t) 243 244 (fontified t) 244 251 (face font-lock-variable-name-face fontified t) 251 256 (fontified t) 256 273 (face font-lock-string-face fontified t) 273 284 (fontified t) 284 287 (face font-lock-keyword-face fontified t) 287 288 (fontified t) 288 295 (face font-lock-variable-name-face fontified t) 295 298 (fontified t) 298 300 (face font-lock-string-face fontified t) 300 304 (fontified t) 304 312 (face font-lock-keyword-face fontified t) 312 313 (fontified t) 313 322 (face font-lock-function-name-face fontified t) 322 323 (fontified t) 323 329 (face font-lock-variable-name-face fontified t) 329 331 (fontified t) 331 332 (js--pstate ((nil 2 function 327 ("selectTab") 959) (nil 1 function 9 t nil) (nil -2305843009213693952 toplevel nil nil nil)) fontified t) 332 349 (fontified t) 349 364 (face font-lock-string-face fontified t) 364 376 (fontified t) 376 379 (face font-lock-string-face fontified t) 379 393 (fontified t) 393 403 (face font-lock-string-face fontified t) 403 425 (fontified t) 425 440 (face font-lock-string-face fontified t) 440 452 (fontified t) 452 455 (face font-lock-string-face fontified t) 455 466 (fontified t) 466 476 (face font-lock-string-face fontified t) 476 479 (fontified t) 479 483 (fontified t) 483 485 (face font-lock-keyword-face fontified t) 485 498 (fontified t) 498 503 (face font-lock-string-face fontified t) 503 513 (fontified t) 513 516 (face font-lock-comment-delimiter-face fontified t) 516 541 (face font-lock-comment-face fontified t) 541 567 (fontified t) 567 577 (face font-lock-string-face fontified t) 577 586 (fontified t) 586 589 (face font-lock-comment-delimiter-face fontified t) 589 609 (face font-lock-comment-face fontified t) 609 617 (fontified t) 617 630 (face font-lock-string-face fontified t) 630 637 (fontified t) 637 642 (face font-lock-string-face fontified t) 642 644 (fontified t) 644 662 (face font-lock-string-face fontified t) 662 671 (fontified t) 671 675 (face font-lock-keyword-face fontified t) 675 699 (fontified t) 699 714 (face font-lock-string-face fontified t) 714 726 (fontified t) 726 729 (face font-lock-string-face fontified t) 729 743 (fontified t) 743 753 (face font-lock-string-face fontified t) 753 780 (fontified t) 780 795 (face font-lock-string-face fontified t) 795 807 (fontified t) 807 810 (face font-lock-string-face fontified t) 810 821 (fontified t) 821 831 (face font-lock-string-face fontified t) 831 842 (fontified t) 842 855 (face font-lock-string-face fontified t) 855 862 (fontified t) 862 867 (face font-lock-string-face fontified t) 867 869 (fontified t) 869 883 (face font-lock-string-face fontified t) 883 895 (fontified t) 895 901 (face font-lock-string-face fontified t) 901 935 (fontified t) 935 936 (js--pend (nil 2 function 327 ("selectTab") 959) fontified t) 936 954 (fontified t) 954 962 (face font-lock-keyword-face fontified t) 962 966 (fontified t) 966 967 (js--pstate ((nil 3 function 977 t 1032) (((nil 2 function 327 ("selectTab") 959)) 1 function 9 t nil) (nil -2305843009213693952 toplevel nil nil nil)) fontified t) 967 980 (fontified t) 980 984 (face font-lock-constant-face fontified t) 984 991 (fontified t) 991 1004 (face font-lock-string-face fontified t) 1004 1008 (fontified t) 1008 1009 (js--pend (nil 3 function 977 t 1032) fontified t) 1009 1012 (fontified t) 1012 1043 (fontified t) 1043 1056 (face font-lock-string-face fontified t) 1056 1081 (fontified t)) . -23) (t 20682 . 29765) ((marker) . -1012) ((marker) . -1012) ((marker) . -1059) ((marker) . -1059) ((marker) . -1081) ((marker) . -1081)))
