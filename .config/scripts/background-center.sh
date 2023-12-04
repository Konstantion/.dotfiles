#!/bin/bash

IMAGE_DIR=~/backgrounds

CURRENT_BG_FILE="$HOME/.config/scripts/temp/.current_bg"

IMAGE_DIR=$(eval echo $IMAGE_DIR)

select_random_image() {
    echo $(ls "$IMAGE_DIR" | shuf -n 1)
}

if [ -f "$CURRENT_BG_FILE" ]; then
    CURRENT_BG=$(cat "$CURRENT_BG_FILE")
else
    CURRENT_BG=""
fi

IMAGE=$(select_random_image)

while [ "$IMAGE" = "$CURRENT_BG" ]; do
    IMAGE=$(select_random_image)
done

FULL_IMAGE_PATH="$IMAGE_DIR/$IMAGE"

feh --bg-center "$FULL_IMAGE_PATH"

echo "$IMAGE" > "$CURRENT_BG_FILE"
