;; init.el -*- lexical-binding: t; -*-

(doom! :input
       ;;chinese
       ;;japanese
       ;;layout            ; auie,39% (osak)

       :completion
       company           ; the standard auto-complete
       ivy               ; a search engine for love and life
       ;helm              ; the giant search engine
       ;vertico           ; the modern alternative to ivy/helm

       :ui
       doom              ; what makes it look like doom
       doom-dashboard    ; a nice splash screen
       hl-todo           ; highlight TODO/FIXME/etc
       modeline          ; a snack bar at the bottom
       ophints           ; hints for common operations
       vc-gutter         ; vcs diff in the margin
       vi-tilde-fringe   ; fringes for vim users
       window-select     ; visually switch windows

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       snippets          ; my eyes bloomed in 1927

       :emacs
       dired             ; making dired pretty [functional]
       undo              ; persistent, smarter undo
       vc                ; version-control and friends

       :term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax            ; tasing you for your typos
       (spell +flyspell) ; tasing you for your misspelling

       :tools
       magit             ; a git porcelain for Emacs
       lookup            ; navigate your code and its docs

       :lang
       emacs-lisp        ; lang: emacs-lisp
       markdown          ; writing docs for humans
       org               ; organize your plain life in plain text
       (python +lsp)     ; writing python code
       sh                ; she-selling shell scripts

       :config
       (default +smartparens))
