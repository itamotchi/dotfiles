
((digest . "4ba5b951cb0c28e8ec5ffa170d087907") (undo-list nil (#("
var request = null;



    try { request = new XMLHttpRequest(); }
    catch (trymicrosoft) {
        try { request = new ActiveXObject(\"Msxml2.XMLHTTP\"); }
        catch (othermicrosoft) {
            try { request = new ActiveXObject(\"Microsoft.XMLHTTP\"); }
            catch (failed) { request = null; }
        }
    }
    if (request == null) {
        alert (\"エラー: requestオブジェクトの作成に失敗しました!\")
    } else {
        return request;
    }


" 0 1 (fontified t) 1 4 (fontified t face font-lock-keyword-face) 4 5 (fontified t) 5 12 (fontified t face font-lock-variable-name-face) 12 15 (fontified t) 15 19 (fontified t face font-lock-constant-face) 19 21 (fontified t) 21 28 (fontified t) 28 31 (fontified t face font-lock-keyword-face) 31 44 (fontified t) 44 47 (fontified t face font-lock-keyword-face) 47 48 (fontified t) 48 62 (fontified t face font-lock-type-face) 62 72 (fontified t) 72 77 (fontified t face font-lock-keyword-face) 77 103 (fontified t) 103 106 (fontified t face font-lock-keyword-face) 106 119 (fontified t) 119 122 (fontified t face font-lock-keyword-face) 122 123 (fontified t) 123 136 (fontified t face font-lock-type-face) 136 137 (fontified t) 137 153 (fontified t face font-lock-string-face) 153 166 (fontified t) 166 171 (fontified t face font-lock-keyword-face) 171 203 (fontified t) 203 206 (fontified t face font-lock-keyword-face) 206 219 (fontified t) 219 222 (fontified t face font-lock-keyword-face) 222 223 (fontified t) 223 236 (fontified t face font-lock-type-face) 236 237 (fontified t) 237 256 (fontified t face font-lock-string-face) 256 273 (fontified t) 273 278 (fontified t face font-lock-keyword-face) 278 300 (fontified t) 300 304 (fontified t face font-lock-constant-face) 304 328 (fontified t) 328 330 (fontified t face font-lock-keyword-face) 330 343 (fontified t) 343 347 (fontified t face font-lock-constant-face) 347 366 (fontified t) 366 397 (fontified t face font-lock-string-face) 397 405 (fontified t) 405 409 (fontified t face font-lock-keyword-face) 409 420 (fontified t) 420 426 (fontified t face font-lock-keyword-face) 426 444 (fontified t)) . -432) ((marker) . -23) ((marker) . -23) ((marker) . -22) ((marker) . -22) ((marker) . -21) ((marker) . -21) ((marker) . -1) ((marker) . -1) ((marker) . -24) ((marker) . -24) ((marker) . -68) ((marker) . -68) ((marker) . -95) ((marker) . -95) ((marker) . -158) ((marker) . -158) ((marker) . -191) ((marker) . -191) ((marker) . -261) ((marker) . -261) ((marker) . -308) ((marker) . -308) ((marker) . -318) ((marker) . -318) ((marker) . -324) ((marker) . -324) ((marker) . -351) ((marker) . -351) ((marker) . -399) ((marker) . -399) ((marker) . -412) ((marker) . -412) ((marker) . -436) ((marker) . -436) ((marker) . -442) ((marker) . -442) ((marker) . -443) ((marker) . -443) ((marker) . -444) nil (nil rear-nonsticky nil 431 . 432) (nil fontified nil 413 . 432) (nil fontified nil 412 . 413) (nil fontified nil 409 . 412) (nil fontified nil 380 . 409) (nil fontified nil 372 . 380) (nil fontified nil 368 . 372) (nil fontified nil 355 . 368) (nil fontified nil 353 . 355) (nil fontified nil 329 . 353) (nil fontified nil 325 . 329) (nil fontified nil 303 . 325) (nil fontified nil 298 . 303) (nil fontified nil 281 . 298) (nil fontified nil 262 . 281) (nil fontified nil 261 . 262) (nil fontified nil 248 . 261) (nil fontified nil 247 . 248) (nil fontified nil 244 . 247) (nil fontified nil 231 . 244) (nil fontified nil 228 . 231) (nil fontified nil 196 . 228) (nil fontified nil 191 . 196) (nil fontified nil 178 . 191) (nil fontified nil 162 . 178) (nil fontified nil 161 . 162) (nil fontified nil 148 . 161) (nil fontified nil 147 . 148) (nil fontified nil 144 . 147) (nil fontified nil 131 . 144) (nil fontified nil 128 . 131) (nil fontified nil 102 . 128) (nil fontified nil 97 . 102) (nil fontified nil 87 . 97) (nil fontified nil 73 . 87) (nil fontified nil 72 . 73) (nil fontified nil 69 . 72) (nil fontified nil 56 . 69) (nil fontified nil 53 . 56) (nil fontified nil 48 . 53) (nil fontified nil 47 . 48) (nil fontified nil 44 . 47) (nil fontified nil 31 . 44) (nil fontified nil 30 . 31) (nil fontified nil 22 . 30) (nil fontified nil 19 . 22) (nil fontified nil 15 . 19) (nil fontified nil 12 . 15) (nil fontified nil 5 . 12) (nil fontified nil 4 . 5) (nil fontified nil 1 . 4) (1 . 432) (t 19836 . 338) nil (#("var request2 = createRequest();" 0 3 (face font-lock-keyword-face fontified t) 3 4 (fontified t) 4 12 (face font-lock-variable-name-face fontified t) 12 31 (fontified t)) . 445) nil (#("
" 0 1 (fontified t)) . 445) nil (#("var request1 = createRequest();" 0 3 (face font-lock-keyword-face fontified t) 3 4 (fontified t) 4 12 (face font-lock-variable-name-face fontified t) 12 31 (fontified t)) . 445) nil (#("    var request = null;" 0 4 (fontified t) 4 7 (face font-lock-keyword-face fontified t) 7 8 (fontified t) 8 15 (face font-lock-variable-name-face fontified t) 15 18 (fontified t) 18 22 (face font-lock-constant-face fontified t) 22 23 (fontified t)) . 24) nil (#("}" 0 1 (fontified t)) . 466) nil (#("function createRequest() {" 0 8 (face font-lock-keyword-face fontified t) 8 9 (fontified t) 9 22 (face font-lock-function-name-face fontified t) 22 25 (fontified t) 25 26 (js--pstate ((nil 0 function 23 ("createRequest") nil) (nil -2305843009213693952 toplevel nil nil nil)) fontified t)) . 23) nil (20 . 21) nil (2 . 20) nil (2 . 3) nil (1 . 2) (t 19834 . 55029)))
