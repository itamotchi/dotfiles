
((digest . "9a8990e24ffcf74ba1ffbae449e5ac12") (undo-list nil (#("  
" 0 3 (fontified t)) . 58) ((marker) . -3) ((marker) . -3) ((marker) . -3) nil (#("
" 0 1 (fontified t)) . 58) ((marker) . -1) ((marker) . -1) ((marker) . -1) nil (#("                return self.domain == domain" 0 16 (fontified t) 16 22 (fontified t face font-lock-keyword-face) 22 23 (fontified t) 23 27 (fontified t face font-lock-keyword-face) 27 44 (fontified t)) . 58) ((marker) . -44) nil (#("
" 0 1 (fontified t)) . 58) nil (#("            else:" 0 12 (fontified t) 12 16 (fontified t face font-lock-keyword-face) 16 17 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("                return self.server == server and self.domain == domain" 0 16 (fontified t) 16 22 (fontified t face font-lock-keyword-face) 22 23 (fontified t) 23 27 (fontified t face font-lock-keyword-face) 27 45 (fontified t) 45 48 (fontified t face font-lock-keyword-face) 48 49 (fontified t) 49 53 (fontified t face font-lock-keyword-face) 53 70 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("                server, domain = domain.split('.', 1)" 0 46 (fontified t) 46 49 (fontified t face font-lock-string-face) 49 53 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) ((marker . 113) . -1) ((marker . 113) . -1) nil (#("            if self.server != '':" 0 12 (fontified t) 12 14 (fontified t face font-lock-keyword-face) 14 15 (fontified t) 15 19 (fontified t face font-lock-keyword-face) 19 30 (fontified t) 30 32 (fontified t face font-lock-string-face) 32 33 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        else:" 0 8 (fontified t) 8 12 (fontified t face font-lock-keyword-face) 12 13 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("                return self.server == server and self.domain == domain" 0 16 (fontified t) 16 22 (fontified t face font-lock-keyword-face) 22 23 (fontified t) 23 27 (fontified t face font-lock-keyword-face) 27 45 (fontified t) 45 48 (fontified t face font-lock-keyword-face) 48 49 (fontified t) 49 53 (fontified t face font-lock-keyword-face) 53 70 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("            else:" 0 12 (fontified t) 12 16 (fontified t face font-lock-keyword-face) 16 17 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("                return self.domain == domain" 0 16 (fontified t) 16 22 (fontified t face font-lock-keyword-face) 22 23 (fontified t) 23 27 (fontified t face font-lock-keyword-face) 27 44 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("            if self.server == '':" 0 12 (fontified t) 12 14 (fontified t face font-lock-keyword-face) 14 15 (fontified t) 15 19 (fontified t face font-lock-keyword-face) 19 30 (fontified t) 30 32 (fontified t face font-lock-string-face) 32 33 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("            server, domain = domain.split('.', 1)" 0 42 (fontified t) 42 45 (fontified t face font-lock-string-face) 45 49 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        if domain.split('.', 1) == 'www':" 0 8 (fontified t) 8 10 (fontified t face font-lock-keyword-face) 10 24 (fontified t) 24 27 (fontified t face font-lock-string-face) 27 35 (fontified t) 35 40 (fontified t face font-lock-string-face) 40 41 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("            return False" 0 12 (fontified t) 12 18 (fontified t face font-lock-keyword-face) 18 19 (fontified t) 19 24 (fontified t face font-lock-keyword-face)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        if self.scheme != scheme:" 0 8 (fontified t) 8 10 (fontified t face font-lock-keyword-face) 10 11 (fontified t) 11 15 (fontified t face font-lock-keyword-face) 15 33 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        domain = domain[:-1] if domain[-1] == '/' else domain" 0 29 (fontified t) 29 31 (fontified t face font-lock-keyword-face) 31 46 (fontified t) 46 49 (fontified t face font-lock-string-face) 49 50 (fontified t) 50 54 (fontified t face font-lock-keyword-face) 54 61 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        scheme, domain = host_name.split('://', 1)" 0 41 (fontified t) 41 46 (fontified t face font-lock-string-face) 46 50 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("    def is_equal(self, host_name):" 0 4 (fontified t) 4 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 16 (fontified t face font-lock-function-name-face) 16 17 (fontified t) 17 21 (fontified t face font-lock-keyword-face) 21 34 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        return self.scheme + '://' + self.server + '.' + self.domain + '/'" 0 8 (fontified t) 8 14 (fontified t face font-lock-keyword-face) 14 15 (fontified t) 15 19 (fontified t face font-lock-keyword-face) 19 29 (fontified t) 29 34 (fontified t face font-lock-string-face) 34 37 (fontified t) 37 41 (fontified t face font-lock-keyword-face) 41 51 (fontified t) 51 54 (fontified t face font-lock-string-face) 54 57 (fontified t) 57 61 (fontified t face font-lock-keyword-face) 61 71 (fontified t) 71 74 (fontified t face font-lock-string-face)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("    def __str__(self):" 0 4 (fontified t) 4 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 15 (fontified t face font-lock-function-name-face) 15 16 (fontified t) 16 20 (fontified t face font-lock-keyword-face) 20 22 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        self.domain = domain_name" 0 8 (fontified t) 8 12 (fontified t face font-lock-keyword-face) 12 33 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        self.server = server_name" 0 8 (fontified t) 8 12 (fontified t face font-lock-keyword-face) 12 33 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("        self.scheme = scheme" 0 8 (fontified t) 8 12 (fontified t face font-lock-keyword-face) 12 28 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("    def __init__(self, scheme, server_name, domain_name):" 0 4 (fontified t) 4 7 (fontified t face font-lock-keyword-face) 7 8 (fontified t) 8 16 (fontified t face font-lock-function-name-face) 16 17 (fontified t) 17 21 (fontified t face font-lock-keyword-face) 21 57 (fontified t)) . 58) nil (#("
" 0 1 (fontified t)) . 58) nil (#("class url_obj:" 0 5 (fontified t face font-lock-keyword-face) 5 6 (fontified t) 6 13 (fontified t face font-lock-type-face) 13 14 (fontified t)) . 58) (t 20677 . 58751) nil (#(")" 0 1 (fontified t)) . -1135) nil (#(")" 0 1 (fontified t)) . -1088) (t 20677 . 58377) nil (1113 . 1116) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#(" " 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#("," 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#(" " 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#("," 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1113) nil (#("(" 0 1 (fontified t)) . 1108) nil (#("_obj" 0 4 (fontified t)) . 1108) nil (#("url" 0 3 (fontified t)) . 1108) nil (#("/" 0 1 (fontified t face font-lock-string-face)) . -1087) nil (1087 . 1088) nil (1056 . 1059) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#(" " 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#("," 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#(" " 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#("," 0 1 (fontified t face font-lock-string-face)) . 1056) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1056) nil (1056 . 1069) nil (#("', '', 'enika" 0 1 (fontified t face font-lock-string-face) 1 3 (fontified t) 3 4 (fontified t face font-lock-string-face) 4 5 (fontified t face font-lock-string-face) 5 7 (fontified t) 7 8 (fontified t face font-lock-string-face) 8 13 (fontified t face font-lock-string-face)) . 1056) nil (1050 . 1051) nil (#("'" 0 1 (fontified t face font-lock-string-face)) . 1050) nil (#("(" 0 1 (fontified t)) . 1050) nil (#("_obj" 0 4 (fontified t)) . 1050) nil (#("url" 0 3 (fontified t)) . 1050) (t 20677 . 57427) nil (309 . 314) nil (#("_name" 0 5 (fontified t)) . 315) (t 20677 . 29188)))
