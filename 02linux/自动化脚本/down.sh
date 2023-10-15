#! /bin/bash

mkdir imgs
cd imgs

echo "================"
url=$(curl $1)
echo "================"
echo "Picture Urls:"
echo "______________________________________"
printf " $url"
echo "______________________________________"
i=0

printf "$url" \
|while read -a img;do
  curl $img |base64 -d > pic_${i}.png
  ((i++))
done;

echo "Done!"
