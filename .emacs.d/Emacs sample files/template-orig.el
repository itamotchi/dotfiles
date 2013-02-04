;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; template.el --- Routines for generating smart skeletal templates for
;;                 files and functions.
;; Author          : James Elliott, jim@brunchboy.com
;; Created On      : Tue Oct 23 19:57:40 1990, based on my rcs.el
;; Last Modified By: James Elliott
;; Last Modified On: Fri Dec 20 17:32:43 2002
;; Update Count    : 34
;; Status          : Production
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;  Written by James J. Elliott
;;  5395 Computer Sciences & Statistics
;;  University of Wisconsin--Madison
;;  1210 W. Dayton St.
;;  Madison, WI 53715

;; Copyright (C) 1990 James J. Elliott

;; This file is not officially part of GNU Emacs, but may be
;; donated to the Free Software Foundation.  As such, it is
;; subject to the standard GNU-Emacs General Public License,
;; referred to below.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY.  No author or distributor
;; accepts responsibility to anyone for the consequences of using it
;; or for whether it serves any particular purpose or works at all,
;; unless he says so in writing.  Refer to the GNU Emacs General Public
;; License for full details.

;; Everyone is granted permission to copy, modify and redistribute
;; GNU Emacs, but only under the conditions described in the
;; GNU Emacs General Public License.   A copy of this license is
;; supposed to have been given to you along with GNU Emacs so you
;; can know your rights and responsibilities.  It should be in a
;; file named COPYING.  Among other things, the copyright notice
;; and this notice must be preserved on all copies.

(defvar allow-template-evals nil
  "*Since evaluating arbitrary LISP code can be a potential security
risk, %eval directives in templates will be ignored unless the
variable allow-template-evals is t. It defaults to nil. If you choose
to enable it, be sure to inspect any template files you plan to use!")


(defvar template-file-name "file-template"
  "*The name of the file to look for when a find-file request fails. If a
file with the name specified by this variable exists, offer to use it as
a template for creating the new file.")


(defvar function-template-file-name "function-template"
  "*The name of the file to look for in (insert-function-template).")


(defvar template-replacements-alist
  '(("%filename%" . (lambda ()
		      (file-name-nondirectory 
		       (get 'template-function-attributes 'filename))))
    ("%creator%" . user-full-name)
    ("%author%" . user-full-name)
    ("%date%" . current-time-string)
    ("%funcname%" . (lambda () (get 'template-function-attributes 'name)))
    ("%functype%" . (lambda () (get 'template-function-attributes 'kind)))
    ("%once%" . (lambda () (template-insert-include-once)))
    ("%package%" . (lambda () (template-insert-java-package)))
    ("%class%" . (lambda () (template-insert-class-name)))
   )
  "A list which specifies what substitutions to perform upon loading a
template file. Each list element consists of a string, which is the target
to be replaced if it is found in the template, paired with a function,
which is called to generate the replacement value for the string. Note that
the target %args% is not in this list, but is handled specially by
(insert-function-template).")


(defvar template-function-attributes nil
  "This is used to record any interesting information parsed out of a
function definition when a header is being generated for it.")


(defvar default-function-attributes
  '(name "" args "None." kind "Function" filename "<<no file>>")
  "The default values for the property list of template-function-attributes,
in case the functions described in template-function-patterns choose not to
set some of the properties.")


(defvar template-function-patterns
  '(((c-mode c++-mode)
     "\\s-*\\(inline\\|extern\\|static\\)?[^;({]+\\s-\\**\\s-*\\(\\(\\w\\|_\\)+\\)\\s-*(\\(.*\\))\\s-*[^;]"
     snarf-standard-c-function)
    ((c-mode c++-mode)
     "\\s-*\\([^;({]+\\s-\\**\\s-*\\)?\\(\\(\\(\\w\\|_\\)+\\)::\\(\\(\\w\\|_\\|~\\|\\[\\|\\]\\)+\\)\\)\\s-*(\\(.*\\))\\s-*[^;]"
     snarf-c++-method)
  )
  "This complicated list tells how to identify the starts of functions
in various languages. It is a list of three-part tuples, each of which
specifies how to act in a given context.

The first element of each tuple is a list of modes in which this
pattern should be tried. If the current mode is different from all of
these, the tuple is considered to have failed, and the next one is
tried.

The second element is a hairy regular expression which matches the
beginning of a function definition that one might expect to find in
the current mode. It will be used as an argument to (looking-at). If
the regular expression fails, again the tuple is considered to have
failed.

The function specified as the third element of the tuple is called if
everything else succeeded. The regular expression should have set up
sub-matches in such a way that this function can extract relevant
parts of the matched function's definition, such as its name,
arguments, etc. When called, it should set up the properties of the
variable template-function-attributes based on these sub-matches.

It's probably best to study the examples given in the source file to
understand all this.")


(defun template-process-evals ()

  "Called when a template file has just been inserted.  Scans the
buffer for lines containing evaluation directives, and executes them.
This should really only be used if you know what you're doing because
it will blindly try to execute the code contained in the directive as
Emacs LISP within the context of the calling routine.

An evaluation directive must all be on one line (which may be as long
as needed, that is, it need not fit on one SCREEN line), and has the
form:

%eval <lisp code>%

Note that it must be the only thing on the line, and must start and end with
a percent sign. The line will be deleted from the file before the code is
evaluated, and the point will be at the beginning of the next line.

Since evaluating arbitrary LISP code can be a potential security risk, this
function will not do anything unless the variable allow-template-evals is
t. It defaults to nil. If you choose to enable it, be sure to inspect any
template files you plan to use!"

  (let (command)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^%eval \\(.*\\)%\n" nil t nil)
	(setq command (buffer-substring (match-beginning 1) (match-end 1)))
	(delete-region (match-beginning 0) (match-end 0))
	(if allow-template-evals
	    (eval (read command))
	  (message (concat "Ignoring command " command))
	  (sit-for 2))
      )
    )
  )
)


