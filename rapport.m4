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
%\usepackage[numbers]{natbib}


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
define(tabouit, \textit{avec tabou})
define(Tabouti, \textit{Avec tabou})

\section{Introduction}

Un aspect important de la conception d'algorithmmes est l'application
de différents patrons de conception, à laquelle il est primoridial de
s'exercer.  L'objectif de ce laboratoire est donc de concevoir,
d'implémenter, et d'analyser plusieurs algorithmes pour résoudre le
même problème d'optimisation de la taille d'une tour suivant certaines
contraintes.  Suivant l'explication sommaire du problème, du cadre
expérimental et les données, les choix de conception de nos
algorithmes seront exposés et l'analyse de leur complexité temporelle
sera discutée.

\section{Problème et algorithmes demandés}

Les algorithmes conçus devrons parvenir à maximiser la taille d'une
tour faite avec des blocs dont la taille est donnée.  Un bloc ne peut
être placé sur un autre que s'il peut reposer complètement dessus,
c'est à dire que sa largeur et sa profondeur sont inférieures à celles
du bloc inférieur.

Les algorithmes implémentés sont deux algorithmes probabilistes, soit
l'algorithme glouton (voraceit) et l'algorithme tabouit, et un
algorithme déterministe, soit l'algorithme de progdynit. L'algorithme
voraceit doit aussi inclure un aspect aléatoire dans son choix de bloc
à placer dans la tour.

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
pour qu'elle assure une fréquence plutôt constante.  En effet, nous
exécutons la commande suivante avant de collecter les résultats~:
\lstinline|sudo cpupower frequency-set -g performance|.

% see https://wiki.archlinux.org/index.php/CPU_frequency_scaling

\section{Jeux de données}

Il y a, au total, 80 exemplaires de données; dix pour chacun des huit
jeux de tests. Chaque jeu de test correspont à une quantité de blocs
dans les exemplaires. Par contre, le vrai nombre de bloc est trois
fois plus grand, car il existe un bloc pour chacune des 3 façons de
placer ces dimensions (la hauteur peut être la première dimension, la
deuxième ou la troisième). Par exemple, le jeu de test 100 contient 10
exemplaires de 300 blocs, numérotés de 0 à 9. Les quantités de
dimensions spécifiées sont : 100, 500, 1000, 5000, 10000, 50000, 100000 et
500000. Pour l'analyse de l'algorithme, seule la moyenne de chaque
série de 10 exemplaires sera prise en note.

Il est important de noter que la grandeur des dimensions est
généralement plutôt limitée relativement à la taille des exemplaires.
En effet, on peut voir à la figure~\ref{fig:limitproof} que les
dimensions sont presque toujours inférieures à 200.  Comme les
dimensions sont entières, il y a généralement moins que 200 valeurs
possibles pour la largeur et pour la profondeur des blocs et donc
moins de $200^2=40000$ dimensions possibles pour les bases des blocs.
Cela veut dire que les exemplaire plus grand que cette valeur
témoigneront de beaucoup de redondance dans les blocs possibles à
utiliser.  On peut facilement diminuer la taille du problème en
éliminant cette redondance avec une complexité temporelle $O(n)$ une
passe de réduction qui note la hauteur maximale pour chaque taille de
base rencontrée.

\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[terminal=epslatex, terminaloptions=color dashed]
    set grid
    set xlabel "Dimension [-]"
    set ylabel "Nombre d'occurences [-]"
    set logscale x
    unset key
    
    plot "./results/limitproof.dat" u 2:1 w linesp
  \end{gnuplot}
  \caption{Histogramme des dimensions des blocs}\label{fig:limitproof}
\end{figure}

\section{Choix de conception}

\subsection{Algorithme voraceit}
Notre algoritme voraceit est très simple.  Il commence par trier les
blocs en ordre décroissant d'aire, et ensuite, pour chacun des blocs,
si le bloc peut être ajouté sur la tour, il est ajouté avec une
probabilité de $0.9$.  C'est donc un algorithme constructif, puisqu'on
commence avec une tour vide et qu'on ajoute des blocs sur le sommet
graduellement.  C'est aussi un algorithme vorace, puisqu'on ne retire
jamais de blocs, on améliore la solution en ajoutant des blocs et en
les sélectionnant selon la plus grande surface de base.  L'aspect
aléatoire vient du fait qu'on décide de façon aléatoire de prendre ou
non un bloc qu'on peut ajouter.  On espère ainsi éviter de choisir un
bloc qui empêche le placement d'autres blocs utiles.  Cependant, on
risque de refuser trop de blocs utiles.  Ainsi, il faut bien choisir
la probabilité de sélection pour avoir un entre-deux.  De façon
empirique et approximative, nous avons retenu $0.9$ comme facteur qui
maximise les résutats.

