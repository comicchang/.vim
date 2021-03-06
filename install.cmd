@ECHO OFF

CD %~dp0

echo Installing NeoBundle via submodule...
git submodule update --init

FOR %%I in (.gvimrc .vimrc) DO (
    IF EXIST %HOME%\%%I (
        ECHO Backing up %HOME%\%%I -^> %HOME%\%%I.original
        MOVE "%HOME%\%%I" "%HOME%\%%I.original" > NUL
    )
    ECHO Copying %%~fI.win -^> %HOME%\%%I
    COPY "%%~fI.win" %HOME%\%%I > NUL
)

ECHO Install plugin bundles...
vim -u neobundle.vim -Ec "exec 'NeoBundleInstall vimproc' | q"
vim -u neobundle.vim -Ec "exec 'NeoBundleInstall' | q"

ECHO Generating help tags...
vim -Ec "exec 'helptags doc' | q"
