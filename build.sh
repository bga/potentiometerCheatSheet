# PATH=/c/PROGRA~1/ConEmuPack.190108/ConEmu/Scripts:/c/PROGRA~1/ConEmuPack.190108:/c/PROGRA~1/ConEmuPack.190108/ConEmu:/c/Windows/system32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0:/c/PROGRA~1/bin:/e/bin:/i/bin:/usr/bin:/mingw32/bin

buildDir=$TEMP/potentiometerCheatSheet2
mkdir $buildDir

cp -r -u ./dist/* $buildDir 

# start "" //wait cmd //c 'maxima.bat "--batch-string=OUT_DIR: \"$buildDir\"; batch(\"genPlots.max\"); quit();" && exit' 
if [ "$OS" == "Windows_NT" ]; then
  buildDirForMaxima=$(cygpath --windows --absolute "$buildDir" | sed -e 's:\\:\\\\:g')
else
  buildDirForMaxima=buildDir
fi

start "" //wait $COMSPEC //c maxima "--batch-string=OUT_DIR: \"$buildDirForMaxima\"; batch(\"genPlots.max\"); quit();" 
# [https://stackoverflow.com/a/6790967]
sed "/%table%/{
    s/%table%//g
    r $buildDir/table.html
}" template.html > $buildDir/index.html