(defun find-template-file ()

  "Searches the current directory and its parents for a file matching
the name configured for template files. The name of the first such
readable file found is returned, allowing for hierarchical template
configuration. A template file with the same extension as the file
being loaded (using a \"-\" instead of a \".\" as the template file's
delimiter, to avoid confusing other software) will take precedence
over an extension-free, generic template."

  (let ((path (file-name-directory (buffer-file-name)))
	(ext (file-name-extension (buffer-file-name)))
	attempt result)

    (while (and (not result) (> (length path) 0))
      (setq attempt (concat path template-file-name "-" ext))
      (if (file-readable-p attempt)
	  (setq result attempt)
	(setq attempt (concat path template-file-name))
	(if (file-readable-p attempt)
	    (setq result attempt)
	  (setq path (if (string-equal path "/")
			 ""
		       (file-name-directory (substring path 0 -1))))
        )
      )
    )
    result
  )
)


(defun template-file-not-found-hook ()

  "Called when a find-file command has not been able to find the specified
file in the current directory. Sees if it makes sense to offer to start it
based on a template."
  (condition-case nil
      (if (and (find-template-file)
	       (y-or-n-p "Start with template file? "))
	  (progn (buffer-disable-undo)
		 (insert-file (find-template-file))
		 (goto-char (point-min))
		 ;; Provide the buffer's file name
		 (setplist 'template-function-attributes
			   (copy-sequence default-function-attributes))
		 (if (buffer-file-name)
		     (put 'template-function-attributes 'filename
			  (buffer-file-name)))

		 ;; Magically do the variable substitutions
		 (let ((the-list template-replacements-alist))
		   (while the-list
		     (goto-char (point-min))
		     (replace-string (car (car the-list))
				     (funcall (cdr (car the-list)))
				     nil)
		     (setq the-list (cdr the-list))))
		 (template-process-evals)
		 (goto-char (point-min))
		 (buffer-enable-undo)
		 (set-buffer-modified-p nil)
	  )
      )
    ;; This is part of the condition-case; it catches the situation where
    ;; the user has hit C-g to abort the find-file (since they realized
    ;; that they didn't mean it) and deletes the buffer that has already
    ;; been created to go with that file, since it will otherwise become
    ;; mysterious clutter they may not even know about.
    ('quit (kill-buffer (current-buffer))
	  (signal 'quit "Quit"))
  )
)

; Install the above routine
(or (memq 'template-file-not-found-hook find-file-not-found-hooks)
      (setq find-file-not-found-hooks
            (append find-file-not-found-hooks '(template-file-not-found-hook)))
)

(defun snarf-standard-c-function ()
  "Called when something matching the pattern of a C function definition has
been found after point during the insertion of a function template. Extracts
the relevant portions of that definition and stores them in case they are
needed for substitutions into the template."

  (let (args)
    (goto-char (match-beginning 1)) ;Move to right before start

    ;; Extract the name
    (put 'template-function-attributes 'name
	 (buffer-substring (match-beginning 2) (match-end 2)))

    ;; Extract the arguments
    (setq args
	  (buffer-substring (match-beginning 4) (match-end 4)))
    ;; Massage args list into format I want
    (if (or (zerop (length args)) (equal args "void"))
	(setq args nil))
    (if args (put 'template-function-attributes 'args args))
  )
)


(defun snarf-c++-method ()
  "Called when something matching the pattern of a C++ method definition has
been found after point during the insertion of a function template. Extracts
the relevant portions of that definition and stores them in case they are
needed for substitutions into the template."
  
  (put 'template-function-attributes 'kind "Method")

  (let (args funcname)
    (if (match-beginning 1) ;Move to right before start
	(goto-char (match-beginning 1))  ; Type present
      (goto-char (match-beginning 2)))   ; No type present
    
    ;; Extract the method name
    (setq funcname (buffer-substring (match-beginning 2)
				     (match-end 2)))
    ;; Flag routine as a constructor if it is
    (if (string-equal (buffer-substring (match-beginning 3)
					(match-end 3))
		      (buffer-substring (match-beginning 5)
					(match-end 5)))
	(setq funcname (concat funcname "  (Constructor)")))
    ;; Flag routine as a destructor if it is
    (if (string-equal (buffer-substring (match-beginning 5)
					(match-end 5))
		      (concat "~"
			      (buffer-substring (match-beginning 3)
						(match-end 3))))
	(setq funcname (concat funcname "  (Destructor)")))
						
    ;; Extract the arguments
    (setq args (buffer-substring (match-beginning 7) (match-end 7)))
    ;; Massage args list into format I want
    (if (or (zerop (length args)) (equal args "void"))
	(setq args nil))

    (put 'template-function-attributes 'name funcname)
    (if args (put 'template-function-attributes 'args args))
  )
)

(defun insert-function-template ()
  "Inserts the contents of the function-template-file into the current
buffer. If it can figure out the structure of the function definition
which may follow point, it will use it to determine information about
the function, which may be used for variable substitutions in the
template."

  (interactive "")

  (if (null (file-readable-p function-template-file-name))
      (error (concat "Template file \"" function-template-file-name
		     "\" doesn't exist.")))

  (let ((buf (get-buffer-create "*template-temp*"))
	(dir default-directory)
	(oldbuf (current-buffer))
	(the-list template-function-patterns)
	args argprefix argsuffix)

    ;; Start assuming no information about the function being defined
    (setplist 'template-function-attributes
	      (copy-sequence default-function-attributes))
    (if (buffer-file-name)
	(put 'template-function-attributes 'filename (buffer-file-name)))

    ;;If the cursor is poised before the start of a function, steal some
    ;;information from the definition.
    (while the-list
      (if (and (memq major-mode (car (car the-list)))
	       (looking-at (car (cdr (car the-list)))))
	  (progn
	    (funcall (car (cdr (cdr (car the-list)))))
	    (setq the-list nil))		; Done
	(setq the-list (cdr the-list))))	; Try next

    ;; Now get the contents of the template file
    (delete-windows-on buf)
    (set-buffer buf)
    (setq default-directory dir)
    (erase-buffer)
    (insert-file function-template-file-name)

    ;; Do magic to customize the template
    (template-process-evals)
    (setq the-list template-replacements-alist)
    (while the-list
      (goto-char (point-min))
      (replace-string (car (car the-list))
		      (funcall (cdr (car the-list)))
		      nil)
      (setq the-list (cdr the-list))
    )

    ;; Handle special case of %args%, so each argument gets its own line.
    (goto-char (point-min))
    (if (re-search-forward "%args%" nil t nil)
	(progn
	  (delete-region (match-beginning 0) (match-end 0))
	  (beginning-of-line)
	  (setq argprefix (buffer-substring (match-beginning 0) (point)))
	  (end-of-line)
	  (setq argsuffix (buffer-substring (match-end 0) (point)))
	  (goto-char (match-beginning 0))
	  (insert (get 'template-function-attributes 'args))
	  (goto-char (match-beginning 0))
	  (while (looking-at "[^,\n]*\\(,[ \t]*\\)")
	    (delete-region (match-beginning 1) (match-end 1))
	    (goto-char (match-end 1))
	    (insert argsuffix)
	    (goto-char (match-beginning 1))
	    (newline)
	    (insert argprefix)
          )
        )
     )
    
    (set-buffer oldbuf)
    (insert-buffer buf)
    (kill-buffer buf)
  )
)

(defun template-insert-include-once ()

  "Returns preprocessor directives such that the file will be included
only once during a compilation process which includes it an
abitrary number of times."
  
  (let ((name (file-name-nondirectory 
	       (get 'template-function-attributes 'filename)))
	basename)
    (if (string-match ".h$" name)
	(progn
	  (setq basename (upcase (substring name 0 -2)))
	  (concat "#ifndef _H_" basename "\n#define _H_" basename
		  "\n\n\n#endif   /* not defined _H_" basename " */\n")
	 )
      "" ; the "else" clause, returns an empty string.
    )
  )
)

(defun template-insert-java-package ()

  "Inserts an appropriate Java package directive based on the path to
the current file name (assuming that it is in the com, org or net
subtree). If no recognizable package path is found, inserts nothing."

  (let ((name (file-name-directory (get 'template-function-attributes
					'filename)))
	result)
    (if (string-match "/\\(com\\|org\\|net\\)/.*/$" name)
	(progn
	  (setq result (substring name (+ (match-beginning 0) 1)
				  (- (match-end 0) 1)))
	  (while (string-match "/" result)
	    (setq result (concat (substring result 0 (match-beginning 0))
				 "."
				 (substring result (match-end 0)))))
	  (concat "package " result ";"))
      "")
  )
)

(defun template-insert-class-name ()

  "Inserts the name of the java class being defined in the current file,
based on the file name. If not a Java source file, inserts nothing."

  (let ((name (file-name-nondirectory (get 'template-function-attributes
					   'filename))))
    (if (string-match "\\(.*\\)\\.java" name)
	(substring name (match-beginning 1) (match-end 1))
      ""
    )
  )
)

; Local maps can override this if they want, since C-c is usually a local
; prefix.
(global-set-key "h" 'insert-function-template)

(provide 'template)
