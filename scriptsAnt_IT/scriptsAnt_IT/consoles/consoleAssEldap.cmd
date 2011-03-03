@echo off

if not '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%+%PATCHS_ASS%
if '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

rem JDK 1.5
call .\commun\setEnv.cmd

cls
set CHOICE=
set CHOICELIST=

title Assemblage v.%TAG_ASS%

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
echo     � Assemblage de la version %TAG_ASS_SANS_PATCH%                �
echo     ��������������������������������������������������������������͹
echo     �                                                              �
echo     � 101. tagger le code                                          �
echo     � 102. tagger bdd                                              �
echo     � 103. tagger un patch ou un regroupement de patchs            �
echo     � ------------------------------------------------------------ �
echo     � 201. MAJ Evenements Corriges suivefluid                      �
echo     � ------------------------------------------------------------ �
echo     � 301. Differences entre versions n et n-1                     �
echo     � ------------------------------------------------------------ �
echo     � 401. application eldap                                       �
echo     � 402. batchs eldap                                            �
echo     � 403. EJB Statefull					                                  �
echo     � ------------------------------------------------------------ �
echo     � 501. structure eldap                                         �
echo     � ------------------------------------------------------------ �
echo     � 010. Commit                                                  �
echo     � ------------------------------------------------------------ �
echo     � 020. Programmation complete (sans commit)                    �
echo     � 021. Programmation sans BDD (sans commit)                    �
echo     � 022. Programmation sans MAJ Evenements (sans commit)         �
echo     � 023. Programmation tagger bdd (prg+102)                      �
echo     � ------------------------------------------------------------ �
echo     � Programmation (ex : prg+401)                                 �
echo     � Multi-selection (ex : 401+402+403)                           �
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
if '%CHOICE%'=='101' goto taggercode
if '%CHOICE%'=='102' goto taggerbdd
if '%CHOICE%'=='103' goto taggerpatch
if '%CHOICE%'=='201' goto statutevenementcorrige
if '%CHOICE%'=='301' goto diff
if '%CHOICE%'=='401' goto applicationeldapJ2EE
if '%CHOICE%'=='402' goto batchseldap
if '%CHOICE%'=='403' goto ejbstatefull
if '%CHOICE%'=='501' goto structureeldap
if '%CHOICE%'=='010' goto commit
  

rem etape statutC2DEC et JE desactivees sur toutes les programmations
if '%CHOICE%'=='020' (
	set CHOICE=prg+101+102+201+301+401+402+403+501
	goto time
)
if '%CHOICE%'=='021' (
	set CHOICE=prg+101+201+301+401+402+403+501
	goto time
)
if '%CHOICE%'=='022' (
	set CHOICE=prg+101+102+301+401+402+403+501
	goto time
)
if '%CHOICE%'=='023' (
	set CHOICE=prg+102
	goto time
)

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


rem ******************************************** T�ches TAGGER

:taggercode
echo �������������������Ŀ
echo � tag du code java  �
echo ���������������������
echo. 
cd tagger\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\tagger\tagger.xml -Dcvs.tag=%TAG_ASS_SANS_PATCH% -Dproperty.file=tagger.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:taggerbdd
echo ���������������������������Ŀ
echo � tag des scripts BDD       �
echo �����������������������������
echo. 
cd tagger\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\tagger\taggerListeFichiers.xml -Dcvs.listeFichier=listeFichiers_BDD.txt -Dproperty.file=taggerBDD.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\tagger
cd ..\..
goto menu


:taggerpatch
echo �������������������Ŀ
echo � tag de patch      �
echo ���������������������
echo. 
cd tagger\cmd
call ..\..\commun\setExecDir.cmd
echo.
set PATCH=
set /p PATCH=Entrez le N� du patch ou regroupement de patch (valeurs possibles = '06', 'A_33', 'M', etc...) : 
if '%PATCH%'=='' (
	echo. =^> aucun patch saisi, rien ne sera fait !
) else (
  call ant -f %XML_HOME%\tagger\taggerListeFichiers.xml -Dcvs.listeFichier=listeFichiers_%PATCH%.txt -Dproperty.file=taggerListeFichiersVersion.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\tagger
)
cd ..\..
goto menu



rem ******************************************** T�ches suivefluid

:statutevenementcorrige
echo ����������������������������Ŀ
echo � Statut Evenements Corriges �
echo ������������������������������
echo. 
cd c2\cmd
call %XML_HOME%\commun\setCheminAbsolu.cmd ".\scripts"
rem java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% CORRIGE %DATE_HEURE_SVF% INTEGRE EFL LDAP %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblage%VERSION_SVF%.log
cd ..\..
goto menu


rem ******************************************** T�ches DIFF

:diff
echo �������������������������������������������Ŀ
echo � Differences entre versions n et n-1       �
echo ���������������������������������������������
echo. 
cd diff\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_eldap.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu



rem ******************************************** T�ches DCT

:dct
echo �������������������Ŀ
echo � DCT               �
echo ���������������������
echo. 
cd dct\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\documentation\assemblageDCT.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=dct.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu



rem ******************************************** T�ches DOCEXPLOITATIONBATCHS

:docExploitationBatchs
echo ������������������������Ŀ
echo � DocExploitationBatchs  �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageDexBatch.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=docExploitationBatchs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\j2ee
cd ..\..
goto menu



rem ******************************************** T�ches J2EE

:applicationeldapJ2EE
echo ��������������������Ŀ
echo � application eldap   �
echo ����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Djava.home=%JAVA_HOME% -Dcontext=hermesLdapJ2EE1.5 -Dproperty.file=appliLdap1.5.properties -Dapplication=eldap -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchseldap
echo ��������������������Ŀ
echo � Batchs eldap       �
echo ����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2-1.5.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdap1.5 -Dproperty.file=hermesLdapBatch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:ejbstatefull
echo �������������������Ŀ
echo � EJB Statefull       �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=EJBStatefull -Dapplication.name=hermes1.5 -Dproperty.file=EJBStatefull.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

rem ******************************************** T�ches ORACLE

:structureeldap
echo �����������������������Ŀ
echo � Structure eldap       �
echo �������������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerStructureeLdap.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu

rem ******************************************** T�ches COMMIT

:commit
echo �������������������������������������������Ŀ
echo � Commit %LOT_ASS%\%TAG_ASS%                �
echo ���������������������������������������������
echo. 
cd ..\..
call CommitCVS_assemblage.cmd %LOT_ASS%\%TAG_ASS% 1
cd %LOT_ASS%\%TAG_ASS%
goto menu

:help
echo �������������������������������������������Ŀ
echo � Help                                      �
echo ���������������������������������������������
echo. 


:end
