@echo off

if not '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%+%PATCHS_ASS%
if '%PATCHS_ASS%'=='' set TAG_ASS=%TAG_ASS_SANS_PATCH%

set SCRIPTS=scripts
call %SCRIPTS%\commun\setCheminAbsolu.cmd ".\scripts"
set VERSION_HOME=%CHEMIN_ABSOLU%
set XML_HOME=%CHEMIN_ABSOLU%%SCRIPTS%

rem JDK 1.5 par d�faut
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
echo     � 201. MAJ Evenements suivefluid                               �
echo     � ------------------------------------------------------------ �
echo     � 210. Differences entre versions n et n-1                     �
echo     � ------------------------------------------------------------ �
echo     � 301. DCT                                                     �
echo     � ------------------------------------------------------------ �
echo     � 311. DocExploitationBatchs                                   �
echo     � ------------------------------------------------------------ �
echo     � Assemblage des applications en 1.4                           �
echo     � ------------------------------------------------------------ �
echo     � 400. Assemblage J2EE complet (401 a 412)                     �
echo     � 401. application efluid J2EE                                 �
echo     � 402. batchs efluid                                           �
echo     � 403. batchs ANT efluid                                       �
echo     � 404. injecteurs                                              �
echo     � 405. extracteurs                                             �
echo     � 406. archiveur                                               �
echo     �                                                              �
echo     � 407. application eFluidNet                                   �
echo     � 408. batchs efluidNet                                        �
echo     � 409. application eFluidPub                                   �
echo     �                                                              �
echo     � 410. application eldap                                       �
echo     � 411. batchs eldap                                            �
echo     �                                                              �
echo     � 412. application AEL                                         �
echo     �                                                              �
echo     � 413. application efluidProxy (en test)                       �
echo     � ------------------------------------------------------------ �
echo     � Assemblage des applications en 1.5                           �
echo     � ------------------------------------------------------------ �
echo     � 430. Assemblage J2EE 1.5 complet (431 a 442)                 �
echo     � 431. Assemblage efluid 1.5                                   �
echo     � 432. batchs efluid 1.5                                       �
echo     � 433. batchs ANT efluid 1.5                                   �
echo     � 434. injecteurs 1.5                                          �
echo     � 435. extracteurs  1.5                                        �
echo     � 436. archiveur 1.5                                           �
echo     �                                                              �
echo     � 437. application eFluidNet 1.5                               �
echo     � 438. batchs efluidNet 1.5                                    �
echo     � 439. application eFluidPub 1.5                               �
echo     �                                                              �
echo     � 440. application eldap 1.5                                   �
echo     � 441. batchs eldap 1.5                                        �
echo     �                                                              �
echo     � 442. application AEL 1.5                                     �
echo     � ------------------------------------------------------------ �
echo     � 500. Assemblage oracle complet (502 a 530)                   �
echo     � 501. Jeux d'essai (obsolete)                                 �
echo     � 502. structure de la base                                    �
echo     �                                                              �
echo     � 510. structure efluidNet                                     �
echo     �                                                              �
echo     � 520. structure eldap                                         �
echo     �                                                              �
echo     � 530. structure AEL                                           �
echo     � ------------------------------------------------------------ �
echo     � 601. Assemblage StreamServe                                  �
echo     � 602. Assemblage StreamServe Clients                          �
echo     � ------------------------------------------------------------ �
echo     � 010. Commit                                                  �
echo     � ------------------------------------------------------------ �
echo     � 020. Programmation complete (sans commit)                    �
echo     � 021. Programmation sans BDD (sans commit)                    �
echo     � 022. Programmation sans MAJ Evenements (sans commit)         �
echo     � 023. Programmation tagger bdd (prg+102)                      �
echo     � 024. Programmation patch code simple sans bdd                �
echo     � ------------------------------------------------------------ �
echo     � 098. choix compilation avec JDK 1.5 (setEnv par defaut)      �
echo     � 099. choix compilation avec JDK 1.4 (setEnv14)               �
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
if '%CHOICE%'=='201' goto statutevenement
if '%CHOICE%'=='210' goto diff
if '%CHOICE%'=='301' goto dct
if '%CHOICE%'=='311' goto docExploitationsBatchs
if '%CHOICE%'=='400' set CHOICELIST=401+402+403+404+405+406+407+408+409+410+411+412
if '%CHOICE%'=='401' goto applicationJ2EE
if '%CHOICE%'=='402' goto batchs
if '%CHOICE%'=='403' goto batchsANT
if '%CHOICE%'=='404' goto injecteurs
if '%CHOICE%'=='405' goto extracteurs
if '%CHOICE%'=='406' goto archiveur
if '%CHOICE%'=='407' goto efluidNet
if '%CHOICE%'=='408' goto batchsefluidNet
if '%CHOICE%'=='409' goto efluidPub
if '%CHOICE%'=='410' goto applicationeldapJ2EE
if '%CHOICE%'=='411' goto batchseldap
if '%CHOICE%'=='412' goto AEL
if '%CHOICE%'=='413' goto efluidProxy
if '%CHOICE%'=='430' set CHOICELIST=431+432+433+434+435+436+437+438+439+440+441+442
if '%CHOICE%'=='431' goto applicationJ2EE15
if '%CHOICE%'=='432' goto batchs15
if '%CHOICE%'=='433' goto batchsANT15
if '%CHOICE%'=='434' goto injecteurs15
if '%CHOICE%'=='435' goto extracteurs15
if '%CHOICE%'=='436' goto archiveur15
if '%CHOICE%'=='437' goto efluidNet15
if '%CHOICE%'=='438' goto batchsefluidNet15
if '%CHOICE%'=='439' goto efluidPub15
if '%CHOICE%'=='440' goto applicationeldapJ2EE15
if '%CHOICE%'=='441' goto batchseldap15
if '%CHOICE%'=='442' goto AEL15
if '%CHOICE%'=='500' set CHOICELIST=502+503+510+520+530
if '%CHOICE%'=='501' goto je
if '%CHOICE%'=='502' goto structureefluid
if '%CHOICE%'=='510' goto structureefluidNet
if '%CHOICE%'=='520' goto structureeldap
if '%CHOICE%'=='530' goto structureAEL
if '%CHOICE%'=='601' goto streamserve
if '%CHOICE%'=='602' goto streamserveClient
if '%CHOICE%'=='010' goto commit
if '%CHOICE%'=='098' goto jdk15
if '%CHOICE%'=='099' goto jdk14
  

