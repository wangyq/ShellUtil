@echo off

REM ɾ���������ʱ�ļ�

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

::ͬ���õ�
DEL /s *.synctex.gz

::�Ƿ�ɾ��PDF?
:: DEL  *.pdf

ECHO ɾ�����. & PAUSE