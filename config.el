;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(require 'dap-cpptools)

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)


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
(global-set-key [f5] 'dap-debug)
(global-set-key [f9] 'dap-breakpoint-toggle)
(global-set-key [f10] 'dap-next)
(global-set-key [f11] 'dap-step-in)
(global-set-key [f6] 'dap-hydra)
(global-set-key [f7] 'dap-hydra/nil)
(map! :leader
      :desc "lsp goto implementation"
      "g i" #'lsp-goto-implementation)
(map! :leader
      :desc "lsp find reference"
      "g r" #'lsp-find-references)
(map! :leader
      :desc "neotree projectile action"
      "t t" #'neotree-projectile-action)
(setq lsp-java-vmargs '("-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication" "-javaagent:/Users/dypan/lombok.jar" "-Xbootclasspath/a:/Users/dypan/lombok.jar"))
(add-hook 'vue-mode-hook #'lsp!)
(evilem-default-keybindings "SPC")
(add-hook 'dap-server-log-mode-hook
  (lambda ()
   (local-set-key "h" 'evil-backward-char)))

(defun mp-display-message ()
  (interactive)
  ;;; Place your code below this line, but inside the bracket.
  (setq default-directory (projectile-project-root))
  (compile '"./make.sh")
  ;;(message "Hello, World %s" (projectile-project-root))
  )

(global-set-key (kbd "s-m") 'mp-display-message)
(setq projectile-indexing-method 'alien)
(setq doom-theme 'doom-dracula)
https://github.com/hlissner/doom-emacs/issues/2689
(after! lsp-mode
  (set-lsp-priority! 'clangd 1))  ; ccls has priority 0

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

