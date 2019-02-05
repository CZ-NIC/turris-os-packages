#!/bin/sh

# FORIS localization directory of ssbackups
FORIS_SSBACKUPS_LOCALE_DIR="$(dirname "$(opkg files foris-ssbackups-plugin | grep -m 1 'ssbackups/__init__.py')")/locale"


# error messages
ERROR_MESSAGE_GENERAL="Creating an automatic Cloud Backup from your router failed."
ERROR_MESSAGE_GPG="Failed to encrypt the backup."
ERROR_MESSAGE_SIZE="Failed to create backup because of max file size reached."
ERROR_MESSAGE_CONNECT="Failed to connect to the ssbackup server."
ERROR_MESSAGE_PASSWORD="The password to encrypt the backup is not set, although it is required."


create_special_notification() {
    local code="$1"
    local message="_(${ERROR_MESSAGE_GENERAL})"

    case "$code" in
        gpg_error)
            message="$message"$'\n'"_(${ERROR_MESSAGE_GPG})"
            ;;

        max_file_size_error)
            message="$message"$'\n'"_(${ERROR_MESSAGE_SIZE})"
            ;;

        connection_error)
            message="$message"$'\n'"_(${ERROR_MESSAGE_CONNECT})"
            ;;

        missing_password)
            message="$message"$'\n'"_(${ERROR_MESSAGE_PASSWORD})"
            ;;

        *)
            # we don't know the cause of error
            ;;
    esac

    export TEXTDOMAINDIR="$FORIS_SSBACKUPS_LOCALE_DIR"
    export GETTEXT_DOMAIN=messages
    /usr/bin/create_notification -s error "$message"
}


get_code() {
        local cli_message="$1"
        local code

        code="$(echo "$cli_message" | grep -o '"result": *"[^"]*' | grep -o '[^"]*$')"

        echo $code
}


error_detect() {
    local status="$1"
    local result="$2"

    [ "$status" -ne 0 ] && return 1
    echo "$result" | grep -q '"result": *"passed"' || return 1

    return 0
}


# get result from server first
result="$(/usr/bin/foris-client-wrapper -m ssbackups -a create_and_upload)"

if ! error_detect "$?" "$result"; then
        ### handle error
        # 1. get error code from result
        code="$(get_code "$result")"

        # 2. create special notification
        create_special_notification "$code"

        # 3. end with non zero code
        exit 1
fi
