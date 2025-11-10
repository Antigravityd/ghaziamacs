
(define-module (ghaziamacs)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module (guix licenses)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages fonts))


(define-public emacs-girly-notebook-theme
  (package
    (name "emacs-girly-notebook-theme")
    (version "20240513.1344")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/melissaboiko/girly-notebook-theme")
             (commit "29203696a4fe54ce90ccb765962b38fadbff9ea8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1jiwpvmnyxwzxn6mgxkijiinv9bmipr8ky71jlj3v49c3164dz4a"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/melissaboiko/girly-notebook-theme")
    (synopsis "A light theme with vivid colours and cursive text")
    (description
     "This package provides a light theme with vivid colours and cursive text.
Inspired by schoolgirl notebooks and chee's lychee-theme.el .  Requires the
following system fonts to be installed: - Iosevka SS05 - Iosevka Aile - Victor
Mono Notice that different fonts might not align in monospace.  If you customise
the fonts, I recommend using my package `show-font-mode to compare glyph pixel
sizes and adjust face proportions until their pixel width is the same.  The
faces used as bases for most others are: `default', `italic', `variable-pitch
and `bold-italic'.")
    (license gpl3+)))


(define-public emacs-nerd-icons-completion
  (package
    (name "emacs-nerd-icons-completion")
    (version "20251029.2106")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/rainstormstudio/nerd-icons-completion")
             (commit "d09ea987ed3d2cc64137234f27851594050e2b64")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "022yfkfvcywgjplvsj5xajmc24q1c7yx0l5mvnzagjfdg4iajidv"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-nerd-icons emacs-compat))
    (home-page "https://github.com/rainstormstudio/nerd-icons-completion")
    (synopsis "Add icons to completion candidates")
    (description
     "Add nerd-icons to completion candidates.  nerd-icons-completion is inspired by
`all-the-icons-completion': https://github.com/iyefrat/all-the-icons-completion.")
    (license #f)))

(define-public emacs-nerd-icons-dired
  (package
    (name "emacs-nerd-icons-dired")
    (version "20251106.1840")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/rainstormstudio/nerd-icons-dired")
             (commit "3265d6c4b552eae457d50d423adb10494113d70b")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1kkpw59xflz4i0jdg5rdw84lggjqjy2k03yilpa19a5allvar63s"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-nerd-icons))
    (home-page "https://github.com/rainstormstudio/nerd-icons-dired")
    (synopsis "Shows icons for each file in dired mode")
    (description
     "To use this package, simply install and add this to your init.el (require
nerd-icons-dired) (add-hook dired-mode-hook nerd-icons-dired-mode) or use
use-package: (use-package nerd-icons-dired :hook (dired-mode .
nerd-icons-dired-mode)) This package is inspired by - `all-the-icons-dired':
https://github.com/jtbm37/all-the-icons-dired.")
    (license #f)))

(define-public emacs-proof-general
  (package
    (name "emacs-proof-general")
    (version "20251105.741")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ProofGeneral/PG")
             (commit "c366365aaddeb3a65dc0816c8f93ec209dc9de44")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0q1hq1fp770a25dk2sfr2p6y8cj9mzvx75pzx2q5cj71jbs9chkn"))))
    (build-system emacs-build-system)
    (arguments
     '(#:include '("^[^/]+.el$" "^[^/]+.el.in$"
                   "^dir$"
                   "^[^/]+.info$"
                   "^[^/]+.texi$"
                   "^[^/]+.texinfo$"
                   "^doc/dir$"
                   "^doc/[^/]+.info$"
                   "^doc/[^/]+.texi$"
                   "^doc/[^/]+.texinfo$"
                   "^CHANGES$"
                   "^AUTHORS$"
                   "^COPYING$"
                   "^generic$"
                   "^images$"
                   "^lib$"
                   "^easycrypt$"
                   "^phox$"
                   "^qrhl$"
                   "^pghaskell$"
                   "^pgocaml$"
                   "^pgshell$")
       #:exclude '("^.dir-locals.el$" "^test.el$" "^tests.el$"
                   "^[^/]+-test.el$" "^[^/]+-tests.el$")
       #:phases (modify-phases %standard-phases
			       (delete 'check)
			       (delete 'validate-compiled-autoloads))))
    (home-page "https://proofgeneral.github.io/")
    (synopsis "A generic Emacs interface for proof assistants")
    (description
     "Proof General is a generic Emacs interface for proof assistants (also known as
interactive theorem provers).  It is supplied ready to use for the proof
assistants Coq, @code{EasyCrypt}, qrhl-tool, and @code{PhoX}.  See
https://proofgeneral.github.io/ for installation instructions and online
documentation.  Or browse the accompanying info manual: (info-display-manual
\"@code{ProofGeneral}\") Regarding the Coq proof assistant, you may be interested
in the company-coq extension of @code{ProofGeneral} (also available in MELPA).")
    (license #f)))

;; Import the commented out inputs
(define-public ghaziamacs
  (package
   (name "ghaziamacs")
   (version "0.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/Antigravityd/ghaziamacs")
           (commit "2e459746820d1ddc4e23b49a8a9ac1a0da4b2c7c")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1099hpifahh20i8s87b5d31agwnzjbs566vlkib5bc25g4cfpyb6"))))
   (build-system copy-build-system
		 ;;
		 )
   (arguments (list #:install-plan ''(("./default.el" "/share/emacs/site-lisp/"))))
   (inputs (list emacs
		 emacs-doom-modeline
		 emacs-girly-notebook-theme
		 emacs-dashboard
		 emacs-ligature
		 emacs-rainbow-delimiters
		 emacs-smartparens
		 emacs-ws-butler emacs-hl-todo emacs-vertico
		 emacs-corfu emacs-kind-icon emacs-orderless emacs-consult
		 emacs-consult-eglot emacs-marginalia emacs-vlf
		 emacs-diredfl emacs-vterm
		 emacs-no-littering emacs-helpful emacs-which-key
		 emacs-projectile emacs-magit emacs-proof-general emacs-pdf-tools
		 emacs-nerd-icons
		 font-iosevka-ss05 font-iosevka-aile font-victor-mono
		 font-google-noto))
   (synopsis "")
   (description "")
   (home-page "")
   (license gpl3+)))

ghaziamacs
