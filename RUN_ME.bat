@echo off
echo "******************************************************"
echo "*                  DingDingMultiple                  *"
echo "*                               TIAN                 *"
echo "*                               2023-07              *"
echo "******************************************************"


echo "Find process..."
handle.exe -a "\Sessions\1\BaseNamedObjects\{{239B7D43-86D5-4E5C-ADE6-CEC42155B475}}DingTalk" > process.txt

:: No matching handles found.
findstr "No matching handles found." process.txt > nul &&(
	del process.txt
	goto STRAT_DINGTALK
)||(
	goto PROCESS
) 

:PROCESS
echo "Filter handler info in 1 times"
for /f "tokens=2,3 delims=:" %%i in (process.txt) do (
	echo %%i %%j >> handler.txt
)
echo "Filter handler info in 2 times"
for /f "tokens=1,4 delims= " %%i in (handler.txt) do (
	handle.exe -p %%i -c %%j -y
)
echo "Clear temp files..."
del process.txt
del handler.txt

:STRAT_DINGTALK
echo "Start DingTalk"
"C:\Program Files (x86)\DingDing\DingtalkLauncher.exe"

