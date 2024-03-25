# Aidm
## To do:
- ~~remove ffmpeg from installation orion~~
- ~~write script for file conversion with python-ffmpeg~~
- ~~replace ffmpeg usage with python-ffmpeg usage~~
- make relative paths functional for all users or change to absolute paths
- make all all scripts execuatble as non-administrator
	+ Possible way may be by changing `$U2NET_PATH` and re-locating files to `D:\`
- Fix this error
```
param : The term 'param' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
At D:\Aidm\Aidm.ps1:22 char:1                                                                                                                                                                                 + param (
+ ~~~~~                                                                                                                                                                                                           + CategoryInfo          : ObjectNotFound: (param:String) [], CommandNotFoundException
+ FullyQualifiedErrorId : CommandNotFoundException
```