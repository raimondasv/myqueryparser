package main

import (
	"fmt"
	"reflect"
	"strings"

	"myqueryparser/myparser"

	"github.com/antlr/antlr4/runtime/Go/antlr"
)

type MyParserListener struct {
	*myparser.BaseMySqlParserListener
}

func (l *MyParserListener) EnterEveryRule(ctx antlr.ParserRuleContext) {
	t := reflect.TypeOf(ctx)
	fmt.Println(t, "\t", ctx.GetText())
}

func main() {
	sql := "select * from users"
	is := antlr.NewInputStream(strings.ToUpper(sql))

	lexer := myparser.NewMySqlLexer(is)

	stream := antlr.NewCommonTokenStream(lexer, antlr.TokenDefaultChannel)

	p := myparser.NewMySqlParser(stream)
	var listener MyParserListener
	antlr.ParseTreeWalkerDefault.Walk(&listener, p.Root())
}
