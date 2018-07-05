@echo off

REM 删除编译的临时文件

DEL /s *.aux
DEL /s *.bbl
DEL /s *.bak
DEL /s *.dvi
DEL /s *.blg
DEL /s *.log
DEL /s *.thm
DEL /s *.toc
DEL /s *.out
DEL /s *.lof
DEL /s *.lol
DEL /s *.lot

::同步用的
DEL /s *.synctex.gz

::是否删除PDF?
:: DEL  *.pdf

ECHO 删除完成. & PAUSE