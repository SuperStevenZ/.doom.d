;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Steven Zhou"
      user-mail-address "zzuohong@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; -----------------------------------------------------------------------------
;; Customization

;; Full screen on start up
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Fonts
(setq doom-font (font-spec :family "Menlo" :size 16))

;; Smartparens
(add-hook 'prog-mode-hook #'smartparens-strict-mode)
(global-set-key (kbd "C-)") 'sp-forward-slurp-sexp)
(global-set-key (kbd "C-}") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-(") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-{") 'sp-backward-barf-sexp)

;; Org-agenda
(setq org-agenda-files '("~/agenda/"))
(setq org-log-done 'time)

;; Python interactive prompt
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")
(global-set-key (kbd "C-c C-p") 'run-python)

;; Max line length
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; highlight-symbol
(require 'highlight-symbol)
(global-set-key (kbd "M-h") 'highlight-symbol)

;; undo tree mode
(add-hook 'prog-mode-hook #'undo-tree-mode)

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; python lsp
(add-hook 'python-mode-hook #'lsp)
(use-package! lsp
  :init
  (setq lsp-pyls-plugins-pylint-enabled nil)
  (setq lsp-pyls-plugins-pyflakes-enabled t)
  (setq lsp-pyls-plugins-autopep8-enabled nil)
  (setq lsp-pyls-plugins-yapf-enabled t)
  (setq lsp-pyls-plugins-pydocstyle-enabled t))

;; company
(after! company
  (setq company-idle-delay 100
        company-minimum-prefix-length 1))

;; MacOS left option as meta
(setq ns-option-modifier 'none
      ns-right-alternate-modifier 'meta)

;; ;; pytest
;; (setq comint-prompt-read-only nil)
;; (global-set-key (kbd "C-c C-t C-t") 'python-pytest-function)
;; (global-set-key (kbd "C-c C-t C-n") 'python-pytest-file)

;; pyvenv
(use-package pyvenv
  :ensure t
  :defer t
  :diminish
  :config
  (setenv "WORKON_HOME" "/Users/stevenzhou/virtualenv")
  ;; Show python venv name in modeline
  (setq pyvenv-mode-line-indicator
        '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  (pyvenv-mode t))

;; scala binds
(map! :map scala-mode-map
      "C-c F" #'lsp-format-buffer
      "C-c C-e" #'sbt-send-region)
