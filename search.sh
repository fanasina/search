#!/bin/bash
descrition="Pour chercher un mot dans un fichier d'un dossier (en recursive) ou  chercher un fichier ou dossier"
VERSION="0.0.0"
AUTHOR="Fanasina"

DIR=$PWD
num_file_to_open=-1
name=""
m=0
file=""
printed=0
res_file=""
result=""
verb=0
non_verb=0
l=""
e=""
i=""
g=""
E=""

doc(){
  echo "$descrition"
  echo "version: $VERSION"
  echo "auteur: $AUTHOR"
}

find_file(){
  if [ -z "$file" ] ; then
    res_file=$DIR
  else
    res_file=$(find $DIR -name "*$file*" 2>/dev/null)
  fi
  #echo "res file : $res_file"
}

find_name(){
  find_file
  if [ $m -eq 1 ] ; then
    if [ -z "$name" ] ; then
      echo "erreur mot vide après -m"
      exit 1
    else
      result=$(grep -rl$i$E $g "$name" "$res_file" 2>/dev/null)
    fi
  else
    result=$res_file
  fi
}

affiche_elem_num(){
 count=0
 if [ $num_file_to_open -eq -1 ] ; then
   num_file_to_open=0
 fi
 for namefile in $result;
 do
  if [ $num_file_to_open -eq $count ] ; then
   if [ -f "$namefile" ] ; then
    if [ -z "$e" ]; then 
      less "$namefile" ;
    else
      vim "$namefile" ;
    fi
    #cat "$namefile" ;
    break ;
   else
     echo "$namefile n'est pas un fichier ordinaire"
   fi
  fi
  count=$(($count + 1))
 done
    
}

usage(){
  echo "$descrition"
  echo "Usage: `basename $0` [OPTION] [ARG]"
  echo "[OPTION]:"
  echo "  -h : pour afficher l'aide"
  echo "  -i : pour ignorer la case"
  echo "  -l : pour afficher la liste des chemin simplement"
  echo "  -e : open file with vim (by default/without : less )"
  echo "  -g [option]: les options possible pour grep"
  echo "  -n : pour ne pas afficher le resultat mais seulement le nombre"
  echo "  -m [MOT]: pour specifier le mot à cherché dans les fichiers"
  echo "  -f [NOM]: pour specifier le nom de fichier ou dossier à cherché"
  echo "  -d [DIR]: pour specifier le nom du dossier où ou fait la recherche"
  echo "  -o [NUM]: pour afficher le fichier 'NUM'-ieme du résultat" 
  echo "EXEMPLE"
  echo "`basename $0` -a 2 -d "'$HOME'" -m hello"
  echo " pour chercher les fichiers contenant 'hello' et ouvre le 2ieme fichier dans la liste"
  
  exit 0
}

check_opt(){
  if [ $# -eq 0 ] ; then 
    usage
  fi
  while getopts ":hilenE:g:m:f:d:o:" OPT
  do
    case $OPT in
      h)  usage;;
      i)  i="i";;
      l)  l="l";;
      e)  e=1 ;;
      g)  g="-${OPTARG}";;
      n)  non_verb=1;;
      m)  m=1; name="$OPTARG";;
      E)  E="E"; name="$OPTARG";;
      f)  file="${OPTARG}";;
      d)  DIR="${OPTARG}";;
      o)  num_file_to_open="${OPTARG}";;
      *)  echo "$OPT unknown option" ; usage;;
      esac
  done
}
_main() {
  while [ -n "$1" ] 
  do
    local X="$1"
    [ -z "$1" ] || shift 1
    case "$X" in
      (-h)        usage        ;; 
      (-i)        i="i"   ;; 
      (-g)        g="$1" ;shift 1 ;; 
      (-n)        non_verb=1 ;; 
      (-m)        m=1; name="$1";shift 1 ;; 
      (-E)        E="E"; name="$1" ;shift 1 ;; 
      (-f)        file="$1" ;shift 1 ;; 
      (-d)        DIR="$1" ; shift 1 ;; 
      (-o)        num_file_to_open="$1" ;; 
      (*)         echo "Unknown command: $X" ;;
      esac
  done
}
_main "$@"


affiche_line_with_num(){
  #echo " result $result"
  count=0
  for fichier in $result; do
    echo "file == $count : $fichier "
    ((count += 1))
    if [ -z "$l" ]; then
    echo "========================================================="
    grep --color=auto -n$i$E $g "$name" "$fichier" 2>/dev/null
    echo "========================================================="
    fi
  done
  echo "name=$name"
}

default(){
  if [ $verb -eq 1 ] ; then
    doc
  fi

  find_name

  if [ $non_verb -eq 1 ] ; then
    echo  "nombre de resultat : $(echo "$result" | wc -l )"
  elif [ $num_file_to_open -gt -1 ] ; then
      affiche_elem_num
  else
      affiche_line_with_num
  fi
}


#check_opt $@

default

