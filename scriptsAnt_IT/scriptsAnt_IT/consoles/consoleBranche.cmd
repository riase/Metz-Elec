@echo off

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

call .\commun\setEnv.cmd

cls
set CHOICE=
set CHOICELIST=

title Creation branche de maintenance %VERSION_COURT%

:menu
if not "%CHOICELIST%"=="" (
		set CHOICE=%CHOICELIST:~0,3%
		set CHOICELIST=%CHOICELIST:~4,500%
) else (
	set CHOICE=
)

if '%CHOICE%'=='' goto menuderoulant 
if not '%CHOICE%'=='' goto menuchoix

:menuderoulant
echo.
echo     ��������������������������������������������������������������ͻ
echo     �         Branche de maintenance de la version %VERSION_COURT%         �
echo     ��������������������������������������������������������������͹
echo     �                                                              �
echo     � 100. creer branche sur la projet complet (101 � 105)         �
echo     �                                                              �
echo     � 101. creer branche sur l'archi                               �
echo     � 102. creer branche sur l'EDK                                 �
echo     � 103. creer branche sur le developpement                      �
echo     � 104. creer branche sur le specifique clients                 �
echo     � 105. creer branche sur la doc des batchs                     �
echo     � ------------------------------------------------------------ �
echo     � 201. creer zip du developpement                              �
echo     � 202. creer zip specifique clients                            �
echo     � 203. creer zip des docs des batchs                           �
echo     � ------------------------------------------------------------ �
echo     � Multi-selection (ex : 103+201)                               �
echo     �                                                              �
echo     � 0. Quitter                                                   �
echo     ��������������������������������������������������������������ͼ
echo.
set CHOICE=
set /p CHOICE=Selectionnez l'etape souhaitee : 
set CHOICELIST=
set TRAITE=false
set SELECTED_TIME=

:menuchoix
rem ******************************************** D�but
set EXIT=1
if '%CHOICE%'=='' goto menu
rem ******************************************** logs de la console
echo %DATE%-%TIME% - Action %CHOICE% >> %VERSION_HOME%\actionsAssemblage%VERSION_COURT%.log
rem ******************************************** Multi-s�lection
if '%CHOICE:~3,1%'=='+' (
	set CHOICELIST=%CHOICE%
	goto menu
)
rem ******************************************** Programmation
if '%CHOICE:~0,3%'=='prg' goto time
rem ****************************************** actions
if '%CHOICE%'=='101' goto brancheArchi
if '%CHOICE%'=='102' goto brancheEDK
if '%CHOICE%'=='103' goto brancheDev
if '%CHOICE%'=='104' goto brancheClients
if '%CHOICE%'=='105' goto brancheDoc
if '%CHOICE%'=='100' set CHOICELIST=101+102+103+104+105
if '%CHOICE%'=='201' goto creerZipDev
if '%CHOICE%'=='202' goto creerZipClients
if '%CHOICE%'=='203' goto creerZipDoc


rem ******************************************** Navigation
if not '%CHOICELIST%'=='' goto menu
if '%CHOICE%'=='0' goto end
if '%EXIT%'=='1' goto exit
goto menu
rem ******************************************** Fin

:exit
rem l'�tape s�lectionn�e ne correspond pas � une �tape valide de la console
echo.
echo ���������������������������Ŀ
echo � Etape non valide !        �
echo �����������������������������
echo   ==^> Merci de choisir une etape du menu !!
echo.
goto menu

:time
if '%SELECTED_TIME%'=='' (
	set /p SELECTED_TIME=Saisir l'heure de lancement ^(hh24^:mi^) : 
)
if '%SELECTED_TIME%'=='' (
	if '%TRAITE%'=='false' (
		echo      !!! Attention : vous devez saisir une heure !!!
		goto time
	)
)
if not '%SELECTED_TIME:~2,1%' == ':' (
	echo      !!! Attention : le format de la date doit etre ^(hh24^:mi^) !!!
	set SELECTED_TIME=
	goto time
)
if '%SELECTED_TIME:~0,2%%SELECTED_TIME:~3,2%' LSS '%TIME:~0,2%%TIME:~3,2%' (
	echo      !!! Attention : l'heure choisie doit etre superieure a l'heure actuelle !!!
	set SELECTED_TIME=
	goto time
)
if not '%TIME:~0,5%'=='%SELECTED_TIME%' (
	sleep 15
	goto time
)
if '%TIME:~0,5%'=='%SELECTED_TIME%' (
	set TRAITE=true
	set CHOICELIST=%CHOICE:~4,500%
	goto menu
)


rem ******************************************** T�ches cr�er Branches

:brancheArchi
echo �������������������Ŀ
echo � branche de l'Archi �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_hermesArchi.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:brancheEDK
echo �������������������Ŀ
echo � branche de l'EDK �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_efluidEDK.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:brancheDev
echo �������������������Ŀ
echo � branche du Dev    �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_Dev.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..\..
goto menu

:brancheClients
echo �������������������������Ŀ
echo � branche du spec. client �
echo ���������������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_clients.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:brancheDoc
echo �������������������Ŀ
echo � branche de la doc �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creerBranche.xml -Dproperty.file=branche_Doc.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

rem ******************************************** T�ches cr�er Zip

:creerZipDev
echo �������������������Ŀ
echo � Creer zip Dev.    �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creationZipEnv.xml -Dproperty.file=zip_Dev.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:creerZipClients
echo �������������������Ŀ
echo � Creer zip Clients �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creationZipEnv.xml -Dproperty.file=zip_Clients.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:creerZipDoc
echo �������������������Ŀ
echo � Creer zip Doc     �
echo ���������������������
echo.
cd parametrage
call ..\commun\setExecDir.cmd
call ant -f %XML_HOME%\branches\creationZipEnv.xml -Dproperty.file=zip_Doc.properties -Dproperty.file.dir=%VERSION_COURT% -DexecDir=%EXEC_DIR% 
cd ..
goto menu

:end
