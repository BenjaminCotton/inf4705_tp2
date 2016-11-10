changequote(`<', `>')

\documentclass[letterpaper,12pt,final]{article}

\usepackage{datatool}

%% For the lab, we want to number the subsections in roman numerals to
%% follow the assignment
\renewcommand{\thesubsection}{\thesection.\roman{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\alph{subsubsection}}

%%%%%%%%%%%%%%%%%%%%%%%%
%tmp
\usepackage{color}
\newcommand{\hilight}[1]{\colorbox{yellow}{\parbox{\dimexpr\linewidth-2\fboxsep}{#1}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Détails de langue pour bien supporter le français
%  Accepte les caractères accentués dans le document (UTF-8).
\usepackage[utf8]{inputenc}
% Police de caractères plus complète et généralement indistinguable
% visuellement de la police standard de LaTeX (Computer Modern).
\usepackage{lmodern}
% Bon encodage des caractères pour que les lecteurs de pdf
% reconnaissent les accents et les ligatures telles que ffi.
\usepackage[T1]{fontenc}
% Règles typographiques et d' "hyphenation" propres aux langues
\usepackage[english,frenchb]{babel}


%%%% Packages pour les références
\usepackage{hyperref}
\usepackage[numbers]{natbib}


%%%% Packages pour l'affichage graphique
% Charge le module d'affichage graphique.
\usepackage{graphicx}
% Recherche des images dans les répertoires.
\graphicspath{{./dia}}
% Un float peut apparaître seulement après sa définition, jamais avant.
\usepackage{flafter}
% Hyperlien vers la figure plutôt que son titre.
\usepackage{caption}
\usepackage{subcaption}
\usepackage{gnuplottex}
\usepackage{geometry}

%% Exemple de figure:
% \begin{figure}[h]
%   \centering
%     \includegraphics[width=\linewidth]{./dia/diagramme.png}
%   \caption{Diagramme de classes du projet}\label{fig:dia_classes}
% \end{figure}



%%%% Packages pour l'affichage de différents types de texte
% Code source:
\usepackage{listings} % Code inline: \lstinline|<code here>|
\lstset{basicstyle=\ttfamily\itshape}
% Symboles mathématiques
\usepackage{amssymb}
% Manipulation de l'espace (page titre)
\usepackage{setspace}
%
% Ligne horizontale pour l'affichage du titre
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}


%%%% Variables pour le document
% Type de rapport
\newcommand{\monTypeDeRapport}{Rapport de laboratoire}
% Titre du document
\newcommand{\monTitre}{TP2}
% Auteurs
\newcommand{\mesAuteurs}{Premier Auteur, Second Auteur}
\newcommand{\mesAuteursX}{Premier Auteur, XXXXXXX \\ Second Auteur, XXXXXXX}
% Sigle du cours
\newcommand{\monCoursX}{INF4705}
% Nom du cours
\newcommand{\monCours}{Analyse et conception d’algorithmes}


%%%% Informations qui sont stockées dans un fichier PDF.
\hypersetup{
  pdftitle={\monTitre},
  pdfsubject={\monCours},
  pdfauthor={\mesAuteurs},
  bookmarksnumbered,
  pdfstartview={FitV},
  hidelinks,
  linktoc=all
}



\begin{document}
    %% Page titre du rapport
    \begin{titlepage}
      \begin{center}

        \begin{doublespace}

          \vspace*{\fill}
          \textsc{ \large \monTypeDeRapport}
          \vspace*{\fill}

          \HRule \\ [5mm]
          {\huge \bfseries \monTitre}\\ [3mm]
          \HRule \\
          \vspace*{\fill}

          \begin{onehalfspace} \large
            \mesAuteursX
          \end{onehalfspace}

          \vfill
          { \Large Cours \monCoursX \\ \monCours } \\

          \today

        \end{doublespace}
      \end{center}
    \end{titlepage}

\newpage

%% Insertion d'une table des matières
%  Cette ligne peut être enlevée si l'on ne 
%  veut pas de table des matières.
\tableofcontents\newpage

define(voraceit, \textit{vorace probabiliste})
define(Voraceit, \textit{Vorace probabiliste})
define(progdynit, \textit{programmation dynamique})
define(Progdynit, \textit{Programmation dynamique})
define(tabouit, \textit{Avec tabou})
define(Tabouti, \textit{avec tabou})

\section{Introduction}

Dans le but d'apprendre à décider quel algorithme utiliser dans
différentes situations, il est primordial de s'exercer à l'analyse de
ceux-cis.  L'objectif de ce laboratoire est donc de faire l'analyse
selon plusieurs techniques vues en classe d'algorithmes de sélection que
nous implémentons nous-mêmes.  Suivant l'introduction de ces
algorithmes ainsi que le cadre expérimental et les données, notre
analyse de ceux-cis sera exposée en utilisant les approches empirique,
théorique et hybride pour finalement décider des situations où chacun
est avantageux. 

Pour pouvoir avoir des résultats représentatifs d'une situation
réelle, les algorithmes seront utilisés pour trouver la tour la plus
haute qu'il est possible de former avec un certain nombre de blocs de
dimensions différentes. L'important est que chaque bloc repose
entièrement sur celui en dessous. En d'autres mots, il faut garantir
une inclusion stricte de la base du bloc supérieur sur le bloc
receveur.

\section{Algorithmes implémentés}

Les algorithmes implémentés sont deux algorithmes probabilistes, soit
l'algorithme glouton (voraceit) et l'algorithme tabouit, et un
algorithme déterministe, soit l'algorithme de progdynit. L'algorithme
voraceit inclut un aspect aléatoire dans son choix de bloc à placer
dans la tour. C'est pourquoi il est nécessaire de l'exécuter plusieurs
fois afin s'assurer d'avoir une hauteur de tour
satisfaisante. L'algorithme tabouit, quant à lui, va toujours
retourner la même tour, mais celle-ci ne sera pas nécessairement la
plus haute possible avec les blocs utilisables. Par contre, la
solution retournée sera un peu plus réfléchie que celle de
l'algorithme glouton. Pour être sûr d'avoir la plus haute tour
possible, il faut exécuter l'algorithme de progdynit.

Dans les algorithmes implémenté, l'importance a été mit sur le temps
d'exécution. On ne cherche donc pas à en particulier à minimiser
l'utilisation de la mémoire.

Tous les algorithmes et le code pour les chronométrer se trouvent dans le répertoire
\lstinline|algorithms|.  Le répertoire \lstinline|script| contient les
différents scripts qui permettent de réunir les données.  Le fichier
\lstinline|tp.sh| ne fait qu'appeler le script
\lstinline|./script/tp.py|.

\section{Cadre expérimental}

Les algorithmes sont implémentés dans le langage \textit{Python 3}.
L'exécution est faite sur un portable Thinkpad x220.  En particulier,
les informations concernant le matériel utilisé sont présentées à la
figure~\ref{lst:hardware}.

\begin{figure}[htbp]
  \centering
  \lstinputlisting[breaklines=true]{results/hardware.txt}
  \caption{Matériel utilisé pour l'exécution des chronométrages}\label{lst:hardware}
\end{figure}

Afin d'améliorer la précision des mesures de temps, il est préférable
de changer la politique de changement de fréquence des processeurs
pour qu'elle assure une fréquence plutôt constante.  En effet, on
utilise la fonction \lstinline|time.process_time()| de Python, qui
donne la somme du temps du côté utilisateur et noyau et ainsi ce temps
est obtenu en prenant le compte des \textit{ticks} de processeur
divisé par la fréquence actuelle \cite{PEP418}.  Alors, si cette
fréquence change entre les mesures, cela peut avoir un effet sur les
temps mesurés.  Cependant, les permissions accordées aux étudiants
dans les laboratoires ne permettent pas de changer cette
configuration.  C'est pour cette raison que nous faisons les banc
d'essais sur un machine qui nous donne les droits d'administration.
La commande utilisée est~:
\lstinline|sudo cpupower frequency-set -g performance|.

% see https://wiki.archlinux.org/index.php/CPU_frequency_scaling

\section{Jeux de données}

Il y a, au total, 80 exemplaires de données; dix pour chacun des huit
jeux de tests. Chaque jeu de test correspont à une quantité de
dimensions de blocs dans les exemplaires. Par contre, le vrai nombre
de bloc est trois fois plus grand, car il existe un bloc pour chacune
des 3 façons de placer ces dimensions (la hauteur peut être la
première dimension, la deuxième ou la troisième) Par exemple, le jeu
de test 100 contient 10 exemplaires de 300 blocs, numérotés de 0 à
9. Les quantités de dimensions sont : 100, 500, 1000, 5000, 10000,
50000, 100000 et 500000. Pour l'analyse de l'algorithme, seule la
moyenne de chaque série de 10 exemplaires sera pris en note.

\section{Résultats}

Les résultats sont présentés dans la figure~\ref{lst:results}.  Ils
montrent les fichiers obtenus par nos bancs d'essais.  La première
colonne donne la taille des exemplaires utilisés pour le
chronométrage, et la colonne suivante correspond à la moyenne de temps
d'exécution (en secondes) pour les exemplaire de la taille donnée.  Il
y a un fichier de résultats par algorithme.

\begin{figure}[p]
  \centering
  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/vorace.dat}
    \caption{voraceit}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/progdyn.dat}
    \caption{progdynit}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/tabou.dat}
    \caption{tabouit}
  \end{subfigure}

  \caption{Fichiers de résultats}\label{lst:results}
\end{figure}

\section{Analyse}

Les résultats obtenus à la section précédente sont analysés ici selon
les diverses méthodes vues en cours.

\subsection{Tests de puissance}

Les tests de puissance nous permettent d'estimer le degré de la
fonction de complexité s'il s'agit d'un polynôme ou bien de constater
que la complexité est super-polynômiale ou sub-linéaire.

%define(<powertest>, <
\subsubsection{$3}
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[terminal=epslatex, terminaloptions=color dashed]
    set print $2
    print "Série, m, b"
    g(x) = 10**b*x**m
    fit g(x) $1 u 1:2 via m,b
    print "0-9,",m,",", b

    set grid
    set xlabel "Nombre de dimensions [-]"
    set ylabel "Temps d'exécution [s]"
    set logscale xy
    set key center top
    plot $1 u 1:2 w linesp t "Série [ 0- 9]"
    g(x) w l t "Régression"
  \end{gnuplot}
  \caption{Tests de puissance pour $3}\label{fig:$4}
\end{figure}

\DTLloaddb{powerdb}{$2}

\begin{table}[htbp]
  \centering
  \DTLdisplaydb{powerdb}
  \caption{Résultats des tests de puissance pour $3}\label{tbl:$4}
\end{table}

\DTLmeanforcolumn{powerdb}{m}{\meanm}
\DTLmeanforcolumn{powerdb}{b}{\meanb}
\DTLdeletedb{powerdb}

Le graphique log-log des temps d'exécution pour l'algorithme $3 est
affiché à la figure \ref{fig:$4}. En faisant une régression linéaire
sur les points en coordonnées log-log, ou, autrement dit, en faisant
une régression avec une fonction de la forme $f(x) = 10^b \cdot x^m$,
on obtient les valeurs consignées au tableau \ref{tbl:$4}.

La fonction trouvée est donc (en prenant les moyennes) :
$$f(x) = 10^{\meanb} \cdot x^{\meanm}$$.
%>)

powertest("./results/vorace.dat", "./results/vorace_fit.csv", <voraceit>, powvorace)

Le degré est donc très près de 1 et on peut s’attendre à ce que la
complexité s’approche de $O(n)$.

powertest("./results/progdyn.dat", "./results/progdyn_fit.csv", <progdynit>, powprogdyn)

Les résultats sont similaires à ceux du voraceit sans récursivité,
mais le coefficient constant est inférieur et la puissance est un peu
supérieure.  Cela suggère toujours une complexité $O(n)$, cependant
avec un coefficient constant plus bas.

powertest("./results/tabou.dat", "./results/tabou_fit.csv", <tabouit>, powtabou)

On a obtenu un $m$ un peu supérieur encore, mais toujours proche de 1.
Étant donné que l'exposant est inférieur à 2, on se doute que la
complexité est bornée supérieurement avec $O(n^2)$.  On peut se douter
qu'elle doit être supérieure à $O(n)$ et qu'elle est peut-être près de
$O(n\cdot{}log(n))$.

\subsection{Complexités théoriques}

Pour le voraceit, la consommation théorique en meilleur cas et en cas
moyen (pour un tableau uniformément distribué) est de $\Theta(n)$. Le
pire cas est de $O(n^2)$ dans le cas où la plupart des élément ne peut
être mit sur un autre bloc à cause de dimensions trop disproportionnés
(longueur beaucoup plus grande que profondeur).

Pour le progdynit, la consommation théorique en meilleure cas, en pire
cas et en cas moyen est de $\Theta(n*log(n))$.

Pour le tabouit, la consommation théorique en meilleure cas, en pire
cas et en cas moyen est de $\Theta(n*log(n))$.

\subsection{Test du rapport}

%define(<ratiotest>, <
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[scale=0.8, terminal=epslatex, terminaloptions=color dashed]
    f(x) = $5
    set grid
    set xlabel "Taille des exemplaires à trier [-]"
    set ylabel "Rapport du $y/f(x)$ pour $f(x) = $6$ [-]"
    set key center top
    set format y '%g'
    set xtics 1e5
    plot $1 u 1:($<>2/f($<>1)) w linesp t "Série [ 0- 9]"
  \end{gnuplot}
  \caption{Tests du rapport pour $3}\label{fig:$4}
\end{figure}
%>)

\subsubsection{Voraceit}

Comme on peut le voir à la figure \ref{fig:ratiovoraceba}, pour toutes
les séries, le ratio du temps d'exécution à la fonction d'ordre de
complexité au meilleur et moyen cas semble converger à une valeur plus
grande que $0$.  Cette fonction paraît être une bonne estimation.
Cependant, pour ce qui est du pire cas, le ratio converge vers $0$, ce
qui est clair à la figure \ref{fig:ratiovoracew}. C'est alors une
surestimation.

ratiotest("./results/vorace.dat", ,<voraceit au meilleur cas et au cas moyen>, <ratiovoraceba>, <x>, <x>)

ratiotest("./results/vorace.dat", ,<voraceit au pire cas>, <ratiovoracew>, <x**2>, <x^2>)

\subsubsection{Progdynit}

Comme le montre la figure \ref{fig:ratioprogdynba}, le ratio pour
progdynit au meilleur et moyen cas paraît éventuellement
converger à une valeur supérieure à $0$, quoique faiblement, elle
pourrait aussi diverger.  Cette fonction paraît être une estimation
acceptable mais possiblement un sous-estimation.  Cependant, pour ce
qui est du pire cas, le ratio converge vers $0$, cela est visible à la
figure \ref{fig:ratioprogdynw}. Cette fonction est une surestimation.

ratiotest("./results/progdyn.dat", ,<progdynit au meilleur cas et au cas moyen>, <ratioprogdynba>, <x>, <x>)

ratiotest("./results/progdyn.dat", ,<progdynit au pire cas>, <ratioprogdynw>, <x**2>, <x^2>)

\subsubsection{Tabouit}

Le graphe à la figure \ref{fig:ratiotabou} montre la convergence du
rapport pour le tabouit.  L'estimation est sensée.

ratiotest("./results/tabou.dat", ,<tabouit au meilleur cas, au cas moyen et au pire cas>, <ratiotabou>, <x*log(x)>, <x*log(x)>)

\subsection{Test des constantes}

%define(<constest>, <
\subsubsection{$3}
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[scale=0.8, terminal=epslatex, terminaloptions=color dashed]
    f(x) = $5
    g(x) = a*f(x) + b

    set print $2
    print "Série, a, b"
    a = 0.001
    b = 0.001
    fit g(x) $1 u 1:2 via a,b
    print "0-9,",gprintf('%.10f',a),",", b

    set grid
    set xlabel "$f(x)$ avec $f(x) = $6$ [-]"
    set ylabel "Temps d'exécution moyen de l'algorithme [s]"
    set key center top
    set format y '%g'
    set xtics $7
    plot $1 u (f($<>1)):2 w linesp t "Série [ 0- 9]"
  \end{gnuplot}
  \caption{Tests des constantes pour $3}\label{fig:$4}
\end{figure}

\DTLloaddb{constdb}{$2}

\begin{table}[htbp]
  \centering
  \DTLdisplaydb{constdb}
  \caption{Résultats des tests de constante pour $3}\label{tbl:$4}
\end{table}

\DTLmeanforcolumn{constdb}{a}{\meana}
\DTLmeanforcolumn{constdb}{b}{\meanb}
\DTLdeletedb{constdb}

La figure \ref{fig:$4} montre la courbe du test et le tableau
\ref{tbl:$4} donne la valeur de pente $a$ et d'ordonnée à l'origine
$b$ pour la régression linéaire. En moyenne, on obtient la
fonction de coût en secondes selon la grandeur du tableau d'entrée
$C$: $$C(x) = \meana \cdot{} ($6) + (\meanb)$$
%>)

constest("./results/vorace.dat","./results/vorace_constfit.csv",<voraceit au meilleur cas et au cas moyen>, <constvorace>, <x>, <x>, <100000>)

Pour le voraceit, on a choisit le cas moyen/meilleur cas
($\Theta(n)$).  La courbe semble assez droites, donc l'estimation
est sans doute bonne.  Le coût fixe négatif paraît étrange, cependant,
il faut se rappeller que nos données conscernent le comportement
asymptotique avec de grands exemplaires.  Un comportement différent
pour les petites valeurs est attendu.

constest("./results/progdyn.dat","./results/progdyn_constfit.csv",<progdynit au meilleur cas et au cas moyen>, <constprogdyn>, <x>, <x>, <100000>)

Le choix du cas est identique pour la progdynut.  On
constate encore des courbes assez droites et donc un régression assez
précise.

constest("./results/tabou.dat","./results/tabou_constfit.csv",<tabouit au meilleur cas, au cas moyen et au pire cas>, <consttabou>, <x*log(x)>, <x*log(x)>, <auto>)

Pour tabouit , on a choisit la fonction
$n\cdot{} log(n)$ pour le test des constantes.  La courbe sont
enncore une fois assez droites.  Le coût fixe est près d'être nul, ce
qui n'est pas trop étonnant.

\section{Discussion}

Pour l'algorithme voraceit, on remarque que les
calculs se font très rapidement comparé au deux autres. De plus, la
consommation de ressource est assez minimes; il n'y a qu'une liste des
objects a essayer de mettre dans la tour et une liste des objets déjà
présents dans la tour. L'implémentation est très facile, car c'est une
simple analyse de la possibilité d'insérer un bloc aléatoire dans la
tour. Par contre, la qualité de la solution ressortit est aussi
aléatoire, donc vraiment pas optimale.

Pour la progdynit, le temps de calcul est extrèmement long et la
consommation de ressource aussi (une tour pour chaque bloc), mais la
solution ressortit est la solution optimale. L'implémentation est un
peu plus difficile, car il faut s'assurer que toutes les possibilités
sont testés sans faire de calculs superflus.

L'algorithme tabouit est le juste milieu entre les 2 solutions
proposés précédemment. Le temps de calcul est plus ou moins grand et
les ressources nécessaires ne sont pas trop grandes; une tour à
retourner, une tour temporaire, une tour d'itération et une liste des
bloc à essayer de placer. La solution ressortit est toujours la même
et elle ne sera pas optimale. Par contre, elle est un plus réfléchie
que pour l'algorithme voraceit. La partie de l'implémentation qui a
été un peu plus complexe a été de penser aux conditions faisant en
sorte qu'un bloc était rejeté sans avoir à observer la tour complète.

Le meilleur algorithme à utiliser dépend de ce que l'usager
désire. Pour obtenir la meilleure solution, il faut utiliser la
progdynit. Par contre, il faut avoir beaucoup de temps de disponible
et il ne faut pas avoir trop de bloc, car déjà avec 50000 blocs, il
faut plus de 30 minutes pour trouver la solution.

Si le désire est plutôt d'être rapide et d'avoir une possibilité
d'avoir une bonne hauteur de tour, il suffit d'utiliser l'algorithme
voraceit une dizaine de fois et d'utiliser la meilleure solution
ressortit. On aura donc une chance d'avoir la plus haut tour tout en
ayant pris moins de temps qu'en utilisant un des deux autres
algorithmes.

L'utilisation de l'algorithme tabouit serait plus à utiliser pour
trouver une solution qui servira à comparer celles ressortit pas
l'algorithme voraceit.

\section{Conclusion}

En conclusion, chaque algorithme de sélection
possède ses avantages et ses inconvenients, il suffit de savoir ce qui
est plus important pour l'usager avant de prendre une décision sur
l'implémentation à faire. Ce qui est sûr est que trouver la solution
optimale est beaucoup plus difficile et demandant que ce que l'on
pourrait penser et qu'il est donc parfois mieux de trouver une bonne
solution plutôt que la meilleure solution à un problème.

\clearpage
\bibliographystyle{plainnat} %% or perhaps IEEEtranN
\bibliography{rapport}

\end{document}
