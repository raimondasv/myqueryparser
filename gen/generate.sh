#!/bin/sh

if [ ! -e antlr-4.9.3-complete.jar ]
then
  wget https://www.antlr.org/download/antlr-4.9.3-complete.jar
fi

if [ ! -e MySqlLexer.g4 ]
then
  wget https://raw.githubusercontent.com/antlr/grammars-v4/master/sql/mysql/Positive-Technologies/MySqlLexer.g4
fi

if [ ! -e MySqlParser.g4 ]
then
  wget https://raw.githubusercontent.com/antlr/grammars-v4/master/sql/mysql/Positive-Technologies/MySqlParser.g4
fi

if [ ! -d ../myparser ]
then
  mkdir ../myparser
fi

rm -rf ../myparser*

java -jar antlr-4.9.3-complete.jar -Dlanguage=Go -o ../myparser -package myparser -lib . MySqlLexer.g4 MySqlParser.g4

rm ../myparser/*.tokens
rm ../myparser/*.interp
