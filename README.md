# search
small script to search for files containing words in a directory  (combine grep and find !)

```
./search.sh -h
Pour chercher un mot dans un fichier d'un dossier (en recursive) ou  chercher un fichier ou dossier
Usage: search.sh [OPTION] [ARG]
[OPTION]:
  -h : pour afficher l'aide
  -i : pour ignorer la case
  -l : pour afficher la liste des chemin simplement
  -g [option]: les options possible pour grep
  -n : pour ne pas afficher le resultat mais seulement le nombre
  -m [MOT]: pour specifier le mot à cherché dans les fichiers
  -f [NOM]: pour specifier le nom de fichier ou dossier à cherché
  -d [DIR]: pour specifier le nom du dossier où ou fait la recherche
  -o [NUM]: pour afficher le fichier 'NUM'-ieme du résultat, avec less
  -e [NUM]: comme -o, mais ouvre avec vim
EXEMPLE
search.sh -o 2 -d $HOME -m hello
 pour chercher les fichiers contenant 'hello' et ouvre le 2ieme fichier dans la liste
```
