
# Define a function called 'copy_to_clipboard'
function copy_to_clipboard
    set -l input $argv

    # Check if input is empty
    if test -z "$input"
        echo "No input provided."
        return 1
    end

    # Check if the input is a file that exists
    if test -f "$input"
        set input (cat $input)
    end

    # Detect the operating system
    if test (uname) = "Darwin"
        # macOS
        echo -n $input | pbcopy
    else if type -q xclip
        # Linux with xclip
        echo -n $input | xclip -selection clipboard
    else
        echo "pbcopy or xclip not available. Cannot copy to clipboard."
        return 1
    end
end


# Define function called 'paste_from_clipboard'
function  paste_from_clipboard
    set -l input $argv

    # Check if the input is a file that exists
    if test -f "$input"
        echo "No input provided."
        return 1
    end
   
    # Detect the operating system
    if test (uname) = "Darwin"
        # macOS with pbpaste paste from clipboard
        pbpaste > $input 
    else if type -q xclip
        # Linux with xclip paste from clipboard
        xclip -sel clip -o > $input 

    else
        echo "pbpaste or xclip not available. Cannot paste from clipboard."
        return 1
    end 
end 
    
        