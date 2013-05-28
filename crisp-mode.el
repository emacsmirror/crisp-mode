;;; crisp-mode.el --- Major mode for Crisp code.

;; Copyright 2013 Kris Jenkins

;; Author: Kris Jenkins <krisajenkins@gmail.com>
;; Maintainer: Kris Jenkins <krisajenkins@gmail.com>
;; Author: Kris Jenkins
;; URL: https://github.com/krisajenkins/crisp-mode
;; Created: 18th April 2013
;; Version: 0.1.0
;; Package-Requires: ((clojure-mode "0"))

;;; Commentary:
;;
;; A major mode for the Lisp->JavaScript language Crisp: http://jeditoolkit.com/crisp/

(require 'clojure-mode)
(require 'font-lock)

(defmacro crispscript-mode/add-word-chars (&rest chars)
  "Convenient way to add many word-constituent characters to the syntax table.

Optional argument CHARS Characters to add to the syntax table."
  (cons 'progn
        (mapcar (lambda (char)
                  `(modify-syntax-entry ,char "w" crisp-mode-syntax-table))
                chars)))

;;;###autoload
(define-derived-mode crisp-mode clojure-mode "Crisp"
  "Major mode for Crisp"
  (crispscript-mode/add-word-chars ?_ ?~ ?. ?- ?> ?< ?! ??)
  (add-to-list 'comint-prompt-regexp "=>")
  (add-to-list 'comint-preoutput-filter-functions (lambda (output)
						           (replace-regexp-in-string "\033\\[[0-9]+[GJK]" "" output)))
  (set (make-local-variable 'inferior-lisp-program) "crisp"))

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.crisp\\'" 'crisp-mode))

(provide 'crisp-mode)
;;; crisp-mode.el ends here
