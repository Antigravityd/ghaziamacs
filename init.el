;;; init.el --- Gaz's Ideal Emacs                    -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Duncan Wilkie

;; Author: Duncan Wilkie <duncannwilkie@gmail.com>
;; Keywords:
;;; emacs emacs-doom-modeline emacs-girly-notebook-theme emacs-dashboard
;;; emacs-ligature emacs-rainbow-delimiters emacs-smartparens emacs-paren
;;; emacs-ws-butler emacs-hl-todo emacs-vertico emacs-nerd-icons-completion
;;; emacs-corfu emacs-kind-icon emacs-orderless emacs-consult
;;; emacs-consult-eglot emacs-marginalia emacs-vlf emacs-dired
;;; emacs-dired-single emacs-nerd-icons-dired emacs-diredfl emacs-vterm
;;; emacs-no-littering emacs-helpful emacs-which-key emacs-inform
;;; emacs-projectile emacs-magit emacs-proof-general emacs-pdf-tools
;;; font-iosevka-ss05 font-iosevka-aile font-victor-mono


(setq gc-cons-threshold (* 50 1000 1000))

(setq package-archives nil)
(add-to-list 'load-path (concat user-emacs-directory "/packages")) ; might be wrong?

(menu-bar-mode -1)
(tool-bar-mode -1)
;; (scroll-bar-mode -1)
;; (tooltip-mode -1)
(set-fringe-mode 10)

(column-number-mode)

;; Display line numbers in the left margin, as a general rule,
(global-display-line-numbers-mode t)

;; but disable them where they just add clutter, e.g. shell.
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                eshell-mode-hook
                Info-mode-hook
                ement-room-mode-hook
                elfeed-show-mode-hook
                doc-view-mode-hook
                pdf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Enable on-screen globally.
;(global-on-screen-mode t)

;; Modeline clock and CPU load level.
(display-time)

(use-package doom-modeline
  :config (doom-modeline-mode 1))


(use-package girly-notebook-theme)
;; Modify-face background

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-banner-logo-title "") ; TODO something cute here
  (setq dashboard-center-content t)
  (setq dashboard-image-banner-max-width 600)
  (setq dashboard-startup-banner "~/.emacs.d/crystals8.png") ; TODO pretty image here
  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons))

(global-prettify-symbols-mode t)

;; ligature
(use-package ligature
  :config
  (global-ligature-mode t)
  (ligature-set-ligatures
   '(prog-mode org-mode)
   '("-<<" "-<" "-<-" "<--" "<---" "<<-" "<-" "->" "->>" "-->" "--->" "->-" ">-" ">>-"
     "=<<" "=<" "=<=" "<==" "<===" "<<=" "<=" "=>" "=>>" "==>" "===>" "=>=" ">=" ">>="
     "<->" "<-->" "<--->" "<---->" "<=>" "<==>" "<===>" "<====>" "::" ":::" "__"
     "<~~" "</" "</>" "/>" "~~>" "==" "!=" "/=" "~=" "<>" "===" "!==" "!===" "=/=" "=!="
     "<:" ":=" "*=" "*+" "<*" "<*>" "*>" "<|" "<|>" "|>" "<." "<.>" ".>" "+*" "=*" "=:" ":>"
     "(*" "*)" "/*" "*/" "[|" "|]" "{|" "|}" "++" "+++" "\\/" "/\\" "|-" "-|" "<!--" "<!---")))


(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :hook ((prog-mode . rainbow-delimiters-mode)
         (LaTeX-mode . rainbow-delimiters-mode)))