\subsection{Algorithme de progdynit}
Comme cet algoritme a une forte complexité temporelle, à la base, et
que certaines de nos implémentations initiales demandaient beaucoup de
temps, même pour une taille d'exemplaire modérée, nous avons choisit
d'utiliser l'optimisation discutée à la section précédente en
éliminant la redondance dans les blocs.  Par la suite, on ordonne les
blocs en ordre décroissant de surface.  Puis, en prenant soin de
garder les tours générées en ordre décroissant de hauteur, on parcourt
la liste pour chaque bloc jusqu'à ce qu'on trouve une tour sur
laquelle on peut placer le bloc.  On ajoute la nouvelle tour composée
de la tour trouvée et du bloc dans la liste ordonnée et on poursuit
jusqu'à épuisement des blocs.  La tour de hauteur maximale est alors
optimale.

Le choix de garder ordonnée la liste des tours permet de simplifier la
recherche puisqu'on peut s'arrêter au premier succès et savoir qu'on a
le maximum sans traverser toute la liste des tours.

\subsection{Algorithme tabouit}
On choisit de garder la tour dans une liste puisqu'elle est souvent
traversée, l'ensemble des blocs possibles à sélectionner dans un
\lstinline|set| puisqu'on ne fait qu'ajouter/retirer des éléments et
l'ensemble des éléments tabous dans un monceau minimisant le temps
auquel l'élément ne sera plus tabou puisqu'on ne retire toujours que
les élément de temps minimum et on ajoute des éléments avec des temps
variables.  On utilise un variable qu'on incrémente à chaque cycle
pour suivre le temps.  Le bloc libre à ajouter est choisit de façon
aléatoire, mais on ne l'utilise pas si sont insertion diminuerait la
taille de la tour.

\section{Résultats}

Les résultats des chronométrages de nos algorithmes sont présentés
dans la figure~\ref{lst:results}.  Ils montrent les fichiers obtenus
par nos bancs d'essais.  La première colonne donne la taille des
exemplaires utilisés pour le chronométrage, et la colonne suivante
correspond à la moyenne de temps d'exécution (en secondes) pour les
exemplaire de la taille donnée.  Il y a un fichier de résultats par
algorithme.

\begin{figure}[htb]
  \centering
  \begin{subfigure}[htbp]{0.4\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/vorace.dat}
    \caption{voraceit}
  \end{subfigure}
  ~
  \begin{subfigure}[htbp]{0.4\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/progdyn.dat}
    \caption{progdynit}
  \end{subfigure}

  \begin{subfigure}[htbp]{0.4\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/tabou.dat}
    \caption{tabouit}
  \end{subfigure}
  
  \caption{Fichiers de résultats}\label{lst:results}
\end{figure}

\section{Analyse}

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
    set xlabel "Nombre de blocs [-]"
    set ylabel "Temps d'exécution [s]"
    set logscale xy
    set key center top
    plot $1 u 1:2 w linesp t "Série [ 0- 9]"
    plot g(x) w l t "Régression"
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


%define(<ratiotest>, <
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[scale=0.8, terminal=epslatex, terminaloptions=color dashed]
    f(x) = $5
    set grid
    set xlabel "Taille des exemplaires [-]"
    set ylabel "Rapport du $y/f(x)$ pour $f(x) = $6$ [-]"
    set key center top
    set format y '%g'
    set xtics 1e5
    plot $1 u 1:($<>2/f($<>1)) w linesp t "Série [ 0- 9]"
  \end{gnuplot}
  \caption{Tests du rapport pour $3}\label{fig:$4}
\end{figure}
%>)

Les résultats obtenus à la section précédente sont analysés ici selon
les diverses méthodes vues en cours.

\subsection{Algorithme voraceit}

\subsubsection{Analyse asymptotique}
L'algorithme est dominé par le tri des blocs par aire de leur base.
En effet, le tri s'effectue en temps $O(n\:log(n))$ alors que le reste
de l'algorithme n'effectue qu'une passe sur la liste des blocs et le
traiement de chaque bloc s'effectue en temps constant. On a donc une
complexité temporelle $O(n\:log(n) + n) = O(n\:log(n))$.

\subsubsection{Test du rapport}
On se doute que la complexité se rapproche de $O(n\:log(n))$ et donc
on vérifie notre hypothèse avec le test du rapport.  Le constantes
particulières à notre implémentation ne nous intéressent pas vraiment
ici.  Le graphique du test du rapport se trouve à la figure~\ref{fig:ratiovorace}.

ratiotest("./results/vorace.dat", ,<voraceit>, <ratiovorace>,
<x*log(x)>, <x*log(x)>)

On se rend compte que la courbe semble converger à une valeur plus
grande que~$0$, et nous avons par conséquent une hypothèse sensée.

\subsection{Algorithme de progdynit}
\subsubsection{Analyse asymptotique}
La complexité de notre algorithme progdynit est difficile à évaluer à
cause de notre optimisation qui élimine la redondance.  En effet, la
redondance éliminée dépend grandement des données prises en entrée.
Sans cette optimisation, l'algorithme consiste à trier les blocs en
temps $O(n\:log(n))$ pour ensuite chercher une tour maximale pour
chaque bloc et ajouter une nouvelle tour dans la liste triée ($O(n*(n+log(n))) = O(n^2)$).

