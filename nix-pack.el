;;; nix-pack.el --- A pack to deal with specifics for nix/nixos development  -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Antoine R. Dumont

;; Author: Antoine R. Dumont <tony@dagobah>
;; Keywords: unix, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'package)

;; optional. makes unpure packages archives unavailable
;; (setq package-archives nil)

(defun nix-pack/add-package-directory (dir)
  "A function to add to PACKAGE-DIRECTORY-LIST if the DIR exists."
  (when (file-exists-p (expand-file-name dir))
    (add-to-list #'package-directory-list dir)))

(mapc #'nix-pack/add-package-directory '("/run/current-system/sw/share/emacs/site-lisp/elpa" ;; for emacs global install (nixos - emacs24PackagesNg)
                                         "/run/current-system/sw/share/emacs/site-lisp/"     ;; for emacs global install (nixos - emacs24Packages)
                                         "~/.nix-profile/share/emacs/site-lisp/elpa"         ;; for emacs env install (nix-env  - emacs24PackagesNg)
                                         "~/.nix-profile/share/emacs/site-lisp/"))           ;; for emacs env install (nix-env  - emacs24Packages)

(require 'install-packages-pack)
(install-packages-pack/install-packs '(nix-mode
                                       smartscan))

(require 'nix-mode)
(add-hook 'nix-mode-hook (lambda () (smartscan-mode 1)))

(provide 'nix-pack)
;;; nix-pack.el ends here
