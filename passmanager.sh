changeps() {
    case "$1" in
        legacy)
          export PASSWORD_STORE_DIR="$HOME/.password-store"
          ;;
        shared)
            if [ -d "$HOME/.password-stores/shared" ]; then
                export PASSWORD_STORE_DIR="$HOME/.password-stores/shared"
            else
                echo "Password store \"shared\" doesn't exist"
                return 2
            fi
            ;;
        work)
            if [ -d "$HOME/.password-stores/work" ]; then
                export PASSWORD_STORE_DIR="$HOME/.password-stores/work"
            else
                echo "Password store \"work\" doesn't exist"
                return 2
            fi
            ;;
        personal)
            if [ -d "$HOME/.password-stores/personal" ]; then
                export PASSWORD_STORE_DIR="$HOME/.password-stores/personal"
            else
                echo "Password store \"personal\" doesn't exist"
                return 2
            fi
            ;;
        *)
            echo -e "Invalid argument. Available options are:\n"
            printf "%-10s %s\n" "shared"   "Use the shared password store."
            printf "%-10s %s\n" "work"     "Use the work password store."
            printf "%-10s %s\n" "personal" "Use the personal password store."
            ;;
    esac
}

