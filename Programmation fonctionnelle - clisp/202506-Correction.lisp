; Regroupement - Programmation fonctionnelle - LISP
; Vendredi 13 juin 2025

; Remarques et commentaires :
; - Commencez par lire le sujet dans son intégralité.
; — Les exercices sont indépendants les uns des autres. -Facilitez la lecture et la compréhension des codes proposés.
; - Copier/coller la question avant de répondre, envoyez vos réponses à otman.manad02@univ-paris8.fr - sujet:
; Regroupement_PFL1_Nom_Prénom_NumEtudiant en PDF nommé: Regroupement_PFL1_Nom Prénom_NumEtud.

; -----------------------------------------
; Epreuve 1
; -----------------------------------------

; Que rendent les évaluations des expressions suivantes, données par l'interprète de LISP 
; (expliquez les intermédiaires) : 
; a) (car (cdr '((a b) (c d) (e) f))) 
; b) (car (cdr (car '((a b c) (d e f)) ))) 
; c) (car (cdr '(car ((a b c) (d e f)) ))) 
; d) (car '(cdr (car ((a b c) (d e f))))) 
; e) (eval (cons '+ (cons 4 (list 5)))) 
; f) (list? (+2 3)) 
; g) (pair? (cons 'a ’b)) 
; h) (list? (cons 'a ’b))

; -----------------------------------------
; Epreuve 2 :
; -----------------------------------------

; On dispose d’une liste de doublets associant des types d’IA et un score de biais (nombre réel ou 
; entier).
; ((“IA-type1” . 0.12) (“IA-type2” . 0.08) ...)

; - Construire récursivement une liste contenant uniquement les valeurs de biais. 
; Fonction attendue : (extraire-biais liste-doublets) -> (0.12 0.08 ...)

; - Calculer ensuite le biais moyen à partir de cette liste de scores 
; Fonction attendue : (biais-moyen liste-doublets) -> valeur-moyenne

; A. On dispose d un arbre (liste récursive) contenant des chaînes de caractères représentant des concepts d’IA (ex. “NLP”, “ML”, “AI”, “Robotics”, “XAI”, etc.).
 
;  - Ecrire une fonction chirurgicale récursive qui modifie l’arbre en place pour ne garder que les chaînes dont la longueur est > n (filtrage de termes suivant n).
; Fonction attendue :
; (filtrer-concepts n arbre) → arbre modifié (toutes chaînes < n supprimées)

; Astuce 1: Utilisez string et length pour les calculs.
; Astuce 2: Commencez par écrire une version non chirurgicale pour construire un nouvel arbre, puis transformez-la en
; version chirurgicale (modifie la liste originalement).

; Bon  courage.
; O.Manad {otman.manad02@univ-paris8.fr}


; -----------------------------------------
; Epreuve 1 - Reponses
; -----------------------------------------

; a)
(car (cdr '((a b) (c d) (e) f)))
; Avec cdr, on prend la suite de la liste après le 1er élément. Cela donne l'équivalent de:
(car '((c d) (e) f))
; Avec car, on prend le 1er élément de la liste, soit:
(c d)

; b)
(car (cdr (car '((a b c) (d e f)) ))) 
; Avec car, on prend le 1er élément de la liste. Cela donne::
(car (cdr '(a b c)))
; Avec cdr, on prend la suite de la liste après le 1er élément. Cela donne:
(car '(b c))
; Avec car, on prend le 1er élément de la liste, soit:
b

; c) 
(car (cdr '(car ((a b c) (d e f)) ))) 
; Avec cdr, on prend la suite de la liste après le 1er élément. Cela donne: 
(car '(((a b c) (d e f))))
; Avec car, on prend le 1er élément de la liste. Cela donne:
((a b c) (d e f))

; d) 
(car '(cdr (car ((a b c) (d e f)))))
; Avec car, on prend le 1er élément de la liste. Cela donne:
cdr

; e) 
(eval (cons '+ (cons 4 (list 5)))) 
; On évalue d'abord l'expression la plus interne, qui est (list 5), ce qui donne:
(eval (cons '+ (cons 4 (5)))) 
; On évalue ensuite cons (celui de droite) avec ses deux arguments. Cela conne:
(eval (cons '+ (4 5))) 
; On évalue ensuite cons (celui qui reste) avec ses deux arguments. Cela donne:
(eval '(+ 4 5))
; On évalue ensuite l'expression eval avec son argument. Cela donne:
9

; f) 
(list? (+ 2 3))
; Strictement parlant, list? n'est pas du CLISP ni du Common LISP mais du Scheme (qui n'est pas enseigné en L1 à l'IED).
; Je suppose que vous vouliez dire:
(listp (+ 2 3))
; On évalue d'abord l'expression (+ 2 3), la plus interne, ce qui donne:
(lisp 5)
; 5 n'est pas une liste, donc on obtient
nil

; g) 
(pair? (cons 'a 'b))
; Strictement parlant, pair? n'est pas du CLISP ni du Common LISP mais du Scheme (qui n'est pas enseigné en L1 à l'IED).
; Je suppose que vous vouliez dire:
(consp (cons 'a 'b))
; On évalue d'abord l'expression (cons 'a 'b), la plus interne, ce qui donne:
(consp '(a . b))
; (a . b) est une paire, donc on obtient:


; h) 
(list? (cons 'a 'b))
; Strictement parlant, list? n'est pas du CLISP ni du Common LISP mais du Scheme (qui n'est pas enseigné en L1 à l'IED).
; Je suppose que vous vouliez dire:
(listp (cons 'a 'b))
; On évalue d'abord l'expression (cons 'a 'b), la plus interne, ce qui donne:
(listp '(a . b))
; (a . b) n'est pas une liste mais une paire. Pourtant, en Common LISP, listp regarde d'abord si l'argument est une paire
; et retourne true si c'est le cas. La fonction ne vérifie pas toute la liste. Donc, on obtient:
t

; -----------------------------------------
; Epreuve 2 - Réponses
; -----------------------------------------

; - Construire récursivement une liste contenant uniquement les valeurs de biais. 

; A chaque appel récursif, on extrait le biais du premier doublet et on l'ajoute à la liste résultante.
(defun extraire-biais (liste-doublets)
  (cond
    ((null liste-doublets) nil)
    (t (cons (cdar liste-doublets) (extraire-biais (cdr liste-doublets)))) ) )


; - Calculer ensuite le biais moyen à partir de cette liste de scores 

; La moyennd est la somme des biais divisée par le nombre de biais.
; On définit une fonction auxiliaire pour calculer la somme:

(defun somme (liste)
  (cond
    ((null liste) 0)
    (t (+ (car liste) (somme (cdr liste)))) ) )

; Puis une autre pour compter le nombre d'éléments:

(defun taille (liste)
  (cond
    ((null liste) 0)
    (t (+ 1 (compter (cdr liste)))) ) )

; Enfin, on peut calculer le biais moyen:
(defun moyenne-biais (liste-biais)
  (cond
    ((null liste-biais) 0)  ;; Cas particulier : liste vide -> moyenne 0
    (t (/ (somme liste-biais) (taille liste-biais)))))

; Test sur un exemple concret
(setq IA '(("IA-type1" . 0.12) ("IA-type2" . 0.08) ("IA-type3" . 0.15)  ("IA-type4" . 0.18)))

(extraire-biais IA)
; (0.12 0.08 0.15 0.18)

(moyenne-biais (extraire-biais IA))
; 0.13250001

; - Ecrire une fonction chirurgicale récursive qui modifie l’arbre en place pour ne garder que les chaînes dont la longueur est > n (filtrage de termes suivant n).

; L'algorithme est le suivant:
; - On parcourt l'arbre recursivement.
; - Si l'arbre est vide, on retourne un arbre vide (nil)
; - A chaque étape de la récusion, on vérifie si le premier ékément (car) de la liste est une chaîne de caractères. On a alors deux cas:
;   - Sa longueur est inférieure à n. Dans ce cas, on doit en quelque sorte replacer le doublet par le suivant:
;     - On replace le premier élement (car) par le premier élément du doublet suivant (cadr)
;     - On replace la suite de la liste (cdr) par la suite du doublet suivant (cddr)
;     - On continue la récursion sur ce nouveau doublet.
;   - Sa longueur est supérieure ou égale à n. Dans ce cas, on continue la récursion sur le reste de l'arbre (cdr).
; - Si le premier élément n'est pas une chaîne de caractères, on continue la récursion sur les sous-arbres (car et cdr).

(defun filtrer-concepts (n arbre)
  (print arbre)
  (cond
    ((null arbre) nil)
    ((stringp (car arbre))
      (cond 
        ((< (length (car arbre)) n)
          (rplaca arbre (car (cdr arbre)))
          (rplacd arbre (cdr (cdr arbre)))
          (filtrer-concepts n arbre) ) 
        (t (filtrer-concepts n (cdr arbre)) ) ) )
    (t
      (filtrer-concepts n (car arbre))
      (filtrer-concepts n (cdr arbre)) ) ) )

; Exemples concrets pour tester la fonction:

(setq concepts '("MLP" ("ML" "AI") ("Robotics" ("XAI" "XAI2"))))
(filtrer-concepts 2 concepts)
concepts
; ("MLP" ("ML" "AI") ("Robotics" ("XAI" "XAI2")))

(setq concepts '("MLP" ("ML" "AI") ("Robotics" ("XAI" "XAI2"))))
(filtrer-concepts 3 concepts)
concepts
; ("MLP" (nil) ("Robotics" ("XAI" "XAI2")))

(setq concepts '("MLP" ("ML" "AI") ("Robotics" ("XAI" "XAI2"))))
(filtrer-concepts 4 concepts)
concepts
; ((nil) ("Robotics" ("XAI2")))

; Note:
; - Il faut bien faire les opérations de modification dans le bon order: d'abord remplacer le car, puis le cdr.
; - Si on fait l'inverse, on risque de prendre le mauvais élément pour le car car le cdr a déjà été modifié.
; - Il faut bien réappliquer la récursion sur le même arbre modifié, car les éléments ont changés.