;; This will automatically create matched pairs whenever open delimiters are typed,
;; highlight unmatched closing delimiters, etc.
(use-package smartparens
  :commands smartparens-mode
  :hook ((prog-mode . smartparens-mode)
         (LaTeX-mode . smartparens-mode)
         (org-mode . smartparens-mode))
  :config
  (require 'smartparens-latex))

;; Built-in that'll highlight the counterpart to whichever paren your cursor is over.
(use-package paren
  :config
  (set-face-attribute 'show-paren-match-expression nil :background "#363e4a")
  (show-paren-mode t))

(setq tab-always-indent 'complete)
(setq align-to-tab-stop nil)

;; Require files to end in newlines
(setq require-final-newline t)

;; Enforce a line-length limit.
(setq fill-column 140) ;; Chosen to fit nicely at my font-size on 4:3.
(auto-fill-mode t)

;; Trim trailing line whitespace on save.
(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))

;; Ispell?

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config (global-hl-todo-mode)
  :bind (("C-c t p" . hl-todo-previous)
         ("C-c t n" . hl-todo-next)
         ("C-c t o" . hl-todo-occur)
         ("C-c t i" . hl-todo-insert)))

;; textsec?


(use-package vertico
  :config (vertico-mode)
  :custom
  ;; Wrap completions at the top and bottom of the list.
  (vertico-cycle t))

;; Add nice icons from DOOM's nerd-fonts from earlier to minibuffer completions.
(use-package nerd-icons-completion)

(use-package corfu
  :custom (corfu-cycle t)
  :config (global-corfu-mode))

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ;; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Workaround for weird interaction between svg-lib and ement:
(defun first-graphical-frame-hook-function ()
  (remove-hook 'focus-in-hook #'first-graphical-frame-hook-function)
  (provide 'my-gui))

(add-hook 'focus-in-hook #'first-graphical-frame-hook-function)
(with-eval-after-load 'my-gui
  (setq svg-lib-style-default (svg-lib-style-compute-default)))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic) ;; basic is required for TRAMP hostname completion
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-r" . consult-history)
         ("C-c i" . consult-imenu)
         ("C-x b" . consult-buffer)
         ("C-x r b" . consult-bookmark)
         ("C-x r i" . consult-register)
         ("C-+" . consult-mark))
  :custom (completion-in-region-function #'consult-completion-in-region))

(use-package consult-eglot
  :commands consult-eglot-symbols
  :after eglot)

(use-package marginalia
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;;; Necessary?
(use-package eglot
  :commands eglot
  :hook ((python-mode . eglot-ensure)
         (haskell-mode . eglot-ensure)
         ;; (c-mode . eglot-ensure) (c++-mode . eglot-ensure)
         ))


;; Better long-line support.
(global-so-long-mode t)

;; Better large-file viewing: call M-x vlf.
;; (use-package vlf
;;   :commands vlf)

;; Saving a file with a shebang will make it executable.
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)


(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-ahgo --group-directories-first")))

;; Prevents dired from dirtying the buffer list with directories.
(use-package dired-single
  :after dired)

;; Use the nerd-fonts installed with the DOOM UI elements for file icons.
(use-package nerd-icons-dired
  :after dired)

;; Nice colors.
(use-package diredfl
  :after dired
  :config (diredfl-global-mode))

(use-package vterm
  :config (define-key vterm-mode-map (kbd "C-q") #'vterm-send-next-key)
  ;; :ensure-system-package (cmake ("/usr/lib/libvterm.so.0" . libvterm) libtool)
  )

(use-package no-littering
  :config
  (setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))


;; Binaries on the shell path become accessible to Emacs automatically.
(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-variables '("PATH" "MANPATH" "PHITSPATH"))
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


;; Souped-up `C-h` interface.
(use-package helpful
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key)
  ([remap describe-symbol] . helpful-symbol)
  :hook (helpful-mode . (lambda () (display-line-numbers-mode -1)))
  :config
  (setq helpful-max-buffers 1)) ;; Otherwise, litters buffer list way too much.


;; In case of brain fart: display possible prefix key follow-ups if idle for too long.
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))


;; I don't like the navigation display at the top of Info buffers
(setq Info-use-header-line nil)

;; Turns symbols in Info mode into links to their documentation
(use-package inform)

(defun dnw/woman-visual-fill ()
  (display-line-numbers-mode -1)
  (setq visual-fill-column-width 80
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package woman
  :hook (woman-mode . dnw/woman-visual-fill))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'vertico))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~")
    (setq projectile-project-search-path '("~")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Display Git modification dates and commit messages in dired.
;; TODO: maybe not?
;; (use-package dired-git-info
;;   :after dired
;;   :bind (:map dired-mode-map
;;               (")" . dired-git-info-mode))
;;   :config (setq dgi-auto-hide-details-p nil)
;;   :hook (dired-after-readin . dired-git-info-auto-enable))

(use-package proof-general)


(use-package pdf-tools
  :commands pdf-view-mode
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook ((pdf-view-mode . pdf-view-themed-minor-mode)
         (pdf-view-mode . (lambda () (display-line-numbers-mode -1) (auto-revert-mode))))
  :config
  (pdf-loader-install))


(use-package gcmh)

(setq gc-cons-threshold (* 2 1000 1000))
