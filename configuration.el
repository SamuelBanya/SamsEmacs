(when (member (system-name) '("notestation" "fossastation"))
  (setq
   user-full-name "Samuel Banya"
   user-mail-address "sbanya@fastmail.com"
   send-mail-function 'smtpmail-send-it
   smtpmail-smtp-server "smtp.fastmail.com"
   smtpmail-stream-type 'starttls
   smtpmail-smtp-service 587
   gnus-select-method
   '(nnimap "fastmail"
	    (nnimap-user "sbanya@fastmail.com")
	    (nnimap-address "imap.fastmail.com")
	    (nnimap-server-port 993)
	    (nnimap-stream ssl)
	    (nnmail-expiry-wait immediate))))

(when (member (system-name) '("notestation" "fossastation"))
    (use-package elfeed-org
      :ensure t
      :config
      (elfeed-org)
      (setq rmh-elfeed-org-files (list "~/.emacs.d/rss_feeds/elfeed.org"))))

;; Taken From Mike Zamansky's Config:
;; https://github.com/zamansky/dot-emacs/blob/main/config.org
(defun elfeed-load-db-and-open ()
  "Wrapper to load the elfeed database from the harddisk before opening elfeed"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

(defun elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed database to harddisk before killing elfeed buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))

(when (member (system-name) '("notestation" "fossastation"))
    (use-package elfeed
      :ensure t
      :bind (:map elfeed-search-mode-map
		  ("q" . elfeed-save-db-and-bury)
		  ("Q" . elfeed-save-db-and-bury))))

(when (member (system-name) '("notestation" "fossastation"))
  (setq org-capture-templates
	;; Things To Do (NOW):
	'(("n" "Things To Do (NOW) Capture Template" entry
	   (file+headline "~/hub/notes_private/life.org" "Things To Do (NOW)")
	   "** %^{Status} [#%^{Priority}] %^{Task Title} :%^{Tag}: \n*** Notes:\n%U: %^{Description}")
	  ("l" "Things To Do (LATER) Capture Template" entry
	   (file+headline "~/hub/notes_private/life.org" "Things To Do (LATER)")
	   "** %^{Status} [#%^{Priority}] %^{Task Title} :%^{Tag}: \n*** Notes:\n%U: %^{Description}"))))
	  ;; Latest attempt to add current week entry (Didn't work):
	  ;; ("c" "Completed Task Capture Template" entry
	   ;; (file+headline "~/hub/notes_private/life.org" , "* COMPLETED_TASKS: " , (format-time-string "%Y") , "** Week of "  (format-time-string "%m-%d-%Y"))
	   ;; "** %^{Status} [#%^{Priority}] %^{Task Title} :%^{Tag}: \n*** Notes:\n%U: %^{Description}"))))
;; 1. Determine how to somehow evaluate the following type of headline to place it in the correct 'COMPLETED_TASKS' headline
;; Goal: 'COMPLETED_TASKS: (current year)'
;; 2. Determine the current week headline
;; Goal: '** Week of (current_date, ex: '11-02-2021')'
;; 3. Prompt the user for the youtube link via the same exact '' function I use later in the Emacs config
;; Goal: User gets prompted for the link, the link is returned with with the name of the video and the link
;; in parentheses 
;; NOTE: The following is commmented out while I think about how to do this:
;; (("y" "YouTube Video Capture Template" entry
;; (file+headline "~/hub/notes_private/life.org" "Things To Do (LATER)")
;;"** %^{Status} [#%^{Priority}] %^{Task Title} :%YouTube_Video: \n*** Notes:\n%U: %^{Description}"))

