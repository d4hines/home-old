(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("celpa" . "https://celpa.org/packages/") t)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Theme and style
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'nord t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'column-number-mode)
(tool-bar-mode -1)

;; company mode adds autocomplete to buffers
;; It's worth reading docs briefly: https://company-mode.github.com
(add-hook 'after-init-hook 'global-company-mode)

;; which-key adds a buffer that tells you what
;; your next options can be after pressing a key combination.
;; e.g. Pressing 'C-x' will list all the commands that start
;; with 'C-x'
(add-hook 'after-init-hook 'which-key-mode)

;; Vim key-bindings
;; Worth reading docs briefly: https://evil.readthedocs.io
(require 'evil)
(setq evil-toggle-key "C-S-z")
(evil-mode 1)

;; Navigate to previous window. Inverse of 'C-x o'
(global-set-key (kbd "C-M-k") (lambda ()
                                (interactive)
                                (other-window -1)))

;; Navigate to the next window. Equivalent to 'C-x o'
(global-set-key (kbd "C-M-j") (lambda ()
                                (interactive)
                                (other-window 1)))

;; Custom compilation output window


;; No idea what all this is yet.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (markdown-mode origami-predef dune-format dune origami git-link symbol-overlay auto-complete))))
(setq compilation-scroll-output t)
(setq compilation-window-height 10)
(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window compilation-window-height))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

;; OCaml specific things
(add-hook 'merlin-mode-hook 'origami-mode)
(add-hook 'merlin-mode-hook 'origami-predef-global-mode)
(global-set-key (kbd "C-x <up>") 'origami-close-node)
(global-set-key (kbd "C-x <down>") 'origami-open-node)
(global-set-key (kbd "C-x C-<up>") 'origami-close-all-nodes)
(global-set-key (kbd "C-x C-<down>") 'origami-open-node-recursively)
(global-set-key (kbd "C-x C-/") 'origami-undo)
(global-set-key (kbd "C-x a f") "(*autofold*)")
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (origami which-key tuareg nord-theme evil company atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
