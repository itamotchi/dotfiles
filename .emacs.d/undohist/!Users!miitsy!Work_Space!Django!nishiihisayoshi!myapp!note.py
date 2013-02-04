
((digest . "20e680b220d24e4e232dc02fd1e488ad") (undo-list nil (#("class ExhibitionManager(models.Manager):
    def get_archives(self):
        archives = []
        el = self.values('start', 'end', 'title', 'place')
        for e in el:
            start, end, title, place = e['start'], e['end'], e['title'], e['place']
            query = '%s-%s-%s_%s-%s-%s' % (start.year, start.month, start.day,
                                           end.year, end.month, end.day)
            schedule = '%s.%s.%s-' % (start.year, start.month, start.day)
            if start.year != end.year:
                schedule += '%s.' % end.year
            if start.year != end.year or start.month != end.month:
                schedule += '%s.' % end.month
            schedule += '%s' % end.day
            archives.append({'schedule': schedule, 'title': title, 'place': place, 
                             'query': query,})
        return archives
        

class Exhibition(models.Model):
    start = models.DateField()
    end = models.DateField(blank=True, null=True)
    place = models.CharField(max_length=128)
    title = models.CharField(max_length=128, blank=True)
    body = models.TextField()
    aside = models.TextField(blank=True)

    objects = ExhibitionManager()

    class Meta:
        ordering = ('-start', '-end',)

    def __unicode__(self):
        return \"%s-%s\" % (self.start, self.end)

" 0 5 (fontified t face font-lock-keyword-face) 5 6 (fontified t) 6 23 (fontified t face font-lock-type-face) 23 41 (fontified t) 41 45 (fontified t) 45 48 (fontified t face font-lock-keyword-face) 48 49 (fontified t) 49 61 (fontified t face font-lock-function-name-face) 61 62 (fontified t) 62 66 (fontified t face font-lock-keyword-face) 66 69 (fontified t) 69 104 (fontified t) 104 108 (fontified t face font-lock-keyword-face) 108 116 (fontified t) 116 123 (fontified t face font-lock-string-face) 123 125 (fontified t) 125 130 (fontified t face font-lock-string-face) 130 132 (fontified t) 132 139 (fontified t face font-lock-string-face) 139 141 (fontified t) 141 148 (fontified t face font-lock-string-face) 148 158 (fontified t) 158 161 (fontified t face font-lock-keyword-face) 161 164 (fontified t) 164 166 (fontified t face font-lock-keyword-face) 166 212 (fontified t) 212 219 (fontified t face font-lock-string-face) 219 224 (fontified t) 224 229 (fontified t face font-lock-string-face) 229 234 (fontified t) 234 241 (fontified t face font-lock-string-face) 241 246 (fontified t) 246 253 (fontified t face font-lock-string-face) 253 255 (fontified t) 255 275 (fontified t) 275 294 (fontified t face font-lock-string-face) 294 430 (fontified t) 430 441 (fontified t face font-lock-string-face) 441 493 (fontified t) 493 495 (fontified t face font-lock-keyword-face) 495 548 (fontified t) 548 553 (fontified t face font-lock-string-face) 553 565 (fontified t) 565 577 (fontified t) 577 579 (fontified t face font-lock-keyword-face) 579 603 (fontified t) 603 605 (fontified t face font-lock-keyword-face) 605 632 (fontified t) 632 660 (fontified t) 660 665 (fontified t face font-lock-string-face) 665 702 (fontified t) 702 706 (fontified t face font-lock-string-face) 706 746 (fontified t) 746 756 (fontified t face font-lock-string-face) 756 768 (fontified t) 768 775 (fontified t face font-lock-string-face) 775 784 (fontified t) 784 791 (fontified t face font-lock-string-face) 791 801 (fontified t) 801 830 (fontified t) 830 837 (fontified t face font-lock-string-face) 837 856 (fontified t) 856 862 (fontified t face font-lock-keyword-face) 862 882 (fontified t) 882 887 (fontified t face font-lock-keyword-face) 887 888 (fontified t) 888 898 (fontified t face font-lock-type-face) 898 978 (fontified t) 978 982 (fontified t face font-lock-keyword-face) 982 989 (fontified t) 989 993 (fontified t face font-lock-keyword-face) 993 1091 (fontified t) 1091 1095 (fontified t face font-lock-keyword-face) 1095 1097 (fontified t) 1097 1162 (fontified t) 1162 1166 (fontified t face font-lock-keyword-face) 1166 1168 (fontified t) 1168 1208 (fontified t) 1208 1213 (fontified t face font-lock-keyword-face) 1213 1214 (fontified t) 1214 1218 (fontified t face font-lock-type-face) 1218 1240 (fontified t) 1240 1248 (fontified t face font-lock-string-face) 1248 1250 (fontified t) 1250 1256 (fontified t face font-lock-string-face) 1256 1264 (fontified t) 1264 1267 (fontified t face font-lock-keyword-face) 1267 1268 (fontified t) 1268 1279 (fontified t face font-lock-function-name-face) 1279 1280 (fontified t) 1280 1284 (fontified t face font-lock-keyword-face) 1284 1295 (fontified t) 1295 1301 (fontified t face font-lock-keyword-face) 1301 1302 (fontified t) 1302 1309 (fontified t face font-lock-string-face) 1309 1313 (fontified t) 1313 1317 (fontified t face font-lock-keyword-face) 1317 1325 (fontified t) 1325 1329 (fontified t face font-lock-keyword-face) 1329 1335 (fontified t) 1335 1336 (fontified t)) . -1847) ((marker) . -565) ((marker) . -565) ((marker . 54) . -1220) ((marker . 54) . -1220) ((marker . 25) . -1204) ((marker . 25) . -1204) ((marker . 24) . -1203) ((marker . 24) . -1203) ((marker . 1) . -1169) ((marker . 1) . -1169) ((marker) . -1168) ((marker) . -1168) ((marker) . -1127) ((marker) . -1127) ((marker) . -1097) ((marker) . -1097) ((marker) . -1040) ((marker) . -1040) ((marker) . -995) ((marker) . -995) ((marker) . -945) ((marker) . -945) ((marker) . -914) ((marker) . -914) ((marker) . -882) ((marker) . -882) ((marker) . -881) ((marker) . -881) ((marker) . -872) ((marker) . -872) ((marker) . -848) ((marker) . -848) ((marker) . -150) ((marker) . -150) ((marker) . -91) ((marker) . -91) ((marker) . -69) ((marker) . -69) ((marker) . -41) ((marker) . -41) ((marker) . -171) ((marker) . -171) ((marker) . -255) ((marker) . -255) ((marker) . -334) ((marker) . -334) ((marker) . -407) ((marker) . -407) ((marker) . -481) ((marker) . -481) ((marker) . -520) ((marker) . -520) ((marker) . -632) ((marker) . -632) ((marker) . -678) ((marker) . -678) ((marker) . -717) ((marker) . -717) ((marker) . -801) ((marker) . -801) ((marker . 143) . -1335) ((marker . 143) . -1335) ((marker . 142) . -1287) ((marker . 142) . -1287) ((marker . 107) . -1260) ((marker . 107) . -1260) ((marker . 87) . -1259) ((marker . 87) . -1259) ((marker) . -1336) nil (#("
" 0 1 (fontified t)) . 1319) ((marker) . -1) ((marker) . -1) nil (#("
" 0 1 (fontified t rear-nonsticky t)) . 1319) ((marker) . -1) ((marker) . -1) nil (nil rear-nonsticky nil 1319 . 1320) (nil fontified nil 1299 . 1320) (nil fontified nil 1291 . 1299) (nil fontified nil 1259 . 1291) (nil fontified nil 1255 . 1259) (nil fontified nil 1243 . 1255) (nil fontified nil 1237 . 1243) (nil fontified nil 1226 . 1237) (nil fontified nil 1222 . 1226) (nil fontified nil 1221 . 1222) (nil fontified nil 1209 . 1221) (nil fontified nil 1208 . 1209) (nil fontified nil 1205 . 1208) (nil fontified nil 1190 . 1205) (nil fontified nil 1186 . 1190) (nil fontified nil 1183 . 1186) (nil fontified nil 1179 . 1183) (nil fontified nil 1178 . 1179) (nil fontified nil 1172 . 1178) (nil fontified nil 1161 . 1172) (nil fontified nil 1157 . 1161) (nil fontified nil 1156 . 1157) (nil fontified nil 1145 . 1156) (nil fontified nil 1144 . 1145) (nil fontified nil 1141 . 1144) (nil fontified nil 1133 . 1141) (nil fontified nil 1122 . 1133) (nil fontified nil 1100 . 1122) (nil fontified nil 1096 . 1100) (nil fontified nil 1095 . 1096) (nil fontified nil 1090 . 1095) (nil fontified nil 1026 . 1090) (nil fontified nil 1008 . 1026) (nil fontified nil 1004 . 1008) (nil fontified nil 967 . 1004) (nil fontified nil 963 . 967) (nil fontified nil 904 . 963) (nil fontified nil 900 . 904) (nil fontified nil 899 . 900) (nil fontified nil 894 . 899) (nil fontified nil 858 . 894) (nil fontified nil 854 . 858) (nil fontified nil 853 . 854) (nil fontified nil 847 . 853) (nil fontified nil 832 . 847) (nil fontified nil 828 . 832) (nil fontified nil 827 . 828) (nil fontified nil 818 . 827) (nil fontified nil 817 . 818) (nil fontified nil 814 . 817) (nil fontified nil 805 . 814) (nil fontified nil 799 . 805) (nil fontified nil 785 . 799) (nil fontified nil 781 . 785) (nil fontified nil 746 . 781) (nil fontified nil 742 . 746) (nil fontified nil 741 . 742) (nil fontified nil 735 . 741) (nil fontified nil 645 . 735) (nil fontified nil 641 . 645) (nil fontified nil 640 . 641) (nil fontified nil 638 . 640) (nil fontified nil 623 . 638) (nil fontified nil 619 . 623) (nil fontified nil 618 . 619) (nil fontified nil 597 . 618) (nil fontified nil 596 . 597) (nil fontified nil 593 . 596) (nil fontified nil 581 . 593) (nil fontified nil 575 . 581) (nil fontified nil 558 . 575) (nil fontified nil 548 . 558) (nil fontified nil 528 . 548) (nil fontified nil 519 . 528) (nil fontified nil 502 . 519) (nil fontified nil 494 . 502) (nil fontified nil 492 . 494) (nil fontified nil 486 . 492) (nil fontified nil 483 . 486) (nil fontified nil 472 . 483) (nil fontified nil 465 . 472) (nil fontified nil 463 . 465) (nil fontified nil 453 . 463) (nil fontified nil 445 . 453) (nil fontified nil 441 . 445) (nil fontified nil 422 . 441) (nil fontified nil 418 . 422) (nil fontified nil 417 . 418) (nil fontified nil 403 . 417) (nil fontified nil 402 . 403) (nil fontified nil 399 . 402) (nil fontified nil 377 . 399) (nil fontified nil 366 . 377) (nil fontified nil 365 . 366) (nil fontified nil 360 . 365) (nil fontified nil 356 . 360) (nil fontified nil 346 . 356) (nil fontified nil 344 . 346) (nil fontified nil 334 . 344) (nil fontified nil 332 . 334) (nil fontified nil 323 . 332) (nil fontified nil 321 . 323) (nil fontified nil 310 . 321) (nil fontified nil 308 . 310) (nil fontified nil 300 . 308) (nil fontified nil 298 . 300) (nil fontified nil 292 . 298) (nil fontified nil 275 . 292) (nil fontified nil 269 . 275) (nil fontified nil 267 . 269) (nil fontified nil 262 . 267) (nil fontified nil 260 . 262) (nil fontified nil 253 . 260) (nil fontified nil 251 . 253) (nil fontified nil 244 . 251) (nil fontified nil 242 . 244) (nil fontified nil 232 . 242) (nil fontified nil 230 . 232) (nil fontified nil 221 . 230) (nil fontified nil 219 . 221) (nil fontified nil 217 . 219) (nil fontified nil 213 . 217) (nil fontified nil 203 . 213) (203 . 1320) nil (#("MONTH_NAME = ['', 'January', 'February', 'March', 'April', 'May', 'June', 
              'July', 'August', 'September', 'October', 'November', 'December'];

class NoteManager(models.Manager):
    def get_title_list(self):
        notes = self.values('pub_date', 'title');
        for note in notes:
            note['enmonth'] = MONTH_NAME[note['pub_date'].month]
        return notes

    def get_specific_pub_date(self, dt):
        if self.filter(pub_date=dt).count():
            dt += datetime.timedelta(seconds=1)
            return self.get_specific_pub_date(dt)
        else:
            return dt

    def get_index(self, dt):
        return self.filter(pub_date__gte=dt).count()


class Note(models.Model):
    pub_date = models.DateTimeField(unique=True)
    title = models.CharField(blank=True, max_length=128)
    body = models.TextField()

    objects = NoteManager()

    class Meta:
        ordering = ('-pub_date',)

    def __unicode__(self):
        return \"%s\" % self.pub_date

    def _get_enmonth(self):
        return MONTH_NAME[self.pub_date.month]

    enmonth = property(_get_enmonth)
    

" 0 10 (fontified t face font-lock-variable-name-face) 10 14 (fontified t) 14 16 (fontified t face font-lock-string-face) 16 18 (fontified t) 18 27 (fontified t face font-lock-string-face) 27 29 (fontified t) 29 39 (fontified t face font-lock-string-face) 39 41 (fontified t) 41 48 (fontified t face font-lock-string-face) 48 50 (fontified t) 50 57 (fontified t face font-lock-string-face) 57 59 (fontified t) 59 64 (fontified t face font-lock-string-face) 64 66 (fontified t) 66 72 (fontified t face font-lock-string-face) 72 89 (fontified t) 89 95 (fontified t face font-lock-string-face) 95 97 (fontified t) 97 105 (fontified t face font-lock-string-face) 105 107 (fontified t) 107 118 (fontified t face font-lock-string-face) 118 120 (fontified t) 120 129 (fontified t face font-lock-string-face) 129 131 (fontified t) 131 141 (fontified t face font-lock-string-face) 141 143 (fontified t) 143 153 (fontified t face font-lock-string-face) 153 157 (fontified t) 157 162 (fontified t face font-lock-keyword-face) 162 163 (fontified t) 163 174 (fontified t face font-lock-type-face) 174 196 (fontified t) 196 199 (fontified t face font-lock-keyword-face) 199 200 (fontified t) 200 214 (fontified t face font-lock-function-name-face) 214 215 (fontified t) 215 219 (fontified t face font-lock-keyword-face) 219 238 (fontified t) 238 242 (fontified t face font-lock-keyword-face) 242 250 (fontified t) 250 260 (fontified t face font-lock-string-face) 260 262 (fontified t) 262 269 (fontified t face font-lock-string-face) 269 280 (fontified t) 280 283 (fontified t face font-lock-keyword-face) 283 289 (fontified t) 289 291 (fontified t face font-lock-keyword-face) 291 299 (fontified t) 299 316 (fontified t) 316 325 (fontified t face font-lock-string-face) 325 345 (fontified t) 345 355 (fontified t face font-lock-string-face) 355 372 (fontified t) 372 378 (fontified t face font-lock-keyword-face) 378 390 (fontified t) 390 393 (fontified t face font-lock-keyword-face) 393 394 (fontified t) 394 415 (fontified t face font-lock-function-name-face) 415 416 (fontified t) 416 420 (fontified t face font-lock-keyword-face) 420 435 (fontified t) 435 437 (fontified t face font-lock-keyword-face) 437 438 (fontified t) 438 442 (fontified t face font-lock-keyword-face) 442 532 (fontified t) 532 538 (fontified t face font-lock-keyword-face) 538 539 (fontified t) 539 543 (fontified t face font-lock-keyword-face) 543 578 (fontified t) 578 582 (fontified t face font-lock-keyword-face) 582 596 (fontified t) 596 602 (fontified t face font-lock-keyword-face) 602 611 (fontified t) 611 614 (fontified t face font-lock-keyword-face) 614 615 (fontified t) 615 624 (fontified t face font-lock-function-name-face) 624 625 (fontified t) 625 629 (fontified t face font-lock-keyword-face) 629 644 (fontified t) 644 650 (fontified t face font-lock-keyword-face) 650 651 (fontified t) 651 655 (fontified t face font-lock-keyword-face) 655 691 (fontified t) 691 696 (fontified t face font-lock-keyword-face) 696 697 (fontified t) 697 701 (fontified t face font-lock-type-face) 701 760 (fontified t) 760 764 (fontified t face font-lock-keyword-face) 764 801 (fontified t) 801 805 (fontified t face font-lock-keyword-face) 805 823 (fontified t) 823 887 (fontified t) 887 892 (fontified t face font-lock-keyword-face) 892 893 (fontified t) 893 897 (fontified t face font-lock-type-face) 897 919 (fontified t) 919 930 (fontified t face font-lock-string-face) 930 938 (fontified t) 938 941 (fontified t face font-lock-keyword-face) 941 942 (fontified t) 942 953 (fontified t face font-lock-function-name-face) 953 954 (fontified t) 954 958 (fontified t face font-lock-keyword-face) 958 969 (fontified t) 969 975 (fontified t face font-lock-keyword-face) 975 976 (fontified t) 976 980 (fontified t face font-lock-string-face) 980 983 (fontified t) 983 987 (fontified t face font-lock-keyword-face) 987 1002 (fontified t) 1002 1005 (fontified t face font-lock-keyword-face) 1005 1006 (fontified t) 1006 1018 (fontified t face font-lock-function-name-face) 1018 1019 (fontified t) 1019 1023 (fontified t face font-lock-keyword-face) 1023 1034 (fontified t) 1034 1040 (fontified t face font-lock-keyword-face) 1040 1052 (fontified t) 1052 1056 (fontified t face font-lock-keyword-face) 1056 1088 (fontified t) 1088 1096 (fontified t face font-lock-builtin-face) 1096 1117 (fontified t)) . -732) (t 20604 . 44888) ((marker . 1) . -299) ((marker) . -689) ((marker) . -689) ((marker . 54) . -690) ((marker . 54) . -690) ((marker . 25) . -691) ((marker . 25) . -691) ((marker . 24) . -717) ((marker . 24) . -717) ((marker . 1) . -766) ((marker . 1) . -766) ((marker) . -823) ((marker) . -823) ((marker) . -853) ((marker) . -853) ((marker) . -854) ((marker) . -854) ((marker) . -882) ((marker) . -882) ((marker) . -883) ((marker) . -883) ((marker) . -899) ((marker) . -899) ((marker) . -933) ((marker) . -933) ((marker) . -934) ((marker) . -934) ((marker) . -961) ((marker) . -961) ((marker) . -997) ((marker) . -997) ((marker) . -998) ((marker) . -998) ((marker) . -1026) ((marker) . -1026) ((marker) . -1073) ((marker) . -1073) ((marker) . -1074) ((marker) . -1074) ((marker) . -1111) ((marker) . -1111) ((marker) . -1116) ((marker) . -1116) ((marker) . -1117) ((marker) . -1117)))