(when (member (system-name) '("notestation" "fossastation"))
  ;; Create separate connection based functions to later call within the 'hydra-connect' hydra:
  (defun ssh-into-musimatic-sam ()
    (interactive)
    (find-file "/ssh:sam@musimatic.xyz:/var/www/musimatic"))

  (defun ssh-into-musimatic-git ()
    (interactive)
    (find-file "/ssh:git@musimatic.xyz:/var/www/musimatic"))  

  (defun ssh-into-musimatic-root ()
    (interactive)
    (find-file "/ssh:root@musimatic.xyz:/var/www/musimatic"))

  (defun ssh-into-sambanya-sam ()
    (interactive)
    (find-file "/ssh:sam@sambanya.com:/var/www/sambanya"))

  (defun ssh-into-sambanya-root ()
    (interactive)
    (find-file "/ssh:root@sambanya.com:/var/www/sambanya"))

  (defun ssh-into-fedoraserver-sam ()
    (interactive)
    (find-file "/ssh:sam@fedoraserver:/media/REDHDD"))

  (defhydra hydra-connect (:color pink
				  :hint nil)
    "
  ^Connect^
  ^^^^^^^^^^-----------------------------
  _a_: connect to musimatic.xyz as sam user
  _b_: connect to musimatic.xyz as git user
  _c_: connect to musimatic.xyz as root user
  _d_: connect to sambanya.com as sam user
  _e_: connect to sambanya.com as root user
  _f_: connect to fedoraserver as sam user
  _q_: quit
  "
    ("a" ssh-into-musimatic-sam)
    ("b" ssh-into-musimatic-git)    
    ("c" ssh-into-musimatic-root)
    ("d" ssh-into-sambanya-sam)
    ("e" ssh-into-sambanya-root)
    ("f" ssh-into-fedoraserver-sam)
    ("q" nil))

  (global-set-key (kbd "M-n") 'hydra-connect/body))

(when (string= system-name "Samuels-MBP.tampabay.rr.com")
  (setq org-capture-templates
	;; Using backtick to allow for 'format-time-string' to be escaped:
	`(("a" "OPEN Ticket Capture Template" entry
	   (file+headline "~/hub/worknotes_snyk/TodoList/TodoList(2022).org" "Open Tasks")
	   "** OPEN [#%^{Severity}] Ticket #%^{Ticket Number} with %^{Client's First Name} from %^{Company Name} :%^{Snyk Product}: \n*** Link\n- https://snyk.zendesk.com/agent/tickets/%^{Ticket Number}\n*** Notes\n**** Initial Notes\n%U: %^{Current Status}\n*** Result")
	  ("x" "PENDING Capture Template" entry
	   (file+headline "~/hub/worknotes_snyk/TodoList/TodoList(2022).org" "Pending Tasks")
	   "** PENDING [#%^{Severity}] Ticket #%^{Ticket Number} with %^{Client's First Name} from %^{Company Name} :%^{Snyk Product}: \n*** Link\n- https://snyk.zendesk.com/agent/tickets/%^{Ticket Number}\n*** Notes\n**** Initial Notes\n%U: %^{Current Status}\n*** Result")
	  ("1" "DONE Ticket Capture Template" entry
	   (file+headline "~/hub/worknotes_snyk/TodoList/TodoList(2022).org" (concat "COMPLETED: " (format-time-string "%b %Y")))
	   "** DONE [#%^{Severity}] Ticket #%^{Ticket Number} with %^{Client's First Name} from %^{Company Name} :%^{Snyk Product}: \n*** Link\n- https://snyk.zendesk.com/agent/tickets/%^{Ticket Number}\n*** Notes\n**** Initial Notes\n%U: %^{Current Status}\n*** Result\n%^{Result}")
	  ("i" "Intercom Chat Capture Template" entry
	   (file+headline "~/hub/worknotes_snyk/TodoList/TodoList(2022).org" "Intercom Tasks")
	   "** IN-PROGRESS Support Chat with %^{Client's First Name} from %^{Company Name} :Intercom_Chat: \n*** Notes\n**** Initial Notes\n%U: %^{Current Status}\n*** Result")
	  ("m" "Meeting Capture Template" entry
	   (file+headline "~/hub/worknotes_snyk/TodoList/TodoList(2022).org" , (format-time-string "%b %Y"))
	   "** %^{Meeting Name} (%<%a %m-%d-%Y>)\n%U: %^{Current Status}" :clock-in t :clock-resume t))))
	  ;; DRAFT: Placing in comments to figure out how to do this
	  ;; ("c" "Convert Intercom Chat To Zendesk Ticket Capture Template" entry
	  ;; (file+headline "~/hub/worknotes_snyk/TodoList/TodoList(2021).org" "Open Tasks")
	  ;; TODO: Figure out how to find the headline of the current Intercom chat task in 'Intercom Tasks'
	  ;; TODO: Then, figure out how to change 'Support Chat' to: 'Ticket #' instead
	  ;; TODO: Prompt the user for the client's company name as this will be needed for Zendesk itself most likely
	  ;; "** %^{Meeting Name} (%<%a %m-%d-%Y>)\n%U: %^{Current Status}" :clock-in t :clock-resume t)

(when (string= system-name "Samuels-MBP.tampabay.rr.com")
  (global-set-key (kbd "<A-return>") 'vterm))

;; (defhydra hydra-remindkeys (:color pink
;; 			       :hint nil)
;;   "
;; ^Keybindings^
;; ^^^^^^^^^^-----------------------------
;; _C-M-z_: Enable 'evil' and 'evil-collection' for Vim keybindings
;; _S-Return_: launch 'vterm'
;; _C-x w_: launch 'ranger.el'
;; _f12_: toggle full screen for Macbook workaround
;; _C-=_: rotate buffers
;; _f7 and S-f7_: start 'org-tree-slide-mode' for Org Mode based presentations, and stop them
;; _f6_: insert YouTube video link, and return the YouTube video name into pasted buffer
;; _C-x b_: enable iBuffer to check available buffers
;; _C-x C-b_: enable 'helm-buffers-list' to check list of available buffers to switch to via a Helm Mode prompt
;; _f2_: enable zoom-based Hydra to zoom in and out of available Emacs buffer
;; _C-c a_: enable 'Org-Agenda' to view agenda of tasks
;; _C-!_: enable color-theme based Hydra to change color themes on the fly
;; _M-s_: jump to a specific word in a buffer with the 'avy-goto-word-0' function
;; _M-l_: jump to a specific line in a buffer with the 'avy-goto-line' function
;; _M-y_: view the copy and paste clipboard via 'popup-kill-ring' package
;; _C-s_: search in a buffer with Counsel or Swiper via the 'counsel-grep-or-swiper' function
;; _C-c q_: first mark a section of a buffer, and then enable this to see where the highlighted section appears next to edit all instances simultaneously
;; _C-q_: enables 'expand-region' to expand a given region of text
;; _C-c C-0_: enables multiple cursors with 'mc/edit-lines' function
;; _C->_: while 'mc/edit-lines' is enabled, go to the next line
;; _C-<_: while 'mc/edit-lines' is enabled, go to the previousline
;; _C-c C-<_: while 'mc/edit-lines' is enabled, mark all of the lines that are like this
;; _C-M-s-k_: kill all buffers with 'kill-all-buffers' function, useful for end-of-day buffer cleanup
;; _C-c w l_: copy the entire line of text with 'copy-whole-line' function
;; _C-x k_: kill the current buffer with the 'kill-current-buffer' function
;; _s-e_: edit the buffer as the 'sudo' user with the 'sudo-edit' function
;; _C-c w w_: kill an entire word with the 'kill-whole-word' function
;; _C-$_: enable desktop based hydra to save, clear, or revert the current desktop of Emacs buffers via the 'hydra-desktop' hydra
;; _C-c l_: enable lsp-mode for programming based auto-completion
;; _<s tab_: enable source code based yasnippet template for Org Mode
;; _<b tab_: enable bash code based yasnippet template for Org Mode
;; _C-h M-a_: show the major mode keybindings with the 'discover-my-major' function
;; _C-h M-o_: show the minor mode keybindings with the 'discover-my-mode' function
;; _M-x free-keys_: show the available keybindings to use for later use in my Emacs config
;; _M-i_: hover over a word, and find that word in any open buffer on screen via the 'helm-swoop' function
;; _M-I_: hover over a word, and jump to the next instance of the word in the buffer via the 'helm-swoop-back-to-last-point' function
;; _C-c M-i_: hover over a word, and find the next file that contains that specific word via the 'helm-multi-swoop' function
;; _C-x M-i_: hover over a word, and find the next file that contains that specific word via the 'helm-multi-swoop-all' function
;; _C-c e_: edit Emacs config at any time
;; _C-c r_: reload Emacs config at any time
;; _C-c C-p C-b_: add the entire current buffer to an online webpaste, specifically at dpaste.org
;; _C-c C-p C-r_: add the selected region to an online webpaste, specifically at dpaste.org
;; _C-c C-p C-p_: add the selected region or buffer to an online webpaste, specifically at dpaste.org
;; _C-c s_: search for a specific issue on Stack Exchange aka StackOverflow
;; _M-x ytdl_: download YouTube videos directly from Emacs
;; _C-c m_: enable Org-Menu to discover keybindings in Org Mode
;; "
;;   ("q" nil))

;; (global-set-key (kbd "C-=") 'hydra-rotate/body)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(global-set-key (kbd "C-M-z") 'evil-mode)

(global-set-key (kbd "<s-return>") 'vterm)

(global-set-key (kbd "C-x w") 'ranger)

(global-set-key (kbd "<f12>") 'toggle-frame-fullscreen)

(defhydra hydra-rotate (:color pink
			       :hint nil)
  "
^Rotate Buffers^
^^^^^^^^^^-----------------------------
_h_: rotate even horizontal
_v_: rotate even vertical
_o_: rotate main horizontal
_e_: rotate main vertical
_t_: rotate tiled
_q_: quit
"
  ("h" rotate:even-horizontal)
  ("v" rotate:even-vertical)
  ("o" rotate:main-horizontal)
  ("e" rotate:main-vertical)
  ("t" rotate:tiled)
  ("q" nil))

(global-set-key (kbd "C-=") 'hydra-rotate/body)

(global-set-key (kbd "<f7>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f7>") 'org-tree-slide-skip-done-toggle)

(defun get-youtube-video-name ()
  "Grab the video title of a YouTube video using youtube-dl, and place it into an Emacs buffer."
  (interactive)
  (insert
  (shell-command-to-string
   (concat "youtube-dl --get-filename -o '%(title)s' $1"
		(shell-quote-argument
		 (read-string "Enter your YouTube link here: "))))))
(global-set-key (kbd "<f6>") 'get-youtube-video-name)

(global-set-key (kbd "C-x b") 'ibuffer)

(setq ibuffer-expert t)

(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

(defhydra hydra-zoom (global-map "<f2>")
"zoom"
("g" text-scale-increase "in")
("l" text-scale-decrease "out"))

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key "\C-ca" 'org-agenda)

;; NOTE:
;; A few notes in terms of disabling current theme to then create a new one
;; Workflow:
;; 'M-x disable theme': Disable the current theme
;; Use 'custom-theme-load-path' variable in the Emacs config to set theme path
;; 'M-x describe-face': Describe the face currently under the cursor
  (use-package autothemer
    :ensure t)

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package gruvbox-theme
  :ensure t)

;; Create separate functions to change to each theme
(defun change-to-spacemacs-theme ()
  (interactive)
  (load-theme 'spacemacs-dark t) 
  (enable-theme 'spacemacs-dark)
  (org-mode-restart))

(defun change-to-wordperfect-theme ()
  (interactive)
  (load-theme 'word-perfect t) 
  (enable-theme 'word-perfect)
  (org-mode-restart))

(defun change-to-gruvbox-dark-medium-theme ()
  (interactive)
  (load-theme 'gruvbox-dark-medium t) 
  (enable-theme 'gruvbox-dark-medium)
  (org-mode-restart))

(defhydra hydra-colortheme (:color pink
				   :hint nil)
  "
	  ^Change theme^
	  ^^^^^^^^^^-----------------------------
	  _a_: Spacemacs theme
	  _b_: Wordperfect theme
	  _c_: Gruvbox theme
	  _q_: quit
	  "
  ("a" change-to-spacemacs-theme)
  ("b" change-to-wordperfect-theme)
  ("c" change-to-gruvbox-dark-medium-theme)
  ("q" nil))

(global-set-key (kbd "C-!") 'hydra-colortheme/body)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Hello! Welcome to Emacs, have a fun time!"))

(use-package rainbow-mode
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package beacon
:ensure t
:init 
(beacon-mode 1))

;; Disable default terrible GUI based UI to allow more focus on the editor itself:
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; (load-theme 'wheatgrass)
(load-theme 'spacemacs-dark)
(org-mode-restart)

(when window-system (add-hook 'prog-mode-hook (lambda() (set-face-background 'highlight "#222") (hl-line-mode 1))))
(when window-system (add-hook 'text-mode-hook (lambda() (set-face-background 'highlight "#222") (hl-line-mode 1))))

(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(use-package which-key
:ensure t
:init
(which-key-mode 1))

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-word-0)
  ("M-l" . avy-goto-line))

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-querty-shortcuts
	'("a" "s" "d" "f" "h" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

(use-package popup-kill-ring
  :ensure t
  :bind("M-y" . popup-kill-ring))

(use-package swiper
  :ensure t)
  ;; :bind ("C-s" . swiper))

(use-package mark-multiple
  :ensure t
  :bind ("C-c q" . 'mark-next-like-this))

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package rotate
  :ensure t)

;; Note: When I get better at using this, do more crazier keybindings with the 'Command overview' section:
;; https://github.com/magnars/multiple-cursors.el
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-c C-0" . mc/edit-lines)
  ("C->" . mc/mark-next-line-like-this)
  ("C-<" . mc/mark-previous-line-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package goto-line-preview
  :ensure t)

(global-set-key [remap goto-line] 'goto-line-preview)

(use-package visual-regexp
  :ensure t)

(line-number-mode 1)
(column-number-mode 1)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(global-subword-mode 1)

(defun kill-all-buffers()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(global-set-key (kbd "C-M-s-k") 'kill-all-buffers)

(defun copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))

(global-set-key (kbd "C-c w l") 'copy-whole-line)

(defun kill-current-buffer()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'kill-current-buffer)

(use-package sudo-edit
  :ensure t
  :bind ("s-e" . sudo-edit))

(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

(defun kill-whole-word()
  (interactive)
  (backward-word)
  (kill-word 1))

(global-set-key (kbd "C-c w w") 'kill-whole-word)

(use-package eyebrowse
  :ensure t)

;; From this post:
;; https://www.reddit.com/r/emacs/comments/43vfl1/enable_wordwrap_in_orgmode/czl98d4/
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; Taken from this Wordpress blog post:
;; https://ericjmritz.wordpress.com/2015/10/14/some-personal-hydras-for-gnu-emacs/#desktops
(defhydra hydra-desktop (:color pink
				:hint nil)
  "
    ^Change desktops^
    ^^^^^^^^^^-----------------------------
    _c_: clear the desktop
    _s_: save the desktop
    _r_: revert the desktop
    _d_: change the directory for the desktop
    _q_: quit
    "
  ("c" desktop-clear "clear")
  ("s" desktop-save "save")
  ("r" desktop-revert "revert")
  ("d" desktop-change-dir "dir")
  ("q" nil))

  (global-set-key (kbd "C-$") 'hydra-desktop/body)

(use-package vterm
  :ensure t)

(use-package magit
  :ensure t)

(use-package emmet-mode
  :ensure t
  :hook ((mhtml-mode css-mode scss-mode rjsx-mode) . emmet-mode))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package log4j-mode
  :ensure t)

(use-package counsel
  :ensure t
  :bind ("C-s" . counsel-grep-or-swiper))

(use-package csv-mode
  :ensure t
  :mode (".tsv" ".csv" ".tabular" ".vcf"))

(use-package logview
  :ensure t)

(defun ef/lsp-mode-setup ()
  ;; Taken from this 'System Crafters' video:
  ;; https://www.youtube.com/watch?v=E-NAM9U5JYE
  ;; This allows breadcrumb segments to appear in projects
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  ;; Taken from this page:
  ;; https://www.mattduck.com/lsp-python-getting-started.html
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  ;; Set 'lsp-idle-delay' to 0.5 seconds for quick autocompletion
  (setq lsp-idle-delay 0.5))

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package web-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package diminish
  :ensure t
  :init
  (diminish 'hungry-delete-mode)
  (diminish 'beacon-mode)
  (diminish 'which-key-mode)
  (diminish 'subword-mode)
  (diminish 'rainbow-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  ;; Taken from this SO post:
  ;; https://stackoverflow.com/questions/46696009/adding-a-custom-yasnippet-directory-to-spacemacs
  (setq yas-snippet-dirs (append yas-snippet-dirs '("~/.emacs.d/snippets")))
  (yas-reload-all))

(add-hook 'c-mode-hook 'yas-minor-mode)
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)
(add-hook 'org-mode-hook 'yas-minor-mode)
(add-hook 'nxml-mode-hook 'yas-minor-mode)

(setq org-src-tab-acts-natively nil)

(setq electric-pair-pairs '(
			    (?\( . ?\))
			    (?\[ . ?\])
			    (?\{ . ?\})			    
			    ))

(electric-pair-mode 1)

;; Disable pairing of '<' with '>' to avoid weird expansion issues in Org-Mode for Yasnippets:
(add-function :before-until electric-pair-inhibit-predicate
	      (lambda (c) (eq c ?<)))

(progn
  (setq-default indent-tabs-mode nil)
  )

(use-package aggressive-indent
  :ensure t
  :hook
  (css-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (js-mode . aggressive-indent-mode)
  (typescript-mode . aggressive-indent-mode)
  (lisp-mode . aggressive-indent-mode)
  :custom
  (aggressive-indent-comments-too t)
  :config
  (add-to-list 'aggressive-indent-protected-commands 'comment-dwim))

(use-package css-mode
  :custom
  (css-indent-offset 2))

(use-package discover-my-major
  :ensure t)

(global-set-key (kbd "C-h M-a") 'discover-my-major)
(global-set-key (kbd "C-h M-o") 'discover-my-mode)

(use-package free-keys
  :ensure t)

(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  :config
  (setq helm-move-to-line-cycle-in-source t))

(use-package helm-swoop
  :ensure t)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-p") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-n") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-p") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-n") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)

;; Taken From Xah Lee's Site:
;; http://ergoemacs.org/emacs/emacs_dired_tips.html

;; Also taken from this SO post:
;; https://stackoverflow.com/questions/1839313/how-do-i-stop-emacs-dired-mode-from-opening-so-many-buffers

;; Make a wrapper function to force dired-mode to load first:
(with-eval-after-load 'dired
  ;; Disable annoying warning to utilize 'dired-find-alternate-file' function:
  (put 'dired-find-alternate-file 'disabled nil)

  ;; Nuke 'dired' mode's ability to unnecessarily create so many buffers with the sane 'ENTER' key press:
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

  ;; Do the same action, but for the '^' key as well since the same issue of creating too many buffers exists
  ;; for the '^' key by default
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive)
      (find-alternate-file ".."))))

(use-package ranger
  :ensure t)

(setq ranger-show-hidden t)

(remove-hook 'dired-mode-hook 'ranger-set-dired-key)

(setq browse-url-browser-function 'eww-browse-url)

(defun my-org-capture (&rest args)
  (interactive)
  (let ((split-window-preferred-function 'split-window-vertically))
    (funcall 'org-capture)))

(global-set-key (kbd "C-c c") 'my-org-capture)

(add-hook 'org-mode-hook
	  (lambda ()
	    (electric-indent-local-mode -1)))

(setq org-adapt-indentation nil)

(setq org-startup-folded t)

(setq org-log-into-drawer "LOGBOOK")

(setq org-agenda-files (append
			(file-expand-wildcards "~/hub/notes_private/*.org")))

(setq org-src-window-setup 'current-window)

(add-to-list 'org-structure-template-alist
	     '("el" . "src emacs-lisp"))

;; From a wonderful person named Samuel Loury from the Emacs Org Mode mailing list --> props to their assistance on this:
(defun my/org-trigger-hook (change-plist)
  (let* ((type (plist-get change-plist :type))
	 (pos (plist-get change-plist :position))
	 (from (substring-no-properties (or (plist-get change-plist :from) "")))
	 (to (substring-no-properties (or (plist-get change-plist :to) "")))
	 )
    (when (and
	   (eq type 'todo-state-change)
	   (member to org-done-keywords)
	   (member from org-not-done-keywords)
	   )
      (org-priority (string-to-char " ")))))

(add-hook #'org-trigger-hook
	  #'my/org-trigger-hook)

(advice-add 'ediff-window-display-p :override #'ignore) ; Open up ediff results in new windows not frames
(setq ediff-split-window-function 'split-window-vertically) ; Split the ediff results vertically

(setq make-backup-files nil)
(setq auto-save-default nil)

(defun config-edit ()
  (interactive)
  (find-file "~/hub/SamsEmacs/configuration.org"))
(global-set-key (kbd "C-c e") 'config-edit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/hub/SamsEmacs/configuration.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(defun begin-scale-text-and-show-images ()
  (require 'face-remap)
  (hide-mode-line-mode 1)
  (org-display-inline-images)
  (setq text-scale-mode-amount 2)
  ;; Enable 'text-scale-mode', disable 'beacon-mode', and disable 'blink-cursor-mode' while presenting
  (text-scale-mode 1)
  (beacon-mode 0)
  (blink-cursor-mode 0))

(defun end-scale-text-and-show-images ()
  (hide-mode-line-mode 0)
  ;; Presentation is finished: Disable 'text-scale-mode', re-enable 'beacon-mode', and re-enable 'blink-cursor-mode'
  (text-scale-mode 0)
  (beacon-mode 1)
  (blink-cursor-mode 1))

(use-package org-tree-slide
  :ensure t
  :hook ((org-tree-slide-play . begin-scale-text-and-show-images)
  (org-tree-slide-stop . end-scale-text-and-show-images))
  :custom
  (org-image-actual-width nil))

(use-package hide-mode-line
  :ensure t)

(use-package webpaste
  :ensure t
  :bind (("C-c C-p C-b" . webpaste-paste-buffer)
	 ("C-c C-p C-r" . webpaste-paste-region)
	 ("C-c C-p C-p" . webpaste-paste-buffer-or-region))
  :config
  (progn
    (setq webpaste-provider-priority '("dpaste.org"))))

(use-package sx
  :ensure t
  :config
  (bind-keys :prefix "C-c s"
	     :prefix-map sx-map
	     :prefix-docstring "Global keymap for SX."
	     ("q" . sx-tab-all-questions)
	     ("i" . sx-inbox)
	     ("o" . sx-open-link)
	     ("u" . sx-tab-unanswered-my-tags)
	     ("a" . sx-ask)
	     ("s" . sx-search)))

;; NOTE:
;; 2 related functions to keep in mind:
;; 1. 'ytdl-download': Used for downloading videos directly from YouTube
;; 2. 'ytdl-download-playlist': Used for downloading YouTube playlists
;; Reference link:
;; https://www.reddit.com/r/emacs/comments/hxbmda/ytdl_an_emacs_interface_for_youtubedl/
(use-package ytdl
  :ensure t)
