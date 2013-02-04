
((digest . "1b8aa0b9cd93c63d6a91b77f03948f6e") (undo-list nil (321 . 322) nil (320 . 321) nil (307 . 320) nil (302 . 307) nil (298 . 302) nil (299 . 300) nil (298 . 299) nil (297 . 298) nil (296 . 297) nil (295 . 296) nil (294 . 295) nil (293 . 294) nil (#(" " 0 1 (fontified t)) . -293) ((marker . 1) . -1) ((marker . 1) . -1) ((marker . 67) . -1) ((marker . 67) . -1) ((marker . 138) . -1) ((marker . 138) . -1) ((marker . 139) . -1) ((marker . 139) . -1) ((marker . 195) . -1) ((marker . 195) . -1) ((marker . 237) . -1) ((marker . 237) . -1) ((marker . 280) . -1) ((marker . 280) . -1) ((marker . 282) . -1) ((marker . 282) . -1) ((marker . 283) . -1) ((marker . 283) . -1) nil (282 . 294) nil (281 . 282) nil (280 . 281) nil (279 . 280) nil (278 . 279) nil (277 . 278) nil (276 . 277) nil (273 . 276) nil (#("a" 0 1 (fontified t)) . -273) nil (271 . 274) nil (251 . 271) nil (#(" " 0 1 (fontified t)) . -251) nil (#("=" 0 1 (fontified t)) . -252) nil (251 . 253) nil (241 . 251) nil (237 . 241) nil (236 . 237) nil (235 . 236) nil (234 . 235) nil (233 . 234) nil (228 . 233) nil (208 . 228) nil (198 . 208) nil (195 . 198) nil (#("section.addEventListner('" 0 8 (fontified t) 8 24 (fontified t) 24 25 (fontified t face font-lock-string-face)) . 195) nil (218 . 220) nil (214 . 218) nil (194 . 214) nil (193 . 194) nil (192 . 193) nil (182 . 192) nil (#(" " 0 1 (fontified t)) . -182) nil (#("(" 0 1 (fontified t)) . -183) nil (183 . 184) nil (182 . 183) nil (#("s" 0 1 (fontified t)) . -178) nil (182 . 183) nil (175 . 182) (172 . 173) (162 . 174) nil (#("e" 0 1 (fontified t)) . -162) ((marker . 162) . -1) nil (#("l" 0 1 (fontified t)) . -163) ((marker . 162) . -1) nil (#("e" 0 1 (fontified t)) . -164) ((marker . 162) . -1) nil (#("m" 0 1 (fontified t)) . -165) ((marker . 162) . -1) nil (#("e" 0 1 (fontified t)) . -166) ((marker . 162) . -1) nil (#("n" 0 1 (fontified t)) . -167) ((marker . 162) . -1) nil (#("t" 0 1 (fontified t)) . -168) ((marker . 162) . -1) nil (#("." 0 1 (fontified t)) . -169) nil (#("g" 0 1 (fontified t)) . -170) nil (#("e" 0 1 (fontified t)) . -171) nil (#("t" 0 1 (fontified t)) . -172) nil (#("B" 0 1 (fontified t)) . -173) nil (#("y" 0 1 (fontified t)) . -174) nil (162 . 175) nil (#("e" 0 1 (fontified t)) . -162) nil (162 . 163) nil (#("g" 0 1 (fontified t)) . -162) nil (#("e" 0 1 (fontified t)) . -163) nil (#("t" 0 1 (fontified t)) . -164) nil (#("B" 0 1 (fontified t)) . -165) nil (#("y" 0 1 (fontified t)) . -166) nil (159 . 167) nil (139 . 159) nil (#("function putCart(productID) {
    var quantityID = \"p\" + productID + \"Quantity\";
    var quantity   = document.getElementById(quantityID).value;
    var url        = \"/enika_itamotchi/class/CartController.php?addID=\"
        + escape(productID) + \"&quantity=\"  + escape(quantity);
    request.open(\"GET\", url, true);
    request.onreadystatechange = updateCart;
    request.send(null);
}

function removeProduct(productID) {
    var url = \"/enika_itamotchi/class/CartController.php?removeID=\"
        + escape(productID);
    request.open(\"GET\", url, true);
    request.onreadystatechange = updateCart;
    request.send(null);
}

function updateCart() {
    if (request.readyState == 4) {
        if (request.status == 200) {

            var inCartForm = document.getElementById(\"inCartForm\");
            while (inCartForm.firstChild) {
                inCartForm.removeChild(inCartForm.firstChild);
            }

            var jsonData = eval('(' + request.responseText + ')');

            for (var i = 0; i < jsonData.length; i++) {
                var productName     = jsonData[i]['name'];
                var productPrice    = jsonData[i]['price'];
                var productQuantity = jsonData[i]['quantity'];

                var recordElement   = document.createElement(\"dl\");
                var nameElement     = document.createElement(\"dt\");
                var nameText        = document.createTextNode(productName);
                nameElement.appendChild(nameText);
                recordElement.appendChild(nameElement);
                var priceElement    = document.createElement(\"dd\");
                var priceText       
                    = document.createTextNode(\"価格: \" + productPrice + \"円\");
                priceElement.appendChild(priceText);
                recordElement.appendChild(priceElement);
                var quantityElement = document.createElement(\"dd\");
                var quantityText    = document.createTextNode(\"個数: \");
                var quantityChange  = document.createElement(\"input\");
                quantityChange.setAttribute(\"type\", \"number\");
                quantityChange.setAttribute(\"size\", \"1\");
                quantityChange.setAttribute(\"value\", productQuantity);
                var quantityDelete  = document.createElement(\"input\");
                quantityDelete.setAttribute(\"type\", \"button\");
                quantityDelete.setAttribute(\"value\", \"削除\");
                quantityElement.appendChild(quantityText);
                quantityElement.appendChild(quantityChange);
                quantityElement.appendChild(quantityDelete);
                recordElement.appendChild(quantityElement);
                inCartForm.appendChild(recordElement);
            }
        }
        else {
            alert(\"Error! Request status is \" + request.status);
        }
    }
}
" 0 8 (fontified t face font-lock-keyword-face) 8 9 (fontified t) 9 16 (fontified t face font-lock-function-name-face) 16 17 (fontified t) 17 26 (fontified t face font-lock-variable-name-face) 26 28 (fontified t) 28 29 (fontified t js--pstate ((nil 0 function 139 ("putCart") 526) (nil -2305843009213693952 toplevel nil nil nil))) 29 34 (fontified t) 34 37 (fontified t face font-lock-keyword-face) 37 38 (fontified t) 38 48 (fontified t face font-lock-variable-name-face) 48 51 (fontified t) 51 54 (fontified t face font-lock-string-face) 54 69 (fontified t) 69 79 (fontified t face font-lock-string-face) 79 85 (fontified t) 85 88 (fontified t face font-lock-keyword-face) 88 89 (fontified t) 89 97 (fontified t face font-lock-variable-name-face) 97 149 (fontified t) 149 152 (fontified t face font-lock-keyword-face) 152 153 (fontified t) 153 156 (fontified t face font-lock-variable-name-face) 156 166 (fontified t) 166 216 (fontified t face font-lock-string-face) 216 247 (fontified t) 247 259 (fontified t face font-lock-string-face) 259 298 (fontified t) 298 303 (fontified t face font-lock-string-face) 303 310 (fontified t) 310 314 (fontified t face font-lock-constant-face) 314 362 (fontified t) 362 379 (fontified t) 379 383 (fontified t face font-lock-constant-face) 383 386 (fontified t) 386 387 (fontified t js--pend (nil 0 function 139 ("putCart") 526)) 387 389 (fontified t) 389 397 (fontified t face font-lock-keyword-face) 397 398 (fontified t) 398 411 (fontified t face font-lock-function-name-face) 411 412 (fontified t) 412 421 (fontified t face font-lock-variable-name-face) 421 423 (fontified t) 423 424 (fontified t js--pstate ((nil 0 function 528 ("removeProduct") 767) (((nil 0 function 139 ("putCart") 526)) -2305843009213693952 toplevel nil nil nil))) 424 429 (fontified t) 429 432 (fontified t face font-lock-keyword-face) 432 433 (fontified t) 433 436 (fontified t face font-lock-variable-name-face) 436 439 (fontified t) 439 492 (fontified t face font-lock-string-face) 492 522 (fontified t) 522 539 (fontified t) 539 544 (fontified t face font-lock-string-face) 544 551 (fontified t) 551 555 (fontified t face font-lock-constant-face) 555 620 (fontified t) 620 624 (fontified t face font-lock-constant-face) 624 627 (fontified t) 627 628 (fontified t js--pend (nil 0 function 528 ("removeProduct") 767)) 628 630 (fontified t) 630 638 (fontified t face font-lock-keyword-face) 638 639 (fontified t) 639 649 (fontified t face font-lock-function-name-face) 649 652 (fontified t) 652 653 (fontified t js--pstate ((nil 0 function 769 ("updateCart") 2986) (((nil 0 function 528 ("removeProduct") 767) (nil 0 function 139 ("putCart") 526)) -2305843009213693952 toplevel nil nil nil))) 653 658 (fontified t) 658 660 (fontified t face font-lock-keyword-face) 660 697 (fontified t) 697 699 (fontified t face font-lock-keyword-face) 699 739 (fontified t) 739 742 (fontified t face font-lock-keyword-face) 742 743 (fontified t) 743 753 (fontified t face font-lock-variable-name-face) 753 780 (fontified t) 780 792 (fontified t face font-lock-string-face) 792 807 (fontified t) 807 812 (fontified t face font-lock-keyword-face) 812 902 (fontified t) 902 929 (fontified t) 929 932 (fontified t face font-lock-keyword-face) 932 933 (fontified t) 933 941 (fontified t face font-lock-variable-name-face) 941 949 (fontified t) 949 952 (fontified t face font-lock-string-face) 952 978 (fontified t) 978 981 (fontified t face font-lock-string-face) 981 997 (fontified t) 997 1000 (fontified t face font-lock-keyword-face) 1000 1002 (fontified t) 1002 1005 (fontified t face font-lock-keyword-face) 1005 1006 (fontified t) 1006 1007 (fontified t face font-lock-variable-name-face) 1007 1041 (fontified t) 1041 1057 (fontified t) 1057 1060 (fontified t face font-lock-keyword-face) 1060 1061 (fontified t) 1061 1072 (fontified t face font-lock-variable-name-face) 1072 1091 (fontified t) 1091 1097 (fontified t face font-lock-string-face) 1097 1116 (fontified t) 1116 1119 (fontified t face font-lock-keyword-face) 1119 1120 (fontified t) 1120 1132 (fontified t face font-lock-variable-name-face) 1132 1150 (fontified t) 1150 1157 (fontified t face font-lock-string-face) 1157 1176 (fontified t) 1176 1179 (fontified t face font-lock-keyword-face) 1179 1180 (fontified t) 1180 1195 (fontified t face font-lock-variable-name-face) 1195 1210 (fontified t) 1210 1220 (fontified t face font-lock-string-face) 1220 1240 (fontified t) 1240 1243 (fontified t face font-lock-keyword-face) 1243 1244 (fontified t) 1244 1257 (fontified t face font-lock-variable-name-face) 1257 1285 (fontified t) 1285 1289 (fontified t face font-lock-string-face) 1289 1308 (fontified t) 1308 1311 (fontified t face font-lock-keyword-face) 1311 1312 (fontified t) 1312 1323 (fontified t face font-lock-variable-name-face) 1323 1353 (fontified t) 1353 1357 (fontified t face font-lock-string-face) 1357 1376 (fontified t) 1376 1379 (fontified t face font-lock-keyword-face) 1379 1380 (fontified t) 1380 1388 (fontified t face font-lock-variable-name-face) 1388 1436 (fontified t) 1436 1543 (fontified t) 1543 1559 (fontified t) 1559 1562 (fontified t face font-lock-keyword-face) 1562 1563 (fontified t) 1563 1575 (fontified t face font-lock-variable-name-face) 1575 1604 (fontified t) 1604 1608 (fontified t face font-lock-string-face) 1608 1627 (fontified t) 1627 1630 (fontified t face font-lock-keyword-face) 1630 1631 (fontified t) 1631 1640 (fontified t face font-lock-variable-name-face) 1640 1694 (fontified t) 1694 1700 (fontified t face font-lock-string-face) 1700 1718 (fontified t) 1718 1721 (fontified t face font-lock-string-face) 1721 1850 (fontified t) 1850 1853 (fontified t face font-lock-keyword-face) 1853 1854 (fontified t) 1854 1869 (fontified t face font-lock-variable-name-face) 1869 1895 (fontified t) 1895 1899 (fontified t face font-lock-string-face) 1899 1918 (fontified t) 1918 1921 (fontified t face font-lock-keyword-face) 1921 1922 (fontified t) 1922 1934 (fontified t face font-lock-variable-name-face) 1934 1964 (fontified t) 1964 1970 (fontified t face font-lock-string-face) 1970 1989 (fontified t) 1989 1992 (fontified t face font-lock-keyword-face) 1992 1993 (fontified t) 1993 2007 (fontified t face font-lock-variable-name-face) 2007 2034 (fontified t) 2034 2041 (fontified t face font-lock-string-face) 2041 2044 (fontified t) 2044 2088 (fontified t) 2088 2094 (fontified t face font-lock-string-face) 2094 2096 (fontified t) 2096 2104 (fontified t face font-lock-string-face) 2104 2151 (fontified t) 2151 2157 (fontified t face font-lock-string-face) 2157 2159 (fontified t) 2159 2162 (fontified t face font-lock-string-face) 2162 2209 (fontified t) 2209 2216 (fontified t face font-lock-string-face) 2216 2252 (fontified t) 2252 2255 (fontified t face font-lock-keyword-face) 2255 2256 (fontified t) 2256 2270 (fontified t face font-lock-variable-name-face) 2270 2297 (fontified t) 2297 2304 (fontified t face font-lock-string-face) 2304 2351 (fontified t) 2351 2357 (fontified t face font-lock-string-face) 2357 2359 (fontified t) 2359 2367 (fontified t face font-lock-string-face) 2367 2414 (fontified t) 2414 2421 (fontified t face font-lock-string-face) 2421 2423 (fontified t) 2423 2427 (fontified t face font-lock-string-face) 2427 2550 (fontified t) 2550 2758 (fontified t) 2758 2762 (fontified t face font-lock-keyword-face) 2762 2783 (fontified t) 2783 2810 (fontified t face font-lock-string-face) 2810 2846 (fontified t) 2846 2847 (fontified t js--pend (nil 0 function 769 ("updateCart") 2986)) 2847 2848 (fontified t)) . -139) ((marker . 1) . -1041) nil (31 . 37) nil (#("_itamotchi" 0 10 (fontified t face font-lock-string-face)) . 31) nil (#("enika" 0 5 (fontified t face font-lock-string-face)) . 31) nil (106 . 112) nil (#("_itamotchi" 0 10 (fontified t face font-lock-string-face)) . 106) nil (#("enika" 0 5 (fontified t face font-lock-string-face)) . 106) (t 19851 . 25601)))