rem etape statutC2DEC et JE desactivees sur toutes les programmations
if '%CHOICE%'=='020' (
rem set CHOICE=prg+101+102+201+210+301+401+402+403+404+405+406+407+408+409+410+411+412+431+432+433+434+435+436+437+438+439+440+441+442+502+510+520+530+601+602
	set CHOICE=prg+101+102+201+210+301+311+431+432+433+434+435+436+437+438+439+440+441+442+099+401+402+403+404+405+406+407+408+409+410+411+412+502+510+520+530+601+602
	goto time
)
if '%CHOICE%'=='021' (
	set CHOICE=prg+101+201+210+301+311+099+401+402+403+404+405+406+407+408+409+410+411+412+098+431+432+433+434+435+436+437+438+439+440+441+442+502+510+520+530+601+602
	goto time
)
if '%CHOICE%'=='022' (
	set CHOICE=prg+101+102+210+301+311+099+401+402+403+404+405+406+407+408+409+410+411+412+098+431+432+433+434+435+436+437+438+439+440+441+442+502+510+520+530+601+602
	goto time
)
if '%CHOICE%'=='023' (
	set CHOICE=prg+102
	goto time
)
if '%CHOICE%'=='024' (
	set CHOICE=prg+103+201+210+099+401+402+403+404+405+406+407+408+409+410+411+412+098+431+432+433+434+435+436+437+438+439+440+441+442+601+602
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

:statutevenement
echo �������������������Ŀ
echo � Statut Evenements �
echo ���������������������
echo. 
cd c2\cmd
call %XML_HOME%\commun\setCheminAbsolu.cmd ".\scripts"
java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% CORRIGE %DATE_HEURE_SVF% INTEGRE EFL efluid %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblage%VERSION_SVF%.log
java -jar %XML_HOME%/evenement/assemblerVersion.jar http://suivefluid.uem.lan/suivefluid_UEM/services2/ServiceLivraison %LOT_SVF_PREV% LIVRE_PARAM %DATE_HEURE_SVF% INTEGRE EFL efluid %VERSION_SVF% %TRIGRAMME% %CHEMIN_ABSOLU%ServiceAssemblageParametrage%VERSION_SVF%.log
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
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_ael.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_efluidnet.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_efluidpub.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_eldap.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_hermes.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_streamserve.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
call ant -f %XML_HOME%\diff\tagDiff.xml -Dcvs.tag1=%TAG_ASS_PRECEDENT% -Dcvs.tag2=%TAG_ASS% -Dproperty.file=diff_clients.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% 
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

:docExploitationsBatchs
echo ������������������������Ŀ
echo � DocExploitationBatchs  �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageDEXBTCH.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=docExploitationBatchs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\j2ee
cd ..\..
goto menu



rem ******************************************** T�ches J2EE

:applicationJ2EE
echo �������������������Ŀ
echo � applicationJ2EE    �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliJ2EE.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesJ2EE -Dproperty.file=appliJ2EE.properties -Dapplication=efluid -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:applicationJ2EE15
echo �������������������Ŀ
echo � applicationJ2EE 1.5    �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Djava.home=%JAVA_HOME% -Dcontext=hermesJ2EE1.5 -Dproperty.file=appliJ2EE1.5.properties -Dapplication=efluid -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchs
echo ����������������������Ŀ
echo � Batchs (CMD)  �
echo ������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=batch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsANT
echo ����������������������Ŀ
echo � Batchs (ANT)  �
echo ������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatchANT.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=batchANT.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:batchs15
echo ����������������������Ŀ
echo � Batchs (CMD) 1.5 �
echo ������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=batch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:batchsANT15
echo ����������������������Ŀ
echo � Batchs (ANT) 1.5 �
echo ������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatchANT15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=batchANT1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu



:efluidNet
echo �������������������Ŀ
echo � efluidNet         �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliWeb.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidNet -Dproperty.file=eFluidNet.properties -Dapplication=efluid.net -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidNet15
echo �������������������Ŀ
echo � efluidNet  1.5       �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidNet1.5 -Dproperty.file=eFluidNet1.5.properties -Dapplication=efluid.net -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsefluidNet
echo ��������������������Ŀ
echo � Batchs efluidNet   �
echo ����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidNet -Dproperty.file=efluidNetBatch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchsefluidNet15
echo ��������������������Ŀ
echo � Batchs efluidNet 1.5  �
echo ����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2-1.5.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidNet1.5 -Dproperty.file=efluidNetBatch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:efluidPub
echo �������������������Ŀ
echo � efluidPub         �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliWeb.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidPub -Dproperty.file=eFluidPub.properties -Dapplication=eFluidPub -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidPub15
echo �������������������Ŀ
echo � efluidPub 1.5        �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=eFluidPub1.5 -Dproperty.file=eFluidPub1.5.properties -Dapplication=eFluidPub -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:AEL
echo ������������������������Ŀ
echo � AEL                    �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliWeb.xml -Dcvs.tag=%TAG_ASS% -Dcontext=AEL -Dproperty.file=AEL.properties -Dapplication=AgenceEnLigne -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:AEL15
echo ������������������������Ŀ
echo � AEL    1.5             �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageWar.xml -Dcvs.tag=%TAG_ASS% -Dcontext=AEL1.5 -Dproperty.file=AEL1.5.properties -Dapplication=AgenceEnLigne -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:efluidProxy
echo ������������������������Ŀ
echo � efluidProxy            �
echo ��������������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageEAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=efluidProxy -Dproperty.file=efluidProxy.properties -Dapplication=efluidProxy -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:applicationeldapJ2EE
echo ��������������������Ŀ
echo � application eldap  �
echo ����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageAppliJ2EE.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdapJ2EE -Dproperty.file=appliLdap.properties -Dapplication=eldap -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:applicationeldapJ2EE15
echo ��������������������Ŀ
echo � application eldap 1.5  �
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
call ant -f %XML_HOME%\j2ee\assemblageBatch2.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdap -Dproperty.file=hermesLdapBatch.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:batchseldap15
echo ��������������������Ŀ
echo � Batchs eldap   1.5    �
echo ����������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageBatch2-1.5.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermesLdap1.5 -Dproperty.file=hermesLdapBatch1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:injecteurs
echo �������������������Ŀ
echo � Injecteurs        �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageInjecteurs.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=injecteurs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:injecteurs15
echo �������������������Ŀ
echo � Injecteurs 1.5     �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageInjecteurs15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=injecteurs1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:extracteurs
echo �������������������Ŀ
echo � extracteurs       �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageExtracteurs.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes -Dproperty.file=extracteurs.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:extracteurs15
echo �������������������Ŀ
echo � extracteurs 1.5   �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageExtracteurs15.xml -Dcvs.tag=%TAG_ASS% -Dcontext=hermes1.5 -Dproperty.file=extracteurs1.5.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu

:archiveur
echo �������������������Ŀ
echo � archiveur         �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=archiveur -Dapplication.name=hermes -Dproperty.file=archiveur.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:archiveur15
echo �������������������Ŀ
echo � archiveur    1.5   �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJAR.xml -Dcvs.tag=%TAG_ASS% -Dcontext=archiveur -Dapplication.name=hermes1.5 -Dproperty.file=archiveur.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR%
cd ..\..
goto menu


:javadoc
echo �������������������Ŀ
echo � JavaDoc           �
echo ���������������������
echo. 
cd j2ee\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\j2ee\assemblageJavaDoc.xml -Dcvs.module=Developpement_dev/Hermes -DexecDir=%EXEC_DIR%
cd ..\..
goto menu



rem ******************************************** T�ches ORACLE

:je
echo �������������������Ŀ
echo � JE               �
echo ���������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageJE.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerJE.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:structureefluid
echo �������������������Ŀ
echo � Structure eFluid  �
echo ���������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerStructureefluid.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


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

:structureefluidNet
echo �����������������������Ŀ
echo � Structure efluidNet   �
echo �������������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerstructureefluidNet.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu


:structureAEL
echo �����������������������Ŀ
echo � Structure AEL         �
echo �������������������������
echo. 
cd oracle\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\oracle\assemblageStructureSchema.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=assemblerstructureAEL.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlDir=%XML_HOME%\oracle -DxmlCommunDir=%XML_HOME%\commun
cd ..\..
goto menu



rem ******************************************** T�ches STREAMSERVE

:streamserve
echo ������������������������Ŀ
echo � StreamServe            �
echo ��������������������������
echo. 
cd streamserve\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\streamserve\assemblageStrS.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=streamserve.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\streamserve
cd ..\..
goto menu


:streamserveClient
echo ������������������������Ŀ
echo � StreamServe            �
echo ��������������������������
echo. 
cd streamserve\cmd
call ..\..\commun\setExecDir.cmd
call ant -f %XML_HOME%\streamserve\assemblageStrS.xml -Dcvs.tag=%TAG_ASS% -Dproperty.file=streamserveClient.properties -Dproperty.file.dir=cmd\parametres -DexecDir=%EXEC_DIR% -DxmlCommunDir=%XML_HOME%\commun -DxmlDir=%XML_HOME%\streamserve
cd ..\..
goto menu



rem ******************************************** T�ches JDK

:jdk15
echo ������������������������Ŀ
echo � Choix JDK 1.5          �
echo ��������������������������
echo. 
call .\commun\setEnv.cmd
set
goto menu


:jdk14
echo ������������������������Ŀ
echo � Choix JDK 1.4          �
echo ��������������������������
echo. 
call .\commun\setEnv14.cmd
set
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
