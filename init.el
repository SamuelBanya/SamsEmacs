(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Install packages if they're not present on the current machine
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(unless (package-installed-p 'helm)
  (package-refresh-contents)
  (package-install 'helm))

(unless (package-installed-p 'hydra)
  (package-refresh-contents)
  (package-install 'hydra))

(unless (package-installed-p 'emmet-mode)
  (package-refresh-contents)
  (package-install 'emmet-mode))

(unless (package-installed-p 'htmlize)
  (package-refresh-contents)
  (package-install 'htmlize))

(unless (package-installed-p 'beacon)
  (package-refresh-contents)
  (package-install 'beacon))

(unless (package-installed-p 'which-key)
  (package-refresh-contents)
  (package-install 'which-key))

(unless (package-installed-p 'exwm)
  (package-refresh-contents)
  (package-install 'exwm))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("7e6995de79f9e25a0dfae2cf36edc23e9d73921da1390c4d5f0dbd0dd95f0a36" "06e0662b31a2ae8da5c6b5e9a05b25fabd1dc8dd3c3661ac194201131cafb080" "047ec205dcb5edbb94b35800110150a6e41e6cc92c0ccfb2ed25ac3df94331a6" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "69ad4071c7b2d91543fddd9030816404ff22e46f7207549319ce484e23082dee" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"))
 '(helm-minibuffer-history-key "M-p")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(org-menu ytdl webpaste hide-mode-line helm-swoop yasnippet-snippets yasnippet flycheck company lsp-mode magit eyebrowse multiple-cursors expand-region mark-multiple swiper popup-kill-ring switch-window jazz-theme solarized-theme gruvbox-theme scanner ranger ewal-spacemacs-themes ewal typescript-mode gif-screencast free-keys docker dockerfile-mode docker-compose-mode evil-collection evil elfeed-org color-theme-modern discover-my-major goto-line-preview linum-relative visual-regexp rainbow-delimiters-mode log4j-mode log4j vterm org-download window-purpose aggressive-indent aggresive-indent spray sx counsel csv-mode org-mru-clock elfeed erc-image erc-hl-nicks logview rotate org-tree-slide symon dmenu diminish spaceline emacs-dashboard dashboard rainbow-delimiters sudo-edit hungry-delete rainbow-mode avy use-package spacemacs-theme helm hydra emmet-mode htmlize)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 125 :width normal :foundry "1ASC" :family "hack")))))

 (org-babel-load-file "~/.emacs.d/configuration.org")
