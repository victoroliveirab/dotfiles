#!/bin/bash

LANGUAGES=`echo "typescript python nodejs lua elixir" | tr ' ' '\n'` 
CORE_UTILS=`echo "xargs tar find mv sed awk" | tr ' ' '\n'`

SELECTED=$(printf "$LANGUAGES\n$CORE_UTILS" | fzf)
read -p "Query: " QUERY

echo "$SELECTED"

IS_LANGUAGE=$(echo "$LANGUAGES" | grep $SELECTED)

if [[ -n "$IS_LANGUAGE" ]]; then
  QUERY=`echo "$QUERY" | tr ' ' '+'`
  curl cht.sh/$SELECTED/$QUERY | less -R
else
  curl cht.sh/$SELECTED~$QUERY | less -R
fi

