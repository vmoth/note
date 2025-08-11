a list of book note

Java 内部类
封装性，我们可以给内部类添加private修饰来增强封装性
Java不可以实现多重继承，但是我们可以给一个累添加多个内部类来实现多重继承
内部类能够访问外部类的私有成员

为什么java HashMap 加载因子是0.75
http://www.ruanyifeng.com/blog/2015/06/poisson-distribution.html


PUT /msgcenter-12/_settings
{
"index" : {
"number_of_replicas":0
}
}

wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

https://github.com/opsnull/follow-me-install-kubernetes-cluster

https://zhaohuabing.com/post/2020-02-24-linux-taptun/

https://jimmysong.io/kubernetes-handbook/practice/install-kubernetes-on-centos.html

https://jython.readthedocs.io/en/latest/JythonAndJavaIntegration/

https://community.amd.com/t5/drivers-software/can-t-install-amdgpu-drivers-on-ubuntu-20-04-1-5-4-0-56-generic/td-p/426676

sql in exists diff


tmux tree color
https://tomlankhorst.nl/iterm-tmux-vim-true-color/

quay.io替换为quay-mirror.qiniu.com
gcr.io/google-containers替换为gcr.azk8s.cn/google-containers

https://www.ulovecode.com/2019/05/23/%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF/Kubernetes/%E4%BD%BF%E7%94%A8Kubespray%E5%9C%A8%E9%98%BF%E9%87%8C%E4%BA%91%E4%B8%8A%E8%87%AA%E5%8A%A8%E5%8C%96%E9%83%A8%E7%BD%B2Kubernetes%E9%9B%86%E7%BE%A4%EF%BC%881.14.1%EF%BC%89/



sudo pacman -S wireguard-tools
sudo pacman -s fcits5-chinese-addons fcitx5-im
sudo pacman -S fcits5-chinese-addons fcitx5-im
sudo pacman -S fcitx5-chinese-addons fcitx5-im
sudo pacman -S fcitx5-qt fcitx5-gtk
sudo pacman -S vim neovim
sudo pacman -S xmonad xmonad-contrib
sudo pacman -S tmux
sudo pacman -S ranger
sudo pacman -S noto-fonts-cjk
sudo pacman -S ttf-font-awesome
sudo pacman -S zsh xmobar alacritty
yay -S google-chrome
yay -S nerd-fonts-anonymous-pro

~/.local/bin/
~/.tmux.conf
~/.tmux/
~/.config/nvim
~/jdtls
~/.vim/plugged
~/lombok.jar
~/.xmonad
~/.xmobarrc

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

(after! lsp-volar
  ;; remove :system after lsp-volar loaded
  (lsp-dependency 'typescript
                  '(:npm :package "typescript"
                    :path "tsserver")))

macos
Spectacle
alfred

(add-to-list 'default-frame-alist
             '(font . "RecMonoCasual Nerd Font Propo-11"))

iterm

ghotty
font-family = "RecMonoCasual Nerd Font Propo"
cursor-style = block
cursor-style-blink = false
shell-integration-features = no-cursor
theme = catppuccin-frappe


https://www.ovistoica.com/blog

人大金仓 数据类型没有隐式转换。


evil emacs

```lisp
(defun myhook-evil-mode ()
  ;; I want underscore be part of word syntax table, but not in regexp-replace buffer
  ;; where I'm more comfortable having more verbose navigation with underscore not
  ;; being a part of a word. To achieve this I check if current mode has a syntax
  ;; table different from the global one. The `(eq)' is a lightweight test of whether
  ;; the args point to the same object.
  (unless (eq (standard-syntax-table) (syntax-table))
    ;; make underscore part of a word
    (modify-syntax-entry ?_ "w")))
(add-hook 'evil-local-mode-hook 'myhook-evil-mode)


```lisp
(setq evil-default-cursor (quote (t "#DD7694"))
    evil-visual-state-cursor '("#880000" box)
    evil-normal-state-cursor '("#DD7694" box)
    evil-insert-state-cursor '("#C3D94E" box)
    )

(use-package nerd-icons
  :ensure t
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )
(use-package doom-themes
  :ensure t
  :config
  (custom-set-faces
  `(default ((t (:family "Fira Code" :height 120))))
  )
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  ;;(doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-one-light t)
  ;;(set-default-font "BlexMono Nerd Font-12")

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


