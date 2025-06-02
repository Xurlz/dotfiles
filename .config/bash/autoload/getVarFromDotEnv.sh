getVarFromDotEnv() { cat $2 | grep $1 | sed -E "s/$1=(.*)/\1/g" ; }

export -f getVarFromDotEnv