Avec notre optimisation, on arrive à réduire le problème à une taille
maximale donnée pour un ensemble de données dont les valeurs des
dimensions sont bornées.  Ainsi, le temps de l'algorithme devient
constant et c'est le temps de réduction qui domine.  La réduction se
fait en $O(n)$ comme décrit plus tôt.

\subsubsection{Test de puissance}
On choisit le test de puissance d'abord pour évaluer l'effet de
l'optimisation qui élimine la redondance des blocs.

powertest("./results/progdyn.dat", "./results/progdyn_fit.csv", <progdynit>, powprogdyn)

On a donc une complexité qui semble vraiement sublinéaire.  Il semble
que cela soit du à la distribution de nos valeurs.

\subsubsection{Test du rapport}
Ayant un meilleure idée du comportement asymptotique de l'algorithme
de progdynit, on essaye le test du rapport avec la fonction $f =
\sqrt{n}$. En effet, on applique l'exposant $1\over2$ suggéré par le
test de puissance.

ratiotest("./results/progdyn.dat", ,<progdynit>, <ratioprogdyn>, <x**0.5>, <sqrt(x)>)

Comme le montre la figure \ref{fig:ratioprogdyn}, le ratio pour
progdynit paraît éventuellement converger à une valeur supérieure à
$0$.  Cette fonction paraît alors être une bonne estimation.


\subsection{Tabouit}

\subsubsection{Analyse asymptotique}
L'analyse asymbtotique de l'algorithme tabouit est compliquée par la
boucle \lstinline|while| dont on ne connais pas le nombre
d'itérations.  Comme chaque bloc procure potentiellement un avantage à
la tour, on estime une complexité linéaire.  C'est à dire que la
boucle va se poursuivre tant qu'une certaine proportion des blocs
n'ont pas été tentés.

\subsubsection{Test du rapport}
Le graphe à la figure \ref{fig:ratiotabou} montre la convergence du
rapport pour le tabouit.  L'estimation de $O(n)$ est donc
sensée.

ratiotest("./results/tabou.dat", ,<tabouit>, <ratiotabou>, <x>, <x>)


\section{Discussion}

L'algorithme voraceit et progdynit s'exécutent rapidement même pour de
très grandes tailles.  L'algorithme tabouit est plus lent que les
autres sans doute à cause des facteurs constants parce que sa
complexité est comparable à celle de l'algorithme voraceit.

Pour l'algorithme voraceit, la consommation de ressource est assez
minime; il n'y a qu'une liste de blocs et la tour
résultat. L'implémentation est très facile. En effet, il ne s'agit que
d'une boucle et deux conditions, ce qui nous donne seulement 8 lignes
de code. Par contre, la qualité de la solution n'est pas optimale. On
obtient quand même presque toujours des tailles plus grandes que la
moitié de la taille optimale et souvent des résultats près de
l'optimalité.

Pour la progdynit, le temps de calcul est très rapide pour le données
utilisées et la consommation de ressources est plus grande (on
conserve une tour pour chaque bloc, mais on pourrait garder un
pointeur vers le bloc précédent). Cependant, la solution obtenue est
la solution optimale. L'implémentation est un peu plus difficile, car
il faut s'assurer que toutes les possibilités sont vérifiées sans
faire de calculs superflus.

L'algorithme tabouit est le moins bon autant en temps qu'en qualité
des solutions.  On a en effet constaté informellement que les
solutions semble moins bonnes que celles de l'algorithme voraceit.
Les chronométrages sont de loins les pires.  Puisque cet algorithme
est aussi plutôt difficile à implémenter, on décide qu'il est
préférable de l'éviter.  On préfère au lieu un des deux autres,
dépendemment des situations.

Le meilleur algorithme à utiliser dépend de ce que l'usager
désire. Pour obtenir la meilleure solution, il faut utiliser la
progdynit. Avec les données utilisées, cet algorithme est aussi plus
rapide pour de grands exemplaires. Cependant, on soupçonne que cela ne
serait pas le cas si la distribution des tailles de blocs variait
autant que le nombre de blocs.  Alors il pourrait être avantageux d'utiliser l'algorithme voraceit si on a pas besoin de la solution optimale.

Par ailleurs, l'algorithme voraceit permet d'avoir une solution qui se
raffine progressivement quand on prend le maximum de plusieurs
exécutions.  Cela pourrait être intéressant dans certaines situations.

\section{Conclusion}

En conclusion, nous avons eu l'occasion de pratiquer l'application de
patrons de conception algorithmique. Nous avons aussi pu analyser nos
algorithmes pour finir par refuser l'algorithme tabouit et
généralement préférer le progdynit sauf dans certains cas précis comme
si les données suivent une autre sorte de distribution ou bien si on
veut des résultats raffinées progressivement. Dans ce cas c'est le
voraceit qu'on pourrait préférer.

\clearpage
%\bibliographystyle{plainnat} %% or perhaps IEEEtranN
%\bibliography{rapport}

\end{document}
