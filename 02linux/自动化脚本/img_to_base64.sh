#! /bin/bash
# curl https://fars.ee/jnJP | base64 -d > t.png

ImageFileListGet=(`ls | grep -i -E "png|jpg"`)

# img to base64
    #cat ${ImageFileListGet[i]} |base64 >> base64_tmp_${i}.txt
  for (( i=0; i<${#ImageFileListGet[@]}; i++ )); do
    cat ${ImageFileListGet[i]} |base64 \

    url_1="$(cat ${ImageFileListGet[i]} |base64 \
      |curl -F "c=@-" "https://fars.ee" \
      |grep -E "url" \
      |cut -d' ' -f 2)"
    url_2="\n"
    urls[i]="$url_1$url_2"
  done;

# Printf the urls
      echo "======================================================"
      echo "PIC URLS:"
      echo "${urls[@]}"
      echo "======================================================"
      echo "Download Url: "
      echo "$(echo "${urls[@]}" |curl -F "c=@-" "https://fars.ee" |grep -E "url" |cut -d' ' -f 2)"
      echo "======================================================"

# 将多个url 存储为一个url，方便下载

