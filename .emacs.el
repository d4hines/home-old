(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("celpa" . "https://celpa.org/packages/") t)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (markdown-mode origami-predef dune-format dune origami git-link symbol-overlay auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
(global-set-key (kbd "C-x p") (lambda ()
                                (interactive)
                                (other-window -1)))
(global-set-key (kbd "M-q") 'set-mark-command)
(global-set-key (kbd "M-e") (lambda ()
                                (interactive)
                                (set-mark-command 1)
			        ))
;; (ac-config-default)
;; (setq merlin-ac-setup 'easy)
;; (global-set-key (kbd "<C-tab>") 'auto-complete)
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
(add-hook 'merlin-mode-hook 'origami-mode)
(add-hook 'merlin-mode-hook 'origami-predef-global-mode)
(require 'symbol-overlay)
(global-set-key (kbd "M-i") 'symbol-overlay-put)
(global-set-key (kbd "M-r") 'symbol-overlay-query-replace)
(global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
(global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
(global-set-key (kbd "M-t") 'symbol-overlay-toggle-in-scope)
(global-set-key (kbd "M-c") 'symbol-overlay-remove-all)
(global-set-key (kbd "C-x <up>") 'origami-close-node)
(global-set-key (kbd "C-x <down>") 'origami-open-node)
(global-set-key (kbd "C-x C-<up>") 'origami-close-all-nodes)
(global-set-key (kbd "C-x C-<down>") 'origami-open-node-recursively)
(global-set-key (kbd "C-x C-/") 'origami-undo)
(global-set-key (kbd "C-x a f") "(*autofold*)")
(column-number-mode 1)
