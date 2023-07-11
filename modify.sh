#!/bin/bash
# This is our first script.
# echo 'Performing modify script'

ShowHelp()
{
	
    echo " [-r] [-l|-u] <dir/file names...>"
    echo " [-r] <sed pattern> <dir/file names...>"
    echo " [-h]"
    echo
    echo "-l: lowerizing directory and file names"
    echo "-u: tuppercasing directory and file names"
    echo "-r: recursive mode"
    echo "-h: show this help message"
    echo
    exit 0
}

NoRecursionLowercase()
{
  for file in "$@"; do
    if [ -f "$file" ]; then
      filename=$(basename -- "$file")
      dir=$(dirname "$file")    # name of a directory where is this file  
      extension="${filename##*.}"
      if [ "$filename" = "$ScriptName" ]; then
        echo error: cannot modify modify.sh
      else
        filename="${filename%.*}"
        newfilename=$(echo "$filename" | tr '[:upper:]' '[:lower:]')
        newFullName="${dir}/${newfilename}.${extension}"

        if [ -e "$newFullName" ]; then
          echo Errror: file $newFullName already exists
        else  
          mv -i "$file" "$newFullName"
        fi
      fi
    fi
  done
}

NoRecursionUppercase()
{

  for file in "$@"; do
    if [ -f "$file" ]; then
      
        filename=$(basename "$file")
        dir=$(dirname "$file")    # name of a directory where is this file  
        extension="${filename##*.}"
        if [ "$filename" == "$ScriptName" ]; then
          echo error: cannot modify modify.sh
        else
          if [ "$extension" != "$filename" ];then
            filename="${filename%.*}"
            newfilename=$(echo "$filename" | tr '[:lower:]' '[:upper:]')
            newFullName="${dir}/${newfilename}.${extension}"
          else
            newfilename=$(echo "$filename" | tr '[:lower:]' '[:upper:]')
            newFullName="${dir}/${newfilename}"
          fi
          if [ -e "$newFullName" ]; then
            echo Errror: file $newFullName already exists
          else  
            mv -i "$file" "$newFullName"
          fi
        fi
      
    fi

  done
}

NoRecursionSed(){
  for file in "$@"; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      dir=$(dirname "$file")    # name of a directory where is this file  
      extension="${filename##*.}"
      if [ "$filename" == "$ScriptName" ]; then
        echo error: cannot modify modify.sh
      else
        if [ "$extension" != "$filename" ];then
          filename="${filename%.*}"
          newfilename=$(echo "$filename" | sed -r "${sed_pattern}")
          newFullName="${dir}/${newfilename}.${extension}"
        else
          newfilename=$(echo "$filename" | sed -r "${sed_pattern}")
          newFullName="${dir}/${newfilename}.${extension}"
        fi
        if [ -e "$newFullName" ]; then
          echo Errror: file $newFullName already exists
        else  
          mv -i "$file" "$newFullName"
        fi
      fi
      # echo $(basename "$file")
    fi

  done
}

arguments=(); 
parameters=( false false );
recursion="false";
lowercase="false";
uppercase="false";
ScriptName=$(basename $0);

#get paramiters
while getopts "hrlu" options; do
  case "${options}" in
    \?)
      echo "Invalid parameter: -$OPTARG. Use -r -l -u or own pattern" >&2
      exit
      ;;
    h)
      ShowHelp;
      exit
      ;;
    r)
      recursion=true; 
      ;;
    l)
      lowercase=true;
      ;;
    u)
      uppercase=true;
      ;;
  esac
done

all_arguments=($*)



if [ $# -eq 0 ]; then
  echo "Error: No arguments provided."
  exit 1
fi

path="";
sed_pattern=""
for ((i=0; i< ${#all_arguments[*]}; i++)); do
  if [ ${all_arguments[i]} != '-r' ] && [ ${all_arguments[i]} != '-l' ] && [ ${all_arguments[i]} != '-u' ]; then
    if  [ -f ${all_arguments[i]} ] || [ -d ${all_arguments[i]} ]; then   #it i'th argument is a file or directory
      path=${all_arguments[i]}; # store path to the file or directory
    elif [[ -n ${all_arguments[i]} ]]; then
      sed_pattern="${all_arguments[i]}"
      
    fi
  fi  
done

if [ "$path" != "" ] && [ "$uppercase" == "false" ] && [ "$lowercase" == "false" ] && [ "$sed_pattern" == "" ] && [ "$recursion" == "false" ]; then
  echo "Error: cannot have a path as only parameter"
  exit 1;
fi

if [ "$path" == "" ]; then
  echo "Error: Path not specified"
  exit 1
fi

if $recursion && [ "$uppercase" == "false" ] && [ "$lowercase" == "false" ] && [ "$sed_pattern" == "" ]; then
  echo "Error: cannot have recursion as only parameter"
  exit 1
fi

# we have parameters needed:
# recursion 
# lowercase
# uppercase
# path
# sed_patters





if  $uppercase && $lowercase; then
  echo "ERROR: Cannot be lowercasing and uppercasing at the same time."
  echo "Exiting..."
  exit 1
fi

if  $recursion && $lowercase; then
 # echo Recursion lowercase

    find "$path" -type f -print0 | while IFS= read -r -d '' file; do 
    if [ -f "$file" ]; then
      NoRecursionLowercase "$file"
    fi
  done

fi

if  $recursion && $uppercase; then
 # echo Recursion uppercase

  find "$path" -type f -print0 | while IFS= read -r -d '' file; do 
    if [ -f "$file" ]; then
      NoRecursionUppercase "$file"
    fi
  done


fi



if  [ "$recursion" == "false" ] && $uppercase; then
  #echo Uppercase
  #NoRecursionUppercase $path/*;
    find "$path" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do 
    if [ -f "$file" ]; then
      NoRecursionUppercase "$file"
    fi
  done

fi

if  [ "$recursion" == "false" ] && $lowercase; then
  #echo Lowercase
  #NoRecursionLowercase $path/*;
      find "$path" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do 
    if [ -f "$file" ]; then
      NoRecursionLowercase "$file"
    fi
  done
fi

if  $recursion && [ "$sed_pattern" != "" ]; then

    find "$path" -type f -print0 | while IFS= read -r -d '' file; do 
      if [ -f "$file" ]; then
        NoRecursionSed "$file"
      fi
  done
fi

if  [ "$recursion" = "false" ] && [ "$sed_pattern" != "" ]; then
  #echo No Recursion Sed pattern
  find "$path" -maxdepth 1 -type f -print0 | while IFS= read -r -d '' file; do 
    if [ -f "$file" ]; then
      NoRecursionSed "$file"
    fi
  done
 # NoRecursionSed  $path/*;
fi





