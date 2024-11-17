@ECHO OFF
REM esto es para que no salga cada comando en pantalla!! no sabía!!

:: Guardando la ruta de la plantilla de word, el nombre de plantilla, link a mi correo, y ruta de los libros
SET templateFile=%CD%\formato.docx
SET /p nameAct=<nombreactividades.txt
SET "books="
IF EXIST "%CD%\libros\" SET "books=%CD%\libros"
SET /p email=<correo.txt


:: 1. Mostrando usuario
ECHO Hola %USERNAME%!

:: 2. Mostrar fecha actual
DATE /t

:: Mostrando materia
FOR %%i IN ("%CD%") DO ECHO Estas revisando la materia %%~nxi

:: 3. Mostrar y leer la URL del classroom
set /p classroom=<classroom.txt
echo Abriendo %classroom%

:: 4. Abrir Google Chrome en la página del respectivo classroom
START "" "%classroom%"

:: 5. Pedir al usuario si quiere hacer una nueva tarea, si no quiere ahí termina el script.
ECHO Quieres hacer una nueva tarea?
ECHO 1. SI
ECHO 0. NO


SET /P option=""
IF "%option%" == "0" (
    ECHO Finalizando el script... 
    PAUSE
    EXIT
)

ECHO Creando una nueva tarea...

:: 6. El usuario ingresa el número de actividad (por ejemplo, 4.1)
SET /P newAct="Ingresa la nueva actividad (Por ejemplo, 4.1): "
SET /P newNumberAct="Ingresa el numero de la actividad: "

:: 7. El script partirá del punto para diferenciar la unidad y la actividad (unidad 4 y actividad 1)
    :: con /F puedo dividir texto por medio de un delimitador!!
FOR /F "tokens=1 delims=." %%A IN ("%newAct%") DO SET "unidad=%%A"

:: 8. Si no existe la unidad, crea una carpeta con el número de la unidad y accede a ella, si no, sólo accede a ella
IF NOT EXIST "%CD%\%unidad%" (
    MKDIR "%unidad%"
    CD "%unidad%"
) ELSE (
    CD "%unidad%"
)

:: 9. Crea una nueva carpeta llamada como la unidad y la actividad (por ejemplo, le llamará 4.1)
MKDIR %newAct%
CD %newAct%

:: 10. Copia el archivo plantilla en la nueva carpeta y le cambia el nombre conforme al .txt del nombre de plantilla
COPY "%templateFile%" "%CD%"
SET newNameAct=%nameAct%%newNumberAct%.docx
REN "formato.docx" "%newNameAct%"

:: 11. Abre el archivo Word que fue copiado con el nombre modificado
START %newNameAct%

:: 12. Abre spotify para comenzar a hacer la tarea
START spotify.exe

:: 13. Abre la carpeta de libros, si no existe, que imprima que no hay libros de la materia
    ECHO "%books%"

IF "%books%" == "" (
    ECHO "No hay libros para la materia"
) ELSE (
    START "" explorer "%books%"
)

:: 14. Abre youtube para buscar contenido para la tarea
START "" %email%

:: 15. Para finalizar el programa, imprime un texto confirmando que completó su función y se pausa.

ECHO Proceso finalizado! Puedes comenzar a hace tu tarea.
ECHO Script hecho por Pablo Avelar Armenta
PAUSE