;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(require 'dap-cpptools)
(require 'dap-node)
(require 'dap-go)
(require 'dap-python)
(require 'dap-java)
(setq evil-insert-state-cursor '(box "#fb8b05")
      evil-normal-state-cursor '(box "purple"))


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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Code" :size 13))


;;(setq doom-font (font-spec :family "agave Nerd Font Mono" :size 14 :weight 'semi-light))
;; Set font for chinese characters
;; Font should be twice the width of asci chars so that org tables align
;; This will break if run in terminal mode, so use conditional to only run for GUI.

;;(set-fontset-font t 'han (font-spec :family "Noto Sans CJK SC" :size 12))
;;(setq doom-emoji-fallback-font-families "Noto Color Emoji")
;;(set-fontset-font t '(?😊 . ?😎) "Noto Color Emoji" nil 'append)
;;(set-fontset-font t nil "Courier New" nil 'append)
;;(setq doom-font (font-spec :family "agave Nerd Font Mono" :size 14 :weight 'semi-light)
;;      doom-unicode-font (font-spec :family "Noto Sans CJK SC" :size 12)
;;      doom-variable-pitch-font (font-spec :family "Noto Sans CJK SC" :size 12))


;;(set-fontset-font t 'han (font-spec :family "Noto Sans CJK SC" :size 12))

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
;;
(defun dt/year-calendar (&optional year)
  (interactive)
  (require 'calendar)
  (let* (
      (current-year (number-to-string (nth 5 (decode-time (current-time)))))
      (month 0)
      (year (if year year (string-to-number (format-time-string "%Y" (current-time))))))
    (switch-to-buffer (get-buffer-create calendar-buffer))
    (when (not (eq major-mode 'calendar-mode))
      (calendar-mode))
    (setq displayed-month month)
    (setq displayed-year year)
    (setq buffer-read-only nil)
    (erase-buffer)
    ;; horizontal rows
    (dotimes (j 4)
      ;; vertical columns
      (dotimes (i 3)
        (calendar-generate-month
          (setq month (+ month 1))
          year
          ;; indentation / spacing between months
          (+ 5 (* 25 i))))
      (goto-char (point-max))
      (insert (make-string (- 10 (count-lines (point-min) (point-max))) ?\n))
      (widen)
      (goto-char (point-max))
      (narrow-to-region (point-max) (point-max)))
    (widen)
    (goto-char (point-min))
    (setq buffer-read-only t)))

(defun dt/scroll-year-calendar-forward (&optional arg event)
  "Scroll the yearly calendar by year in a forward direction."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     last-nonmenu-event))
  (unless arg (setq arg 0))
  (save-selected-window
    (if (setq event (event-start event)) (select-window (posn-window event)))
    (unless (zerop arg)
      (let* (
              (year (+ displayed-year arg)))
        (dt/year-calendar year)))
    (goto-char (point-min))
    (run-hooks 'calendar-move-hook)))

(defun dt/scroll-year-calendar-backward (&optional arg event)
  "Scroll the yearly calendar by year in a backward direction."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     last-nonmenu-event))
  (dt/scroll-year-calendar-forward (- (or arg 1)) event))
(defalias 'year-calendar 'dt/year-calendar)

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
(map! :leader
      :desc "show vterm"
      "v t" #'projectile-run-vterm)
(map! :leader
      :desc "show vterm"
      "m m" #'mp-display-message)




(setq lsp-java-vmargs '("-noverify" "-Xmx1G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication" "-javaagent:/home/dypan/lombok.jar"))
(setq lsp-java-java-path "/home/dypan/dev/soft/jdk-11.0.11+9/bin/java")

(add-hook 'vue-mode-hook #'lsp!)
;;(add-hook 'vue-mode-hook
;;  (lambda ()
;;        (interactive)
;;        ;;(message "Hello, World")))
;;   (doom/set-indent-width 2)))


(evilem-default-keybindings "SPC")
(add-hook 'dap-server-log-mode-hook
  (lambda ()
   (local-set-key "h" 'evil-backward-char)))

;;(setq explicit-shell-file-name "/usr/bin/zsh")

(defun mp-display-message ()
  (interactive)
  ;;; Place your code below this line, but inside the bracket.
  (setq default-directory (projectile-project-root))
  (compile '"./make.sh")
  ;;(message "Hello, World %s" (projectile-project-root))
  )

(defun mp-display-vterm ()
  ;;(interactive)
  ;;; Place your code below this line, but inside the bracket.
  ;;(setq default-directory (projectile-project-root))
  (projectile-run-vterm)
  ;;(message "Hello, World %s" (projectile-project-root))
  )

;;(global-set-key (kbd "C-m") 'mp-display-message)
(setq projectile-indexing-method 'alien)
(setq doom-theme 'doom-dracula)
;;(after! lsp-mode
;;  (set-lsp-priority! 'clangd 1))  ; ccls has priority 0

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))


;; we need this wrapper to match Projectile's API
(defun projectile-project-current (dir)
  "Retrieve the root directory of the project at DIR using `project-current'."
  (cdr (project-current nil dir)))

(setq projectile-project-root-functions '(projectile-project-current))
;;(add-to-list 'company-backends #'company-tabnine)

;;(setq +lsp-company-backends '(company-tabnine company-capf company-yasnippet))
;;(set-company-backend! 'prog-mode 'company-tabnine 'company-capf 'company-yasnippet)
;;;; Trigger completion immediately.
;;(setq company-idle-delay 0)
;;;;(setq company-dabbrev-downcase 0)
;;;; Number the candidates (use M-1, M-2 etc to select completions).
;;(setq company-show-numbers t)

(setq tab-width 2)
(setq indent-tabs-mode nil)
(setq evil-indent-convert-tabs nil)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq indent-line-function 'indent-relative-first-indent-point)
(modify-syntax-entry ?_ "w")

(setq company-show-numbers t)
;;(setq company-idle-delay 0)
;;
;;(set-company-backend! 'prog-mode
;;  'company-tabnine 'company-capf 'company-yasnippet)
;;(setq +lsp-company-backend '(company-capf :with company-tabnine :separate))
;;(setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))
;;(setq lsp-java-server-install-dir "/home/dypan/eclipse/")
;;(setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.1.2/jdt-language-server-1.1.2-202105191944.tar.gz")
;;(setq lsp-java-jdt-download-url "http://download.eclipse.org/che/che-ls-jdt/snapshots/che-jdt-language-server-latest.tar.gz")

;;(setq company-minimum-prefix-length 1)
;;(setq company-auto-complete nil)
;;(setq company-idle-delay 0)
;;(setq company-require-match 'true)
;;(company-tng-configure-default)
(setq +lsp-company-backends '(:separate company-tabnine company-capf company-yasnippet))

(setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.0.0/jdt-language-server-1.0.0-202104151857.tar.gz")
(setq dap-print-io t)
;;(add-to-list 'company-backends #'company-tabnine)
(add-hook 'vue-mode-hook (lambda () (setq js-indent-level 2)))

;;(set-fontset-font t 'han (font-spec :family "Noto Sans CJK SC" :size 11))
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
    charset (font-spec :family "Noto Sans CJK SC" :size 12)))

(dolist (charset '(ascii))
  (set-fontset-font (frame-parameter nil 'font)
    charset (font-spec :family "agave Nerd Font Mono" :size 14 :weight 'semi-light)))


 (setq doom-font (font-spec :family "Victor Mono" :size 13)
       doom-variable-pitch-font (font-spec :family "Victor Mono" :size 13))



(setq company-idle-delay 0)

(setq company-show-numbers t)


(custom-set-faces!
  '(font-lock-type-face :slant italic)
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))



;;;;;;new
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; config.el
;;(use-package treemacs
;;  :config
;;  (use-package treemacs-nerd-icons
;;    :functions treemacs-load-theme
;;    :config
;;    (treemacs-load-theme "nerd-icons"))
;;  )

(use-package treemacs-nerd-icons
  :after treemacs
  :config
  (treemacs-indent-guide-mode)
  (treemacs-load-theme "nerd-icons")
  (treemacs-define-custom-icon "\t " "Makefile")
  (treemacs-define-custom-icon "\t " "LICENSE")
  (treemacs-define-custom-icon "\t " ".Xresources")
  )
;;(setq treemacs-indentation 8)
;;(use-package treemacs-all-the-icons
;;  :ensure t
;;  :config
;;  (treemacs-load-theme "all-the-icons")
;;  )
;;(use-package nerd-icons
;;  :config
;;  (if (display-graphic-p)
;;      (treemacs-load-theme "nerd-icons")
;;      (setq nerd-icons-use-svg t)
;;    (setq nerd-icons-use-svg nil)))
;;(when (display-graphic-p)
;;  (require 'all-the-icons))
(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :config
  (setq pdf-view-midnight-colors '("#ABB2BF" . "#282C35")))

;;(setq doom-themes-treemacs-theme "doom-colors")
;;(customize-set-variable 'doom-themes-treemacs-theme "nerd-icons")
(require 'dap-cpptools)
(setq evil-insert-state-cursor '(box "#fb8b05")
      evil-normal-state-cursor '(box "purple"))

;;(set-face-attribute 'vterm-color-red nil
;;                    ;;:foreground (get-red-color)
;;                    :background "#9099AB")

;;(use-package! lsp-bridge
;;  :config
;;  (setq lsp-bridge-enable-log nil)
;;  (global-lsp-bridge-mode))
(require 'dap-gdb-lldb)
(require 'dap-node)
(require 'dap-go)
(require 'dap-python)
(require 'dap-java)
(dap-cpptools-setup)

;;(add-to-list 'load-path "/home/dypan/data/lsp-bridge")

;;(require 'yasnippet)
;;(yas-global-mode 1)
;;
;;(require 'lsp-bridge)
;;(global-lsp-bridge-mode)

;;(dap-register-debug-template "Rust::CppTools Run Configuration"
;;                                 (list :type "cppdbg"
;;                                       :request "launch"
;;                                       :name "Rust::Run"
;;                                       :MIMode "gdb"
;;                                       :miDebuggerPath "rust-gdb"
;;                                       :environment []
;;                                       :program "${workspaceFolder}/target/debug/REPLACETHIS"
;;                                       :cwd "${workspaceFolder}"
;;                                       :console "external"
;;                                       :dap-compilation "cargo build"
;;                                       :dap-compilation-dir "${workspaceFolder}"))
;;
  (with-eval-after-load 'dap-mode
    (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
    (dap-auto-configure-mode +1))

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "ComicShannsMono Nerd Font Mono" :size 13)
;;      doom-variable-pitch-font (font-spec :family "ComicShannsMono Nerd Font Mono" :size 13))
;;(setq doom-font (font-spec :family "FantasqueSansM Nerd Font Mono" :size 28))
;;(setq doom-font (font-spec :family "FiraMono Nerd Font" :size 28))

;;(setq treemacs-load-all-the-icons-with-workaround-font "all-the-icons")

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-gruvbox-light)
(setq doom-theme 'dichromacy)
(global-set-key (kbd "C-s") 'save-buffer)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;;(setenv "JAVA_HOME" "/home/dypan/jdtls/jdk/17")
;;(setq lsp-java-java-path "/home/dypan/jdtls/jdk/17/bin/java")
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(setenv "PATH" (concat ""
    	    (string-replace "/home/dypan/jdtls/jdk/8/bin" "/home/dypan/jdtls/jdk/17/bin" (getenv "PATH"))))
;;(setq lsp-java-jdt-download-url  "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")
;;(setq lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/milestones/1.0.0/jdt-language-server-1.0.0-202104151857.tar.gz")

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
(map! :leader
      :desc "show vterm"
      "v t" #'projectile-run-vterm)
(map! :leader
      :desc "show vterm"
      "m m" #'mp-display-message)

(setq lsp-java-workspace-dir "/home/dypan/emacs")
(defun set-jdk-8()
  (interactive)
  (setq dap-java-java-command "/home/dypan/jdtls/jdk/8/bin/java")
)
(defun set-jdk-17()
  (interactive)
  (setq dap-java-java-command "/home/dypan/jdtls/jdk/17/bin/java")
)
;;(setq url-proxy-services
;;  '(("no_proxy" . "^.*example.com")
;;    ("https" . "localhost:7890")
;;    ("http" . "localhost:7890")
;;    ;; socks not working, @see url-default-find-proxy-for-url
;;    ;; ("socks5" . "localhost:1080")
;;    ))
;;(dap-register-debug-template "My Runner"
;;                             (list :type "java"
;;                                   :request "launch"
;;                                   :args ""
;;                                   :vmArgs "-ea -Dmyapp.instance.name=myapp_1"
;;                                   :projectName "myapp"
;;                                   :mainClass "org.example.App"
;;                                   :env '(("DEV" . "1"))))
(setq lsp-java-configuration-runtimes '[(:name "JavaSE-1.8"
						:path "/home/dypan/jdtls/jdk/8/"
						:default t
						)
					(:name "JavaSE-11"
						:path "/home/dypan/jdtls/jdk/11/")
					(:name "JavaSE-17"
						:path "/home/dypan/jdtls/jdk/17/"
						)])
(setq company-idle-delay 0)
(setq company-show-numbers t)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-hook 'vue-mode-hook #'lsp!)
;;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq undo-limit 67108864) ; 64mb.
(setq undo-strong-limit 100663296) ; 96mb.
(setq undo-outer-limit 1006632960) ; 960mb.
(use-package evil
  :init
  (setq evil-undo-system 'undo-fu))

(use-package undo-fu)
(after! highlight-indent-guides
  (highlight-indent-guides-auto-set-faces)
  (setq highlight-indent-guides-method 'column)
)
;;(treemacs-load-theme "nerd-icons")
;;(set-face-background 'indent-guide-face "dimgray")
(defun mp-display-message ()
  (interactive)
  ;;; Place your code below this line, but inside the bracket.
  (setq default-directory (projectile-project-root))
  (compile '"./make.sh")
  ;;(message "Hello, World %s" (projectile-project-root))
  )

(setq tab-width 2)
(setq indent-tabs-mode nil)
(setq evil-indent-convert-tabs nil)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq indent-line-function 'indent-relative-first-indent-point)
(modify-syntax-entry ?_ "w")

(setq company-show-numbers t)
