# INF4705 TP2

Pour construire le rapport, il suffit d'appeller `make`. Le script
`tp.sh` permet de chronométrer les algorithmes étudiés pour différents
jeux de données.

===

## Comment ça marche?

Les algorithmes sont implémentés dans le répertoire algorithms, avec
les fonction de chronométrage.

Les scripts pour amasser les données se trouvent dans le répertoire
script.  Pour lancer l'expérience, il faut rouler

 $ ./script/run_data.sh ./datas/

Les résultats apparaissent alors dans le répertoire results.

## Le rapport

Le rapport est écrit en Latex avec des macros m4. Il suffit de faire
make pour le construire.  Il inclue des graphiques et des régressions
avec gnuplottex.  Le données créées sont accédées par le package latex
datatool.