;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(require 'dap-cpptools)
(require 'dap-node)
(require 'dap-go)
(require 'dap-python)
(require 'dap-java)

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

