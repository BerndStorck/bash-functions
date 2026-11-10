lse () 
{ 
    local helptext="lse – List files by extension (case-insensitive)

Usage:
  lse EXT
  lse MAXDEPTH EXT
  lse MINDEPTH MAXDEPTH EXT

Examples:
  lse pdf
  lse 2 sh
  lse 1 3 txt

Note: An incorrect number of arguments triggers the Easter egg. 😉  
";
    local shorthelp="Usage:
  lse EXT
  lse MAXDEPTH EXT
  lse MINDEPTH MAXDEPTH EXT

Use one, two or three parameters, no more, no less!
";
    case "$1" in 
        -h | --help | --hilf)
            LANG=C printf "%s\n" "$helptext";
            return 0
        ;;
    esac;
    case "$#" in 
        1)
            find . -maxdepth 1 -type f -iname "*.$1" 2> /dev/null
        ;;
        2)
            find . -maxdepth "$1" -type f -iname "*.$2" 2> /dev/null
        ;;
        3)
            find . -mindepth "$1" -maxdepth "$2" -type f -iname "*.$3" 2> /dev/null
        ;;
        *)
            LANG=C printf "%s\n" "$shorthelp";
            for ((i=1; i<74; i++ ))
            do
                echo -n 'Too Much  ';
                sleep .1;
            done;
            echo;
            command -v yt-dlp --quiet > /dev/null && command -v ffplay -loglevel quiet > /dev/null || { 
                echo "Fehlt: yt-dlp oder ffplay";
                return 1
            };
            echo;
            echo "yt-dlp -f bestaudio -o - "https://www.youtube.com/watch?v=czJ1DjUTiTo" | ffplay -";
            echo;
            yt-dlp --quiet -f bestaudio -o - "https://www.youtube.com/watch?v=czJ1DjUTiTo" 2> /dev/null | ffplay -loglevel quiet -nodisp -autoexit - 2> /dev/null &
        ;;
    esac
}
