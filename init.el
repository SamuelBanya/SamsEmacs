(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Install packages if they're not present on the current machine
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'hydra)
  (package-refresh-contents)
  (package-install 'hydra))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1592061f6c4c9eb039d6ca9a8372d07f97aa033089aba168062b049d047783f3" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "1c6c5145c44c9b9eeaa337a323c6a61b96f364acf9655af39956125da6b5ed96" "101afd2156b8521e4a3ddee6a5822bdee28651706c00d85546c45e3bb49d9083" "449b45859a7df6f73aa559df55363d6452fdd5d27221d1e193ab6b84560d0508" "4f1f55c620bfaa979c821c5914e216e4d98449e9c8066e05893023665afcb5f1" "2f45a6de06ffb5bd62929321eb34e80b87c4b407c65d9e2ec05265f2dd8b24cd" "da972f714ad0744619f0ca6d1df3329b0e0b181abc8adb2805aaf2d0404716fa" "046838aa599bdbd1757e83e1538567fb889e315f59af3f1d592e7b0b63eaad73" "50a1e849597bb15d584d14214f57d494f7845c41a34019a813300273d659c3ed" "89369000c56eb6498fb397ec9cacdfb6e8f736491351bfec8854dc8c35716e5e" "ce634b6dea3cc5e45f7d9472236219d187fa8fcc7eb7914663bd4326a494a385" "0a3b07f05dbfe158421ce29c5fe0193077ce8a5d4e272e81b0021217e52ba61f" "1d1cff772a34ffa70123505b57ceeee533bf27d9e0602c0409762fa49632d936" "ba615a6714456028bd7446e3a3fd1aef3711bf60012a8efb07106fcc54f4c022" "fc08f39fe01d6883bbcc1f0ebcbbf6c269923eddd76c82664d1b956d919f33d8" "842120fcfc8dab77a1661d7575b0f35913cf849f16c6ece30ad122b6d4d793d5" "7e6995de79f9e25a0dfae2cf36edc23e9d73921da1390c4d5f0dbd0dd95f0a36" "06e0662b31a2ae8da5c6b5e9a05b25fabd1dc8dd3c3661ac194201131cafb080" "047ec205dcb5edbb94b35800110150a6e41e6cc92c0ccfb2ed25ac3df94331a6" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "69ad4071c7b2d91543fddd9030816404ff22e46f7207549319ce484e23082dee" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"))
 '(helm-minibuffer-history-key "M-p")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(morrowind-emacs-theme npm-mode lsp-python-ms add-node-modules-path exec-path-from-shell json-mode prettier-js ox-hugo hugo popper dirvish deft lsp-treemacs gcmh no-littering auto-package-update calfw-org projectile treemacs-magit treemacs company-jedi undo-tree highlight-indent-guides calfw lsp-ui python-mode vue-mode csharp-mode web-mode rjsx-mode js2-mode org-menu ytdl webpaste hide-mode-line helm-swoop yasnippet-snippets yasnippet flycheck company lsp-mode magit eyebrowse multiple-cursors expand-region mark-multiple swiper popup-kill-ring switch-window jazz-theme solarized-theme gruvbox-theme scanner ranger ewal-spacemacs-themes ewal typescript-mode gif-screencast free-keys docker dockerfile-mode docker-compose-mode evil-collection evil elfeed-org color-theme-modern discover-my-major goto-line-preview linum-relative visual-regexp rainbow-delimiters-mode log4j-mode log4j vterm org-download window-purpose aggressive-indent aggresive-indent spray sx counsel csv-mode org-mru-clock elfeed erc-image erc-hl-nicks logview rotate org-tree-slide symon dmenu diminish spaceline emacs-dashboard dashboard rainbow-delimiters sudo-edit hungry-delete rainbow-mode avy use-package spacemacs-theme helm hydra emmet-mode htmlize)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :foundry "1ASC" :family "hack")))))

 (org-babel-load-file "~/.emacs.d/configuration.org")
